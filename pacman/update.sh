#!/bin/bash
# Description: Full system sync including AUR and service health check.

echo "--- Starting System Update ---"
paru

echo "--- Checking for Orphans ---"
pacman -Qtdq

echo "--- Checking for Failed Services ---"
systemctl --failed

echo "--- Update Complete ---"
