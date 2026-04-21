#!/bin/bash
# Description: Lists available scripts and allows you to run one by number.

SCRIPT_DIR="$HOME/script"
declare -a script_list

echo -e "\nAVAILABLE SCRIPTS"
echo "========================================"

# Find scripts, exclude this one, and store them in an array
mapfile -t script_list < <(find "$SCRIPT_DIR" -type f -name "*.sh" ! -name "ls-scripts.sh")

# Display the menu
for i in "${!script_list[@]}"; do
    file="${script_list[$i]}"
    rel_path=${file#$SCRIPT_DIR/}
    
    # Extract description
    desc=$(grep -i "^# Description:" "$file" | cut -d ':' -f2- | xargs)
    [[ -z "$desc" ]] && desc="No description provided."

    # Format: [Number] Path | Description
    printf "[%2d] \e[1;32m%-25s\e[0m | %s\n" "$((i+1))" "$rel_path" "$desc"
done

echo "----------------------------------------"
echo "[ q] Exit"
echo "----------------------------------------"

read -p "Select a script to run [1-${#script_list[@]} or q]: " choice

# Logic to run or exit
if [[ "$choice" == "q" ]]; then
    echo "Exiting."
    exit 0
elif [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#script_list[@]}" ]; then
    selected_script="${script_list[$((choice-1))]}"
    echo -e "Executing: $selected_script\n"
    
    # Run the script (using sudo if you want, or just execute)
    # Most of your pacman scripts need sudo anyway
    bash "$selected_script"
else
    echo "Invalid selection."
fi
