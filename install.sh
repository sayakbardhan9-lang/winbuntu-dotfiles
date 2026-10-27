#!/bin/bash

# Dynamically find the folder where the user cloned this repo
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/winbuntu_backup_$(date +%Y%m%d_%H%M%S)"

echo "🚀 Starting Winbuntu configuration installer..."
echo "📂 Creating a safe backup folder at $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR"

# Step 1: STOP PLASMA FIRST so it doesn't overwrite configs on exit
echo "🛑 Temporarily stopping KDE Plasma shell..."
if command -v kquitapp6 &> /dev/null; then
    kquitapp6 plasmashell 2>/dev/null
elif command -v kquitapp5 &> /dev/null; then
    kquitapp5 plasmashell 2>/dev/null
else
    killall plasmashell 2>/dev/null
fi
sleep 2

# Helper function to back up and safely COPY configuration files
copy_config() {
    local source_file="$1"
    local target_file="$2"

    if [ -e "$target_file" ] || [ -L "$target_file" ]; then
        echo "⚠️  Found existing config at $target_file, moving to backup..."
        mv "$target_file" "$BACKUP_DIR/"
    fi

    mkdir -p "$(dirname "$target_file")"
    echo "📄 Copying $source_file -> $target_file"
    cp -rf "$source_file" "$target_file"
}

# 2. Link or copy .bashrc
if [ -f "$REPO_DIR/.bashrc" ]; then
    copy_config "$REPO_DIR/.bashrc" "$HOME/.bashrc"
else
    echo "❌ Error: .bashrc not found in the cloned repository."
fi

# 3. Copy everything inside config/ to ~/.config/
if [ -d "$REPO_DIR/config" ]; then
    echo "⚙️  Applying desktop and app configurations..."
    for item in "$REPO_DIR/config"/*; do
        if [ -e "$item" ]; then
            filename=$(basename "$item")
            copy_config "$item" "$HOME/.config/$filename"
        fi
    done
else
    echo "❌ Error: config/ folder not found in the cloned repository."
fi

# Step 4: RESTART PLASMA cleanly
echo "🔄 Restarting KDE Plasma desktop..."
if command -v kstart6 &> /dev/null; then
    kstart6 plasmashell > /dev/null 2>&1 &
elif command -v kstart5 &> /dev/null; then
    kstart5 plasmashell > /dev/null 2>&1 &
elif command -v plasmashell &> /dev/null; then
    plasmashell > /dev/null 2>&1 &
else
    echo "⚠️  Could not automatically restart desktop shell. Please log out and back in."
fi

echo "✅ Winbuntu setup complete! Run 'source ~/.bashrc' or restart your terminal to finish."
