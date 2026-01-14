# =============================================================================
# ZSH Configuration
# =============================================================================

# -----------------------------------------------------------------------------
# Plugin Management
# -----------------------------------------------------------------------------
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load

# -----------------------------------------------------------------------------
# Prompt
# -----------------------------------------------------------------------------
eval "$(starship init zsh)"

# -----------------------------------------------------------------------------
# Locale & Environment
# -----------------------------------------------------------------------------
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export GPG_TTY=$(tty)
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

# -----------------------------------------------------------------------------
# PATH Configuration
# -----------------------------------------------------------------------------
export PATH="$HOME/.local/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/opt/homebrew/opt/ffmpeg@4/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Java
export JAVA_HOME="/opt/homebrew/Cellar/openjdk/23.0.2"

# Node.js
export N_PREFIX=$HOME/.local

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

# General
alias ls=lsd

# Git
alias glog='git log --oneline --decorate --graph --color | less'

# Neovim
alias vim=nvim
alias vi=nvim
alias diff='nvim -d'
alias vimdiff='nvim -d'
alias view='nvim -R'
alias vimdb="nvim +DBUI"

# Claude Code
alias cc='claude'
export CLAUDE_PLAN="max20x"

# OpenCode
alias oc='opencode'

# Man pages
export MANPAGER='nvim +Man!'
export MANWIDTH=80

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------
function gi() {
  curl -L -s https://www.gitignore.io/api/$@
}

function tmux_sessionizer() {
  exec </dev/tty
  exec <&1
  tmux-sessionizer
}

# -----------------------------------------------------------------------------
# Key Bindings
# -----------------------------------------------------------------------------
zle -N tmux_sessionizer
bindkey -e
bindkey '^s' tmux_sessionizer

# -----------------------------------------------------------------------------
# History Configuration
# -----------------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY

# -----------------------------------------------------------------------------
# Tool Integrations
# -----------------------------------------------------------------------------

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd'

# Theme-based FZF colors
if [ -z $THEME ]; then
  export THEME=catppuccin-mocha
fi

if [ $THEME = "tokyonight" ]; then
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --border
    --color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af7,gutter:#1a1b26
    --color=fg+:#c0caf5,bg+:#292e42,hl+:#7dcfff
    --color=info:#f7768e,prompt:#7dcfff,pointer:#7dcfff
    --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a'
elif [ $THEME = "catppuccin-mocha" ]; then
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --border
    --color=fg:#cdd6f4,bg:#000000,hl:#cba6f7,gutter:#000000
    --color=fg+:#cdd6f4,bg+:#45475a,hl+:#89dceb
    --color=info:#f38ba8,prompt:#89dceb,pointer:#89dceb
    --color=marker:#a6e3a1,spinner:#a6e3a1,header:#a6e3a1'
elif [ $THEME = "kanagawa-dragon" ]; then
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --border
    --color=fg:#c5c9c5,bg:#181616,hl:#938AA9,gutter:#181616
    --color=fg+:#c0caf5,bg+:#223249,hl+:#7FB4CA
    --color=info:#c4746e,prompt:#7dcfff,pointer:#7dcfff
    --color=marker:#87a987,spinner:#87a987,header:#87a987'
fi

# Ruby
eval "$(rbenv init - zsh)"

# GitHub CLI
eval "$(gh completion -s zsh)"

# Go Version Manager
if [ -f "$HOME/.gvm/scripts/gvm" ]; then
  source $HOME/.gvm/scripts/gvm
fi

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# bun completions
[ -s "/Users/gordon/.bun/_bun" ] && source "/Users/gordon/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
