#!/bin/bash

# Script to create a new project with git setup and tmuxp configuration

if [ $# -lt 1 ]; then
	echo "Usage: $0 <project_name> [<description>]"
	echo "Example: $0 my-project \"A cool new project\""
	exit 1
fi

PROJECT_NAME=$1
DESCRIPTION=${2:-"$PROJECT_NAME project"}

# Create project directory
WORKSPACE_DIR="$HOME/workspace"
PROJECT_DIR="$WORKSPACE_DIR/$PROJECT_NAME"

# Flag to track if we're only creating tmuxp config
CREATE_TMUXP_ONLY=false

if [ -d "$PROJECT_DIR" ]; then
	echo "Directory $PROJECT_DIR already exists"
	read -p "Create tmuxp configuration only? (y/n): " ANSWER
	if [[ $ANSWER =~ ^[Yy]$ ]]; then
		CREATE_TMUXP_ONLY=true
	else
		echo "Exiting script"
		exit 1
	fi
fi

if [ "$CREATE_TMUXP_ONLY" = false ]; then
	# Create directory structure
	mkdir -p "$PROJECT_DIR"
	cd "$PROJECT_DIR" || exit 1

	# Initialize git repository
	git init
	echo "# $PROJECT_NAME" >README.md
	echo "" >>README.md
	echo "$DESCRIPTION" >>README.md
	git add README.md
	git commit -m "Initial commit"

	# Create GitHub repository and set as origin
	if command -v gh &>/dev/null; then
		echo "Creating GitHub repository..."
		
		# Use fzf to select visibility if available
		if command -v fzf &>/dev/null; then
			VISIBILITY=$(echo -e "private\npublic" | fzf --prompt="Select repository visibility: " --height=10)
			if [ -z "$VISIBILITY" ]; then
				# Default to private if user cancels fzf
				VISIBILITY="private"
			fi
		else
			# Default to private if fzf is not available
			VISIBILITY="private"
			echo "fzf not found. Defaulting to private repository."
		fi
		
		gh repo create "$PROJECT_NAME" "--$VISIBILITY" --source=. --remote=origin --push
		echo "Created $VISIBILITY GitHub repository: $PROJECT_NAME"
	else
		echo "GitHub CLI not found. Skipping GitHub repository creation."
		echo "Install GitHub CLI with: 'sudo apt install gh' or equivalent for your system."
	fi
fi

# Generate tmuxp config from template
DOTFILES_TMUXP_PATH="$HOME/dotfiles/tmuxp/$PROJECT_NAME.yml"
CONFIG_TMUXP_PATH="$HOME/.config/tmuxp/$PROJECT_NAME.yml"

# Create both files - one in dotfiles for versioning, one in .config for tmuxp to find
if [ -f "$DOTFILES_TMUXP_PATH" ]; then
	echo "Tmuxp configuration already exists at: $DOTFILES_TMUXP_PATH"
	read -p "Overwrite existing tmuxp configuration? (y/n): " OVERWRITE
	if [[ ! $OVERWRITE =~ ^[Yy]$ ]]; then
		echo "Skipping tmuxp configuration creation"
	else
		sed "s/\${project_name}/$PROJECT_NAME/g" "$HOME/dotfiles/tmuxp/new-project.yml" > "$DOTFILES_TMUXP_PATH"
		# Also copy to .config/tmuxp
		cp "$DOTFILES_TMUXP_PATH" "$CONFIG_TMUXP_PATH"
		echo "Tmuxp configuration updated in both locations"
	fi
else
	sed "s/\${project_name}/$PROJECT_NAME/g" "$HOME/dotfiles/tmuxp/new-project.yml" > "$DOTFILES_TMUXP_PATH"
	# Also copy to .config/tmuxp
	cp "$DOTFILES_TMUXP_PATH" "$CONFIG_TMUXP_PATH"
	echo "Tmuxp configuration created in both locations"
fi

if [ "$CREATE_TMUXP_ONLY" = true ]; then
	echo "Tmuxp configuration setup completed!"
else
	echo "Project setup completed!"
fi

# Ask if user wants to open tmuxp session now
read -p "Open tmuxp session now? (y/n): " OPEN_SESSION
if [[ $OPEN_SESSION =~ ^[Yy]$ ]]; then
	# Open a new alacritty window with the tmuxp session
	foot -e tmuxp load "$PROJECT_NAME" &
else
	echo "To start working: tmuxp load $PROJECT_NAME"
fi