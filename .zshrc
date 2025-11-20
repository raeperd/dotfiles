# If you come from bash you might have to change your $PATH.
export PATH=/opt/homebrew/bin:~/go/bin:$PATH

# Source sensitive environment variables (git-ignored)
[ -f ~/.env.sh ] && source ~/.env.sh

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
source ~/.config/zsh/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
	tmux
)

# Only autostart tmux in Ghostty terminal
# ref: https://ghostty.org/docs/help/terminfo
if [ "$TERM" = "xterm-ghostty" ]; then
    ZSH_TMUX_AUTOSTART=true
else
    ZSH_TMUX_AUTOSTART=false
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
export XDG_CONFIG_HOME=$HOME/.config

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# https://ohmyposh.dev/docs/installation/prompt
# https://ohmyposh.dev/docs/installation/customize
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.omp.json)"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- Eza (better ls) -----
alias ls="eza --icons=always"

alias k="kubectl"

alias n="nvim"
alias v="nvim"
alias kn="NVIM_APPNAME=kickstart nvim"

alias lg="lazygit"

fn() {
  local search_dir="${1:-.}"  # Use first argument if provided, otherwise use current dir (.)
  
  if [ ! -d "$search_dir" ]; then
    echo "Error: '$search_dir' is not a valid directory"
    return 1
  fi

  cd "$search_dir"
  local files=$(fzf --preview 'bat --style=numbers --color=always {}' --height 40% --layout=reverse)
  if [ -n "$files" ]; then
    nvim "$files"
  fi
  cd - > /dev/null  # Return to original directory silently
}

# Function to search file names and open with Cursor
ffc() {
    local dir="${1:-.}"
    cd "$dir" && \
    find . -type f | \
    fzf --preview 'bat --color=always --style=numbers {}' \
        --preview-window 'right:50%' \
        --header 'Search file names (Cursor)' | \
    xargs -r cursor && \
    cd - > /dev/null
}

# Function to search file names and open with Neovim
ff() {
    local dir="${1:-.}"
    cd "$dir" && \
    find . -type f | \
    fzf --preview 'bat --color=always --style=numbers {}' \
        --preview-window 'right:50%' \
        --header 'Search file names (Neovim)' | \
    xargs -r nvim && \
    cd - > /dev/null
}

# Function to search and open with Cursor (hidden files, exclude .git)
fgc() {
    local dir="${1:-.}"
    cd "$dir" && \
    fzf --ansi \
        --bind 'change:reload:rg --hidden --glob "!.git/*" --column --line-number --no-heading --color=always --smart-case {q} . || true' \
        --delimiter : \
        --preview 'bat --color=always --highlight-line {2} --style=numbers {1}' \
        --preview-window 'right:50%:+{2}+3/3:~3' \
        --phony \
        --header 'Search text in files (Cursor)' | \
    awk -F: '{print $1":"$2":"$3}' | xargs -r -I {} cursor --goto {} && \
    cd - > /dev/null
}

# Function to search and open with Neovim (hidden files and dirs, exclude .git)
fg() {
    local dir="${1:-.}"
    cd "$dir" && \
    fzf --ansi \
        --bind 'change:reload:rg --hidden --glob "!.git/*" --column --line-number --no-heading --color=always --smart-case {q} . || true' \
        --delimiter : \
        --preview 'bat --color=always --highlight-line {2} --style=numbers {1}' \
        --preview-window 'right:50%:+{2}+3/3:~3' \
        --phony \
        --header 'Search text in files (Neovim)' | \
    while IFS=: read -r file line col rest; do
        [[ -n "$file" ]] && nvim "+$line" "$file"
    done && \
    cd - > /dev/null
}

alias alpha='aws-vault exec daangn/alpha --'
eval "$(direnv hook zsh)"

# asdf 
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# pnpm
export PNPM_HOME="/Users/raeperd.117/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


. "$HOME/.local/bin/env"

# bun completions
[ -s "/Users/raeperd.park/.bun/_bun" ] && source "/Users/raeperd.park/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias cl='claude --dangerously-skip-permissions' 

# ---- Zoxide (better cd) ----
if [[ "$CLAUDECODE" != "1" ]]; then
    eval "$(zoxide init --cmd cd zsh)"
fi
