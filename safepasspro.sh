#!/bin/bash

# Author: Sujal Meghwal
# Date: 5/26/2024
# Version: 2.0

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

# --- Trap Ctrl+C ---
trap 'echo -e "\n${RED}Aborted by user.${NC}"; exit 1' INT

# --- Generate password ---
generate_password() {
    local length=$1
    local charset=$2

    if [[ -z "$charset" ]]; then
        charset='A-Za-z0-9_@#%^&+=!'
    fi

    local password
    password=$(< /dev/urandom tr -dc "$charset" | head -c "$length")

    if [[ ${#password} -ne $length ]]; then
        echo -e "${RED}Failed to generate a password of the desired length. Try again.${NC}"
        exit 1
    fi

    echo -e "${GREEN}Generated Password: ${YELLOW}$password${NC}"
}

# --- Usage banner ---
show_banner() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════╗"
    echo "║       Secure Password Generator v2.0     ║"
    echo "╚══════════════════════════════════════════╝"
    echo -e "${NC}"
}

# --- Main ---
show_banner

# Prompt for password length
read -rp "Enter password length: " length

# Validate input
if ! [[ "$length" =~ ^[0-9]+$ ]] || [[ "$length" -lt 6 ]]; then
    echo -e "${RED}Invalid input. Enter a number greater than or equal to 6.${NC}"
    exit 1
fi

# Optional: Ask about special characters
read -rp "Include special characters? (y/n): " use_special

if [[ "$use_special" =~ ^[Yy]$ ]]; then
    charset='A-Za-z0-9_@#%^&+=!'
else
    charset='A-Za-z0-9'
fi

# Call password generator
generate_password "$length" "$charset"
