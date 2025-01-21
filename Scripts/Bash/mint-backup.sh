#!/bin/bash

# Define the backup directory
backup_dir="$HOME/mint-settings-backup"
config_dirs=(".config" ".gnome")

# Create backup directory if it doesn't exist
mkdir -p "$backup_dir"

# Inform the user which directories will be backed up
echo "The following directories will be backed up:"
printf '%s\n' "${config_dirs[@]}"

# Confirmation prompt
read -rp "Do you wish to continue? (y/n) " confirmation
if [[ $confirmation != "y" ]]; then
    echo "Backup cancelled."
    exit 1
fi

# Backing up .local but excluding .local/share
echo "Backing up .local with exclusion of .local/share..."
rsync -av --progress --exclude '.local/share' "$HOME/.local" "$backup_dir"

# Backup Cinnamon settings
echo "Backing up Cinnamon settings..."
dconf dump /org/cinnamon/ > "$backup_dir/cinnamon_desktop_backup"

# Copy config directories with exclusions
for dir in "${config_dirs[@]}"; do
  if [ -d "$HOME/$dir" ]; then
    echo "Backing up $dir..."
    # Adjusting command for .config directory
    if [ "$dir" == ".config" ]; then
      # Create a list of directories to include in backup
      find "$HOME/$dir" -type d -not -path '*google-chrome*' -not -path '*microsoft-edge*' > config_dirs_include.txt
      # Use rsync with --files-from option
      rsync -av --progress --files-from=config_dirs_include.txt --no-relative "$HOME/" "$backup_dir/$dir"
      # Clean up the include list file
      rm config_dirs_include.txt
    else
      cp -r "$HOME/$dir" "$backup_dir/"
    fi
  else
    echo "Directory $dir not found, skipping..."
  fi
done

# Backup dconf settings
echo "Backing up dconf settings..."
dconf dump / > "$backup_dir/dconf-settings-backup.ini"

# Backup ~/.bashrc
echo "Backing up .bashrc..."
cp "$HOME/.bashrc" "$backup_dir/"

# Archive the directory
echo "Creating the archive..."
tar -czvf "$HOME/mint-settings-backup.tar.gz" -C "$backup_dir" .

echo "Backup completed. The archive is located at $HOME/mint-settings-backup.tar.gz"