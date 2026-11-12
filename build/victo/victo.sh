#!/bin/bash
declare -a items=("Big Mac" "Quarter Pounder" "McChicken" "10pc McNuggets" "Medium Fries" "Large Fries" "McFlurry" "Coca-Cola" "Iced Coffee")
declare -a prices=(5.99 6.29 4.49 5.49 3.49 4.19 4.29 2.19 2.79)
declare -a cart_items=()
declare -a cart_prices=()

tax_rate=0.08
subtotal=0

wallet_balance=$(awk -v min=15.00 -v max=50.00 'BEGIN {srand(); printf "%.2f", min + rand() * (max - min)}')

print_menu() {
    echo "=========================================="
    echo "       WELCOME TO MCDONALD'S DRIVE-THRU   "
    echo "=========================================="
    echo "  [WALLET BALANCE]: \$${wallet_balance}"
    echo "------------------------------------------"
    for i in "${!items[@]}"; do
        printf "  %d) %-20s \$%.2f\n" $((i+1)) "${items[$i]}" "${prices[$i]}"
    done
    echo "------------------------------------------"
    echo "  0) Finish Order & Pull Forward"
    echo "=========================================="
}

echo "Speaker: *BEEP* Welcome to McDonald's, will you be using your mobile app today?"
read -p "You (y/n): " app_user

if [[ "$app_user" =~ ^[Yy]$ ]]; then
    read -p "Speaker: Awesome, what's your 4-digit code? " code
    echo "Speaker: Got it! Go ahead and order whenever you're ready."
else
    echo "Speaker: No problem, go ahead and order whenever you're ready."
fi
echo ""

while true; do
    print_menu
    read -p "Enter item number: " choice

    if [[ "$choice" == "0" ]]; then
        break
    elif [[ "$choice" =~ ^[1-9]$ ]] && [ "$choice" -le "${#items[@]}" ]; then
        idx=$((choice-1))
        item="${items[$idx]}"
        price="${prices[$idx]}"
        
        read -p "How many ${item}s would you like? " qty
        if ! [[ "$qty" =~ ^[1-9][0-9]*$ ]]; then
            echo "Speaker: Sorry, I didn't catch that quantity. Let's try again."
            continue
        fi

        for ((c=1; c<=qty; c++)); do
            cart_items+=("$item")
            cart_prices+=("$price")
            subtotal=$(awk "BEGIN {print $subtotal + $price}")
        done

        echo "Speaker: Added $qty x $item. Anything else?"
    else
        echo "Speaker: Sorry, we don't have that on the menu. Please pick a valid number."
    fi
    echo ""
done

if [ ${#cart_items[@]} -eq 0 ]; then
    echo "Speaker: Looks like you didn't order anything. Have a great day!"
    exit 0
fi

echo ""
echo "Speaker: Would you like to add a warm Apple Pie for \$1.69 today?"
read -p "You (y/n): " pie_choice
if [[ "$pie_choice" =~ ^[Yy]$ ]]; then
    cart_items+=("Apple Pie")
    cart_prices+=("1.69")
    subtotal=$(awk "BEGIN {print $subtotal + 1.69}")
    echo "Speaker: Added an Apple Pie!"
fi

tax=$(awk "BEGIN {printf \"%.2f\", $subtotal * $tax_rate}")
total=$(awk "BEGIN {printf \"%.2f\", $subtotal + $tax}")

echo ""
echo "=========================================="
echo "               ORDER RECEIPT              "
echo "=========================================="
for i in "${!cart_items[@]}"; do
    printf "  %-24s \$%.2f\n" "${cart_items[$i]}" "${cart_prices[$i]}"
done
echo "------------------------------------------"
printf "  Subtotal:                \$%.2f\n" "$subtotal"
printf "  Tax (8%%):                \$%.2f\n" "$tax"
printf "  TOTAL:                   \$%.2f\n" "$total"
echo "=========================================="
echo "Speaker: Your total is \$$total. Please pull forward to the first window!"
sleep 2

echo ""
echo "*You pull up to Window 1 and open your wallet (Balance: \$$wallet_balance)...*"
sleep 2

can_pay=$(awk "BEGIN {print ($wallet_balance >= $total) ? 1 : 0}")

if [ "$can_pay" -eq 1 ]; then
    remaining_wallet=$(awk "BEGIN {printf \"%.2f\", $wallet_balance - $total}")
    echo "Window 1 Worker: Paid \$$total in cash from your wallet."
    echo "Window 1 Worker: You have \$$remaining_wallet left in your wallet. Thanks!"
else
    short_amount=$(awk "BEGIN {printf \"%.2f\", $total - $wallet_balance}")
    echo "Window 1 Worker: Uh oh... your wallet only has \$$wallet_balance. You're short by \$$short_amount!"
    read -p "Window 1 Worker: Do you want to pay the rest with a card? (y/n): " card_choice
    if [[ "$card_choice" =~ ^[Yy]$ ]]; then
        echo "Window 1 Worker: Card approved! Processing payment..."
    else
    echo "Window 1 Worker: You can't afford this meal! Order cancelled."
        exit 0
    fi
fi

sleep 2
echo ""
echo "*You pull up to Window 2...*"
sleep 1

for item in "${cart_items[@]}"; do
    if [[ "$item" == "McFlurry" ]]; then
        echo "Window 2 Worker: Uh, so sorry, our ice cream machine is actually down right now. Here's a cash refund for the McFlurry!"
        break
    fi
done

echo "Window 2 Worker: Here's your food! Have a nice day!"
