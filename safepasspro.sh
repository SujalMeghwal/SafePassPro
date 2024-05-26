#!/bin/bash

# Description: A simple password generator script that generates a random password of a specified length.
# Author: Elderblood
# Date: 5/26/2024
# Version: 1.0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to generate a random password
generate_password() {
    local length=$1
    local password
    password=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w"$length" | head -n 1)
    echo -e "${GREEN}Your password: ${YELLOW}$password${NC}"
}

# Prompt the user for the length of the password
read -r -p "Length of Password: " length

# Validate the input
if [[ ! $length =~ ^[0-9]+$ ]] || [[ $length -le 0 ]]; then
    echo -e "${RED}Invalid input. Please enter a positive number.${NC}"
    exit 1
fi

# Generate the password
generate_password "$length"
