#!/bin/bash
# Description: Cleans package cache and user cache.
echo "Cleaning package cache..."
# Keep last 2 versions of installed pkgs, remove all uninstalled pkgs
sudo paccache -rk2
sudo paccache -ruk0

echo "Cleaning user cache..."
rm -rf ~/.cache/*

read -p "Do you want to clear orphan packages? (y/N) " clear_orphans
if [[ "$clear_orphans" =~ ^[Yy]$ ]]; then
    orphans=$(pacman -Qtdq)
    if [ -n "$orphans" ]; then
        echo "Removing orphan packages..."
        sudo pacman -Rns $orphans
    else
        echo "No orphan packages found."
    fi
fi
