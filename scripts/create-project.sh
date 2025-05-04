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

if [ -d "$PROJECT_DIR" ]; then
	echo "Error: Directory $PROJECT_DIR already exists"
	exit 1
fi

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

# Generate tmuxp config from template
sed "s/\${project_name}/$PROJECT_NAME/g" "$HOME/dotfiles/tmuxp/new-project.yml" >"$HOME/dotfiles/tmuxp/$PROJECT_NAME.yml"

echo "Project setup completed!"

# Open a new alacritty window with the tmuxp session
alacritty -e tmuxp load "$PROJECT_NAME" &

echo "To start working: tmuxp load $PROJECT_NAME"
