#!/bin/bash
# Description: Ranks the 10 fastest HTTPS Arch mirrors and updates the system mirrorlist.

echo "Optimizing mirrors..."
sudo reflector --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
echo "Done! Mirrorlist updated."
