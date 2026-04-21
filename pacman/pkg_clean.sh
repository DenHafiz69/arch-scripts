#!/bin/bash
# Description: Cleans package cache and user cache.
echo "Cleaning package cache..."
# Keep last 2 versions of installed pkgs, remove all uninstalled pkgs
sudo paccache -rk2
sudo paccache -ruk0

echo "Cleaning user cache..."
rm -rf ~/.cache/*
