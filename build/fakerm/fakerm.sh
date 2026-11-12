
#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

clear

echo -e "${RED}"
echo "WARNING: You are about to delete the entire root filesystem."
echo -e "${RESET}"

read -rp "Are you sure you want to continue? [y/N] " answer

if [[ ! "$answer" =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}Operation cancelled.${RESET}"
    exit 0
fi

echo
sleep 1

if [[ -f "./rm-output.log" ]]; then
    cat ./rm-output.log
fi

echo
