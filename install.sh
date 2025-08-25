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

# Install Zsh configuration
echo "🐚 Installing Zsh configuration..."
[ -f "$CONFIG_DIR/zsh/.zshrc" ] && create_symlink "$CONFIG_DIR/zsh/.zshrc" "$HOME/.zshrc"
[ -f "$CONFIG_DIR/zsh/.zsh_profile" ] && create_symlink "$CONFIG_DIR/zsh/.zsh_profile" "$HOME/.zsh_profile"
[ -f "$CONFIG_DIR/zsh/.zprofile" ] && create_symlink "$CONFIG_DIR/zsh/.zprofile" "$HOME/.zprofile"

# Install Git configuration
echo "🔧 Installing Git configuration..."
[ -f "$CONFIG_DIR/git/.gitconfig" ] && create_symlink "$CONFIG_DIR/git/.gitconfig" "$HOME/.gitconfig"
[ -f "$CONFIG_DIR/git/.gitignore_global" ] && create_symlink "$CONFIG_DIR/git/.gitignore_global" "$HOME/.gitignore_global"

# Install Alacritty configuration
if [ -f "$CONFIG_DIR/alacritty/alacritty.yml" ] || [ -f "$CONFIG_DIR/alacritty/alacritty.toml" ]; then
    echo "💻 Installing Alacritty configuration..."
    ensure_dir "$HOME/.config/alacritty"
    [ -f "$CONFIG_DIR/alacritty/alacritty.yml" ] && create_symlink "$CONFIG_DIR/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
    [ -f "$CONFIG_DIR/alacritty/alacritty.toml" ] && create_symlink "$CONFIG_DIR/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
fi

# Install SSH configuration
if [ -f "$CONFIG_DIR/ssh/config" ]; then
    echo "🔑 Installing SSH configuration..."
    ensure_dir "$HOME/.ssh"
    create_symlink "$CONFIG_DIR/ssh/config" "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"
fi

# Install fonts
echo "🔤 Installing fonts..."
if [ -d "$DOTFILES_DIR/fonts" ] && [ "$(ls -A $DOTFILES_DIR/fonts)" ]; then
    ensure_dir "$HOME/Library/Fonts"
    cp "$DOTFILES_DIR/fonts"/* "$HOME/Library/Fonts/" 2>/dev/null || true
    echo "✅ Fonts installed"
fi

# Homebrew packages installation
if [ -f "$CONFIG_DIR/homebrew/Brewfile" ] && command -v brew >/dev/null 2>&1; then
    echo "🍺 Installing Homebrew packages..."
    cd "$CONFIG_DIR/homebrew"
    brew bundle install
    echo "✅ Homebrew packages installed"
elif [ -f "$CONFIG_DIR/homebrew/Brewfile" ]; then
    echo "⚠️  Brewfile found but Homebrew is not installed"
    echo "   Install Homebrew first: https://brew.sh"
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