# Dotfile

# Bootup settings

- Need Apple ID login
- Need touch id setting

# App install

## Brew

```
brew install ghostty stow tmux gh lazygit fzf fd neovim aerospace eza zoxide go node jq 1password-cli jandedobbeleer/oh-my-posh/oh-my-posh gh
```

### cask

```
brew install --cask setapp raycast obsidian vivaldi ticktick setapp orbstack cursor intellij-idea karabiner-elements linearmouse 1password ente-auth slack nikitabobko/tap/aerospace spotify visual-studio-code yaak
```

karabiner needs password

### font

```
brew tap homebrew/cask-fonts && brew install --cask font-fira-mono-nerd-font
```

## mas install

### kakaotalk

```
brew install mas && mas install 869223134
```

### texty

```
mas install 1538996043
```

- <https://apps.apple.com/kr/app/texty-for-google-messages/id1538996043?l=en-GB&mt=12>

## go

```
go install github.com/josharian/impl@latest
```

# MacOS Settings

시스템 설정 -> 키보드 -> 텍스트 입력 -> 수정
맞춤법 자동수정
자동으로 대문자 시작

언어 및 지역 -> 영어 -> 재시작

keyboard shortcuts -> spotlight disable  keyboard shortcuts -> input source

control center > menubar

git clone <https://github.com/raeperd/dotfiles.git>

# Application settings

## ticktick

- global -> quick add

## cursor

[I can't import profiles - Discussion - Cursor - Community Forum](https://forum.cursor.com/t/i-cant-import-profiles/48702)

- cursor import has issue
- FiraMono Nerd Font

## ohmyzsh

[ohmyzsh/tools/install.sh at master · ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh/blob/master/tools/install.sh)

- --keep-zshrc: sets KEEP_ZSHRC to 'yes'

```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

## Zen browser

- `about:config` > `zen.view.experimental-no-window-controls` to false

## Vivaldi Browser

- obsidian clipper

## tmux

### install tpm

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# type this in terminal if tmux is already running
tmux source ~/.tmux.conf
# prefix + I to install plugins
```

## gh

```sh
gh auth login
```
