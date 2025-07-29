# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Architecture

This is a personal dotfiles repository that manages configuration files for a macOS development environment using **GNU Stow for symlink management**. Changes made to files in this repository have **global system effect** as they are symlinked to their actual locations in the home directory.

**Critical**: Modifications to any configuration file in this repository immediately affect the live system configuration through stow symlinks.

The configuration uses a **unified approach** where a single nvim config works for both terminal and VS Code environments through conditional loading.

### Key Configuration Structure

- **Shell Environment**: ZSH with Oh My ZSH, custom themes, and environment management through `.env.sh`
- **Terminal Multiplexing**: tmux with custom prefix (C-a), plugin management via TPM
- **Text Editors**: 
  - Neovim with LazyVim framework + VS Code integration (unified config in `.config/nvim/`)
  - VS Code specific settings in `.vscode/`
- **Terminal Emulators**: Configurations for Alacritty, Wezterm, and Ghostty
- **Window Management**: AeroSpace tiling WM with borders integration
- **Development Tools**: Git, GitHub CLI, Lazygit, various language-specific configs
- **Application Configs**: Raycast, Karabiner, Obsidian, and other productivity tools

### Installation & Setup Commands

```bash
# GNU Stow setup (symlinks configurations to home directory)
# Run from within the dotfiles repository (/Users/raeperd.park/dotfiles)
stow .

# Initial environment setup (requires manual steps - see README.md)
brew install ghostty stow tmux gh lazygit fzf fd neovim aerospace eza zoxide go node jq 1password-cli jandedobbeleer/oh-my-posh/oh-my-posh gh

# Cask applications
brew install --cask setapp raycast obsidian vivaldi ticktick setapp orbstack cursor intellij-idea karabiner-elements linearmouse 1password ente-auth slack nikitabobko/tap/aerospace spotify visual-studio-code yaak

# Font installation
brew tap homebrew/cask-fonts && brew install --cask font-fira-mono-nerd-font

# Oh My ZSH plugins (manual installation required)
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Tmux Plugin Manager setup
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Then: tmux source ~/.tmux.conf && prefix + I

# GitHub CLI authentication
gh auth login
```

### Environment Management

- **Sensitive Configuration**: `.env.sh` (git-ignored) sourced by `.zshrc` for API keys and private settings
- **Example Template**: `.env.example.sh` shows required environment variables
- **Path Configuration**: Homebrew, Go binaries, and custom paths managed in `.zshrc`

### Neovim Integration Architecture

The nvim configuration uses a **unified approach** with conditional loading:

- **Location**: `.config/nvim/` (LazyVim-based)
- **VS Code Detection**: Early return pattern in `lua/config/keymaps.lua` using `vim.g.vscode`
- **Conditional Loading**: VS Code gets essential workbench keymaps, terminal gets full LazyVim
- **Plugins**: Managed through LazyVim with conditional loading based on environment
- **Legacy Config**: `.config/vscode-neovim/` directory can be removed (functionality merged)

### Terminal & Multiplexer Setup

- **Tmux Prefix**: `C-a` (not default `C-b`)
- **Plugin System**: TPM (Tmux Plugin Manager) with Catppuccin theming
- **Navigation Integration**: nvim-tmux-navigation for seamless pane switching
- **Session Management**: tmux-sessionx and tmux-resurrect for persistence

### Theme & Appearance

- **Color Scheme**: Catppuccin (Mocha variant) applied consistently across:
  - Terminal emulators (Alacritty, Wezterm, Ghostty)
  - Tmux status line and panes  
  - Neovim colorscheme
  - ZSH syntax highlighting
  - Bat (code highlighting)
- **Fonts**: FiraMono Nerd Font for consistent icon support

### Development Workflow Integration

- **Git Configuration**: Multi-account setup with automatic switching (work/personal repos)
- **GitHub CLI**: Configured for repository management and authentication
- **Lazygit**: TUI for Git operations with custom keybindings
- **Language Tools**: Go toolchain, Node.js, Python (uv), various LSPs through nvim

### Application-Specific Notes

- **Raycast**: Extensive script collection for productivity automation
- **Karabiner**: Complex key remapping with automatic backups
- **AeroSpace**: Tiling window manager with borders integration for visual feedback
- **Obsidian**: Custom CSS and clipper configurations for note-taking workflow