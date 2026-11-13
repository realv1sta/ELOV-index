#!/bin/bash

echo "--- WEDDING SIMULATOR ---"

# 1. Get the names of the happy couple
read -p "Enter the first person's name: " person1
read -p "Enter the second person's name: " person2

# Fallback names if the user just hits Enter
[ -z "$person1" ] && person1="Alex"
[ -z "$person2" ] && person2="Taylor"

# 2. Define arrays for randomization
venues=(
    "a sunlit botanical garden"
    "a cozy rustic barn"
    "a sandy beach at sunset"
    "a grand historic cathedral"
    "a rooftop overlooking the city skyline"
    "the local Taco Bell"
)

officiants=(
    "an Elvis impersonator"
    "a very emotional best friend"
    "a dignified judge"
    "a sea captain"
    "a wise old wizard"
)

vows=(
    "to always share the last slice of pizza"
    "to never look at the next episode without you"
    "to love, honor, and cherish you forever"
    "to always kill the spiders in the house"
    "to stand by your side through thick and thin"
)

songs=(
    "'At Last' by Etta James"
    "'Can't Help Falling in Love' by Elvis Presley"
    "'Never Gonna Give You Up' by Rick Astley"
    "'All of Me' by John Legend"
    "'Africa' by Toto"
)

# Helper function to pick a random item from an array
pick_random() {
    local arr=("$@")
    local count=${#arr[@]}
    local index=$((RANDOM % count))
    echo "${arr[index]}"
}

venue=$(pick_random "${venues[@]}")
officiant=$(pick_random "${officiants[@]}")
vow1=$(pick_random "${vows[@]}")
vow2=$(pick_random "${vows[@]}")
song=$(pick_random "${songs[@]}")

# 3. Run the ceremony
echo ""
echo "=================================================="
echo "Wedding bells are ringing at $venue!"
echo "=================================================="
echo ""
sleep 1.5

echo "Officiant ($officiant): 'Dearly beloved, we are gathered here today"
echo "to join $person1 and $person2 in holy matrimony.'"
echo ""
sleep 2

echo "$person1 looks into $person2's eyes and vows: 'I promise $vow1.'"
sleep 2
echo "$person2 smiles warmly and vows: 'And I promise $vow2.'"
echo ""
sleep 2

echo "Officiant: 'Do you both take each other to be lawfully wedded spouses?'"
sleep 2

# 4. Roll for a runaway bride/groom (30% chance: 0, 1, or 2 out of 0-9)
drama_roll=$((RANDOM % 10))

if [ $drama_roll -lt 3 ]; then
    # Pick who runs away (0 = person1, 1 = person2)
    if [ $((RANDOM % 2)) -eq 0 ]; then
        runaway="$person1"
        left_behind="$person2"
    else
        runaway="$person2"
        left_behind="$person1"
    fi

    echo ""
    echo "$runaway pauses, looks around nervously, and shouts: 'NO! I CAN'T DO THIS!'"
    sleep 1.5
    echo "* Gasps echo across $venue *"
    sleep 1.5
    echo "$runaway bolts out the exit, hops into the bed of a waiting pickup truck, and speeds off into the distance!"
    sleep 1.5
    echo "$left_behind stands at the altar in stunned silence as the officiant awkwardly clears their throat."
    echo ""
    echo "--- WEDDING CANCELED ---"
    exit 0
fi

# 5. Normal ending if nobody runs away
echo "Both $person1 and $person2 say: 'I do!'"
echo ""
sleep 1.5

echo "* They exchange rings *"
echo ""
sleep 1.5

echo "Officiant: 'By the power vested in me, I now pronounce $person1 and $person2 married!'"
echo "You may now kiss!"
echo ""
sleep 2

# 6. The Reception
echo "--- THE RECEPTION ---"
echo "Guests throw confetti as the newlyweds walk down the aisle."
echo "Later that night, $person1 and $person2 share their first dance to $song."
echo "Congratulations to the happy couple!"
