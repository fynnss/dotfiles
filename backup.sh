#!/bin/bash

# Dotfiles Backup Script
# Backs up current configuration files to dotfiles repository

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$DOTFILES_DIR/config"

echo "🔄 Starting dotfiles backup..."
echo "📁 Dotfiles directory: $DOTFILES_DIR"

# Create directories if they don't exist
mkdir -p "$CONFIG_DIR"/{nvim,alacritty}

# Backup Neovim configuration
if [ -d "$HOME/.config/nvim" ]; then
    echo "📝 Backing up Neovim configuration..."
    rsync -av --delete "$HOME/.config/nvim/" "$CONFIG_DIR/nvim/"
    echo "✅ Neovim config backed up"
else
    echo "⚠️  Neovim config not found"
fi


# Backup Alacritty configuration
if [ -f "$HOME/.config/alacritty/alacritty.yml" ] || [ -f "$HOME/.config/alacritty/alacritty.toml" ]; then
    echo "💻 Backing up Alacritty configuration..."
    [ -f "$HOME/.config/alacritty/alacritty.yml" ] && cp "$HOME/.config/alacritty/alacritty.yml" "$CONFIG_DIR/alacritty/" && echo "✅ alacritty.yml backed up"
    [ -f "$HOME/.config/alacritty/alacritty.toml" ] && cp "$HOME/.config/alacritty/alacritty.toml" "$CONFIG_DIR/alacritty/" && echo "✅ alacritty.toml backed up"
else
    echo "⚠️  Alacritty config not found"
fi

# Create .gitignore for sensitive files
cat > "$DOTFILES_DIR/.gitignore" << EOF
# Sensitive files
**/*secret*
**/*password*
**/*token*
**/*key*
**/id_rsa*
**/id_ed25519*

# OS files
.DS_Store
Thumbs.db

# Logs
*.log

# Temporary files
*.tmp
*.temp
EOF

echo "🎉 Backup completed successfully!"
echo ""
echo "Next steps:"
echo "1. cd $DOTFILES_DIR"
echo "2. git add ."
echo "3. git commit -m 'Update dotfiles'"
echo "4. git push"
