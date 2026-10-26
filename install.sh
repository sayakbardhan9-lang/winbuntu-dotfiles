#!/bin/bash

# Dynamically find the folder where the user cloned this repo
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/winbuntu_backup_$(date +%Y%m%d_%H%M%S)"

echo "🚀 Starting Winbuntu configuration installer..."
echo "📂 Creating a safe backup folder at $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR"

# Helper function to back up and safely symlink configurations
link_config() {
    local source_file="$1"
    local target_file="$2"

    if [ -e "$target_file" ] || [ -L "$target_file" ]; then
        echo "⚠️  Found existing config at $target_file, moving to backup..."
        mv "$target_file" "$BACKUP_DIR/"
    fi

    mkdir -p "$(dirname "$target_file")"
    echo "🔗 Linking $target_file -> $source_file"
    ln -sf "$source_file" "$target_file"
}

# 1. Link the .bashrc file
if [ -f "$REPO_DIR/.bashrc" ]; then
    link_config "$REPO_DIR/.bashrc" "$HOME/.bashrc"
else
    echo "❌ Error: .bashrc not found in the cloned repository."
fi

# 2. Link everything inside the config/ folder to the user's ~/.config/
if [ -d "$REPO_DIR/config" ]; then
    echo "⚙️  Applying desktop and app configurations..."
    for item in "$REPO_DIR/config"/*; do
        if [ -e "$item" ]; then
            filename=$(basename "$item")
            link_config "$item" "$HOME/.config/$filename"
        fi
    done
else
    echo "❌ Error: config/ folder not found in the cloned repository."
fi

# 3. Force KDE Plasma to refresh and load the new configurations immediately
echo "🔄 Refreshing the KDE Plasma desktop to apply the Windows theme..."
if command -v kquitapp6 &> /dev/null; then
    kquitapp6 plasmashell && kstart6 plasmashell > /dev/null 2>&1 &
elif command -v kquitapp5 &> /dev/null; then
    kquitapp5 plasmashell && kstart5 plasmashell > /dev/null 2>&1 &
else
    echo "⚠️  Could not automatically restart desktop shell. Please log out and back in to see visual changes."
fi

echo "✅ Winbuntu setup complete! Run 'source ~/.bashrc' or restart your terminal to finish."
