#!/bin/bash

# Dotfiles Installation Script
# Creates symlinks to restore configuration files

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$DOTFILES_DIR/config"

echo "🚀 Installing dotfiles..."
echo "📁 Dotfiles directory: $DOTFILES_DIR"

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "📦 Backing up existing $target to $target.backup"
        mv "$target" "$target.backup"
    fi
    
    ln -sfn "$source" "$target"
    echo "🔗 Linked $source -> $target"
}

# Function to create directory if it doesn't exist
ensure_dir() {
    [ ! -d "$1" ] && mkdir -p "$1" && echo "📁 Created directory $1"
}

# Install Neovim configuration
if [ -d "$CONFIG_DIR/nvim" ]; then
    echo "📝 Installing Neovim configuration..."
    ensure_dir "$HOME/.config"
    create_symlink "$CONFIG_DIR/nvim" "$HOME/.config/nvim"
fi

# Install Alacritty configuration
if [ -f "$CONFIG_DIR/alacritty/alacritty.yml" ] || [ -f "$CONFIG_DIR/alacritty/alacritty.toml" ]; then
    echo "💻 Installing Alacritty configuration..."
    ensure_dir "$HOME/.config/alacritty"
    [ -f "$CONFIG_DIR/alacritty/alacritty.yml" ] && create_symlink "$CONFIG_DIR/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
    [ -f "$CONFIG_DIR/alacritty/alacritty.toml" ] && create_symlink "$CONFIG_DIR/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
fi

echo "🎉 Installation completed!"
echo ""
echo "Next steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Open Neovim to trigger plugin installation"
echo "3. Configure any remaining personal settings"

# Source zshrc if it exists
if [ -f "$HOME/.zshrc" ]; then
    echo "🔄 Reloading shell configuration..."
    exec zsh || echo "⚠️  Please restart your terminal to apply changes"
fi
