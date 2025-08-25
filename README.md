# Fynn's Dotfiles

Personal development environment configuration files.

## 📁 Structure

```
dotfiles/
├── config/
│   ├── nvim/           # Neovim configuration (LazyVim)
│   ├── zsh/            # Zsh shell configuration
│   ├── git/            # Git configuration
│   ├── alacritty/      # Alacritty terminal configuration
│   └── homebrew/       # Homebrew packages list
├── fonts/              # Programming fonts (Nerd Fonts)
├── scripts/            # Utility scripts
├── backup.sh           # Backup current configs
└── install.sh          # Install/restore configs

```

## 🚀 Quick Setup

### Backup current configuration
```bash
./backup.sh
```

### Restore configuration on new machine
```bash
./install.sh
```

## 📋 What's Included

- **Neovim**: LazyVim configuration with custom themes and plugins
- **Zsh**: Shell configuration and aliases
- **Git**: Global git configuration
- **Alacritty**: Terminal emulator settings
- **Fonts**: Programming fonts (JetBrains Mono, Fira Code, etc.)
- **Homebrew**: Package management and installed packages list

## 🔧 Manual Setup

### Prerequisites
- Homebrew
- Git
- Zsh (default on macOS)

### Step-by-step
1. Clone this repository
2. Run `./install.sh` to create symlinks
3. Install fonts from `fonts/` directory
4. Restore Homebrew packages: `brew bundle install`

## 🔒 Security Notes

This repository excludes:
- SSH private keys
- API tokens and secrets
- Personal passwords
- Sensitive configuration data

## 📝 License

Personal use only.