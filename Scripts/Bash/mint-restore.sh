#!/bin/bash

# Define the backup directory
backup_dir="$HOME/mint-settings-backup"

# Ensure the backup archive exists
if [ ! -f "$HOME/mint-settings-backup.tar.gz" ]; then
    echo "Backup archive not found in $HOME."
    exit 1
fi

# Extract the backup archive
echo "Extracting the backup archive..."
tar -xzvf "$HOME/mint-settings-backup.tar.gz" -C "$HOME"

# Restore configurations
config_dirs=("$backup_dir/.cinnamon" "$backup_dir/.config" "$backup_dir/.gnome" "$backup_dir/.local")

echo "The following directories will be restored:"
printf '%s\n' "${config_dirs[@]}"

# Confirmation prompt
read -rp "Do you wish to continue with the restoration? (y/n) " confirmation
if [[ $confirmation != "y" ]]; then
    echo "Restore cancelled."
    exit 1
fi

for dir in "${config_dirs[@]}"; do
  base_dir=$(basename "$dir")
  if [ -d "$dir" ]; then
    echo "Restoring $base_dir..."
    cp -r "$dir/" "$HOME/$base_dir"
  else
    echo "Backup for $base_dir not found, skipping..."
  fi
done

# Restore dconf settings
echo "Restoring dconf settings..."
dconf load / < "$backup_dir/dconf-settings-backup.ini"

echo "Restore completed. Please log out and log back in for all changes to take effect."
