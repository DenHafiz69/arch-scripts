#!/bin/bash

# Description: Toggles between Cloudflare DNS and DHCP defaults.

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
   echo "Elevating privileges... Please enter your password if prompted."
   exec sudo "$0" "$@"
fi

# Get the active network connection name
CONNECTION=$(nmcli -t -f NAME,STATE connection show --active | grep :activated | cut -d: -f1 | head -n 1)

if [ -z "$CONNECTION" ]; then
    echo "No active network connection found."
    exit 1
fi

show_status() {
    echo "--- Current DNS Settings ---"
    nmcli dev show | grep 'IP4.DNS'
    echo "----------------------------"
}

set_cloudflare() {
    echo "Setting DNS to Cloudflare (1.1.1.1, 1.0.0.1)..."
    nmcli connection modify "$CONNECTION" ipv4.dns "1.1.1.1 1.0.0.1"
    nmcli connection modify "$CONNECTION" ipv4.ignore-auto-dns yes
    # Use --ask to handle the secret requirement and reload the connection
    nmcli connection up "$CONNECTION" --ask
    echo "Done."
}

set_default() {
    echo "Resetting DNS to default (Automatic/DHCP)..."
    nmcli connection modify "$CONNECTION" ipv4.dns ""
    nmcli connection modify "$CONNECTION" ipv4.ignore-auto-dns no
    nmcli connection up "$CONNECTION" --ask
    echo "Done."
}

# CLI Menu
clear
echo "Arch Linux DNS Switcher"
echo "Active Connection: $CONNECTION"
echo "1) Switch to Cloudflare"
echo "2) Switch to Default (DHCP)"
echo "3) Check Current DNS Status"
echo "4) Exit"
read -p "Select an option [1-4]: " choice

case $choice in
    1) set_cloudflare ;;
    2) set_default ;;
    3) show_status ;;
    4) exit 0 ;;
    *) echo "Invalid option." ;;
esac
