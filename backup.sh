#!/bin/bash

# Dotfiles Backup Script
# Backs up current configuration files to dotfiles repository

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$DOTFILES_DIR/config"

echo "🔄 Starting dotfiles backup..."
echo "📁 Dotfiles directory: $DOTFILES_DIR"

# Create directories if they don't exist
mkdir -p "$CONFIG_DIR"/{nvim,zsh,git,alacritty,homebrew}
mkdir -p "$DOTFILES_DIR"/{fonts,scripts}

# Backup Neovim configuration
if [ -d "$HOME/.config/nvim" ]; then
    echo "📝 Backing up Neovim configuration..."
    rsync -av --delete "$HOME/.config/nvim/" "$CONFIG_DIR/nvim/"
    echo "✅ Neovim config backed up"
else
    echo "⚠️  Neovim config not found"
fi

# Backup Zsh configuration
echo "🐚 Backing up Zsh configuration..."
[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$CONFIG_DIR/zsh/" && echo "✅ .zshrc backed up"
[ -f "$HOME/.zsh_profile" ] && cp "$HOME/.zsh_profile" "$CONFIG_DIR/zsh/" && echo "✅ .zsh_profile backed up"
[ -f "$HOME/.zprofile" ] && cp "$HOME/.zprofile" "$CONFIG_DIR/zsh/" && echo "✅ .zprofile backed up"

# Backup Git configuration
echo "🔧 Backing up Git configuration..."
[ -f "$HOME/.gitconfig" ] && cp "$HOME/.gitconfig" "$CONFIG_DIR/git/" && echo "✅ .gitconfig backed up"
[ -f "$HOME/.gitignore_global" ] && cp "$HOME/.gitignore_global" "$CONFIG_DIR/git/" && echo "✅ .gitignore_global backed up"

# Backup Alacritty configuration
if [ -f "$HOME/.config/alacritty/alacritty.yml" ] || [ -f "$HOME/.config/alacritty/alacritty.toml" ]; then
    echo "💻 Backing up Alacritty configuration..."
    [ -f "$HOME/.config/alacritty/alacritty.yml" ] && cp "$HOME/.config/alacritty/alacritty.yml" "$CONFIG_DIR/alacritty/" && echo "✅ alacritty.yml backed up"
    [ -f "$HOME/.config/alacritty/alacritty.toml" ] && cp "$HOME/.config/alacritty/alacritty.toml" "$CONFIG_DIR/alacritty/" && echo "✅ alacritty.toml backed up"
else
    echo "⚠️  Alacritty config not found"
fi

# Backup SSH config (excluding keys)
if [ -f "$HOME/.ssh/config" ]; then
    echo "🔑 Backing up SSH configuration..."
    mkdir -p "$CONFIG_DIR/ssh"
    cp "$HOME/.ssh/config" "$CONFIG_DIR/ssh/" && echo "✅ SSH config backed up"
fi

# Generate Homebrew package list
if command -v brew >/dev/null 2>&1; then
    echo "🍺 Generating Homebrew package list..."
    brew list --formula > "$CONFIG_DIR/homebrew/Brewfile.txt" 2>/dev/null || true
    brew list --cask > "$CONFIG_DIR/homebrew/Caskfile.txt" 2>/dev/null || true
    brew bundle dump --file="$CONFIG_DIR/homebrew/Brewfile" --force 2>/dev/null || true
    echo "✅ Homebrew packages listed"
else
    echo "⚠️  Homebrew not found"
fi

# Backup programming fonts
echo "🔤 Backing up fonts..."
if [ -d "$HOME/Library/Fonts" ]; then
    # Only backup Nerd Fonts and programming fonts
    find "$HOME/Library/Fonts" -name "*Nerd*" -o -name "*Mono*" -o -name "Fira*" -o -name "JetBrains*" | \
    while read font; do
        cp "$font" "$DOTFILES_DIR/fonts/" 2>/dev/null || true
    done
    echo "✅ Programming fonts backed up"
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