# dotfiles

```sh
git clone --recurse-submodules https://github.com/raeperd/dotfiles.git
```

## Brew

Run the install scripts:

```sh
./brew-install.sh        # Non-interactive packages
./brew-install-sudo.sh   # Packages requiring sudo/authentication
```

## mas install

```sh
./mas-install.sh  # kakaotalk, texty
```

## MacOS Settings

keyboard shortcuts -> spotlight disable keyboard shortcuts -> input source

control center > menubar



## Application settings

## cursor

[I can't import profiles - Discussion - Cursor - Community Forum](https://forum.cursor.com/t/i-cant-import-profiles/48702)

- cursor import has issue
- FiraMono Nerd Font

## ohmyzsh

Oh My ZSH is included as a submodule (cloned with `--recurse-submodules`).

- zsh-autosuggestions and zsh-syntax-highlighting installed via brew (in brew-install.sh)

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
