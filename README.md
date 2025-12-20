# Dotfile

# Bootup settings

- Need Apple ID login
- Need touch id setting

# App install

## Brew

Run the install scripts:

```sh
./brew-install.sh        # Non-interactive packages
./brew-install-sudo.sh   # Packages requiring sudo/authentication
```

### Formulae (brew-install.sh)

eza, fzf, gh, go, lazygit, neovim, node, oh-my-posh, pnpm, stow, tmux, zoxide, zsh-autosuggestions, zsh-syntax-highlighting

### Casks (brew-install.sh)

aerospace, claude-code, cursor, ente-auth, font-fira-code-nerd-font, ghostty, helium-browser, linearmouse, obsidian, raycast, ticktick, yaak

### Casks requiring sudo (brew-install-sudo.sh)

1password, karabiner-elements, orbstack, setapp

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

keyboard shortcuts -> spotlight disable keyboard shortcuts -> input source

control center > menubar

```sh
git clone --recurse-submodules https://github.com/raeperd/dotfiles.git
```

# Application settings

## ticktick

- global -> quick add

## cursor

[I can't import profiles - Discussion - Cursor - Community Forum](https://forum.cursor.com/t/i-cant-import-profiles/48702)

- cursor import has issue
- FiraMono Nerd Font

## ohmyzsh

Oh My ZSH is included as a submodule (cloned with `--recurse-submodules`).

- zsh-autosuggestions and zsh-syntax-highlighting installed via brew (in brew-install.sh)

## Zen browser

- `about:config` > `zen.view.experimental-no-window-controls` to false

## Vivaldi Browser

- obsidian clipper

## tmux

TPM is included as a submodule (cloned with `--recurse-submodules`).

```sh
# After stow, reload config and install plugins
tmux source ~/.tmux.conf
# prefix + I to install plugins
```

## gh

```sh
gh auth login
```
