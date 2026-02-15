# zmodload zsh/zprof

# =============================================================================
# ZSH Configuration
# =============================================================================

# -----------------------------------------------------------------------------
# OS Detection
# -----------------------------------------------------------------------------
case "$(uname -s)" in
  Darwin) __OS="macos" ;;
  Linux) __OS="linux" ;;
  *) __OS="unknown" ;;
esac

# Homebrew prefix detection (works on macOS Intel, Apple Silicon, and Linux)
if [[ -d /opt/homebrew ]]; then
  HOMEBREW_PREFIX="/opt/homebrew"
elif [[ -d /usr/local/Homebrew ]]; then
  HOMEBREW_PREFIX="/usr/local"
elif [[ -d /home/linuxbrew/.linuxbrew ]]; then
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi

# Completion search path (custom completions)
fpath=(~/.config/zsh/completions $fpath)

# -----------------------------------------------------------------------------
# Plugin Management (Antidote)
# -----------------------------------------------------------------------------
# Antidote locations: Homebrew install or git clone to ~/.antidote
if [[ -n "$HOMEBREW_PREFIX" && -f "$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh" ]]; then
  __antidote_path="$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh"
elif [[ -f "$HOME/.antidote/antidote.zsh" ]]; then
  __antidote_path="$HOME/.antidote/antidote.zsh"
fi

if [[ -n "$__antidote_path" ]]; then
  source "$__antidote_path"

  antidote_plugins_txt=${ZDOTDIR:-$HOME}/.zsh_plugins.txt
  antidote_plugins_zsh=${ZDOTDIR:-$HOME}/.zsh_plugins.zsh

  if [[ -f "$antidote_plugins_txt" ]]; then
    if [[ ! -f "$antidote_plugins_zsh" || "$antidote_plugins_txt" -nt "$antidote_plugins_zsh" ]]; then
      antidote bundle <"$antidote_plugins_txt" >|"$antidote_plugins_zsh"
    fi

    source "$antidote_plugins_zsh"
  fi
fi
unset __antidote_path

# Completion init (after plugins so their `fpath` is included)
autoload -Uz compinit
compinit -C

__ensure_completion() {
  local completion_file=$1
  shift

  local -a completion_command=("$@")
  local completion_command_name=$completion_command[1]

  if [[ -f $completion_file ]]; then
    return 0
  fi

  if ! command -v "$completion_command_name" >/dev/null 2>&1; then
    return 0
  fi

  command mkdir -p "${completion_file:h}" 2>/dev/null

  local completion_output
  completion_output="$("${completion_command[@]}")" || return 0

  if [[ -z $completion_output ]]; then
    return 0
  fi

  print -r -- "$completion_output" >|"$completion_file"
  eval "$completion_output"
}

# CLI completions
# Prefer pre-generated files in `~/.config/zsh/completions/`.
# If missing, generate + save, then load for this session.
__ensure_completion ~/.config/zsh/completions/_gh gh completion -s zsh
__ensure_completion ~/.config/zsh/completions/_pnpm pnpm completion zsh
__ensure_completion ~/.config/zsh/completions/_npm npm completion

# -----------------------------------------------------------------------------
# Prompt
# -----------------------------------------------------------------------------
eval "$(starship init zsh)"

# -----------------------------------------------------------------------------
# Locale & Environment
# -----------------------------------------------------------------------------
[[ -f ~/.secrets.zsh ]] && source ~/.secrets.zsh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
if [[ -n ${TTY-} ]]; then
  export GPG_TTY=$TTY
fi
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

# -----------------------------------------------------------------------------
# PATH Configuration
# -----------------------------------------------------------------------------
export PATH="$HOME/.local/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Homebrew binaries (if available)
if [[ -n "$HOMEBREW_PREFIX" ]]; then
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
  # Homebrew ffmpeg@4 (if installed)
  [[ -d "$HOMEBREW_PREFIX/opt/ffmpeg@4/bin" ]] && export PATH="$HOMEBREW_PREFIX/opt/ffmpeg@4/bin:$PATH"
fi

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Java - detect JAVA_HOME based on OS/installation
if [[ -z "$JAVA_HOME" ]]; then
  if [[ "$__OS" == "macos" ]]; then
    # macOS: prefer Homebrew, then system Java
    if [[ -n "$HOMEBREW_PREFIX" && -d "$HOMEBREW_PREFIX/opt/openjdk" ]]; then
      export JAVA_HOME="$HOMEBREW_PREFIX/opt/openjdk"
    elif [[ -x /usr/libexec/java_home ]]; then
      export JAVA_HOME="$(/usr/libexec/java_home 2>/dev/null)" || true
    fi
  elif [[ "$__OS" == "linux" ]]; then
    # Linux: check common locations
    if [[ -d /usr/lib/jvm/default ]]; then
      export JAVA_HOME="/usr/lib/jvm/default" # Arch
    elif [[ -d /usr/lib/jvm/java-21-openjdk-amd64 ]]; then
      export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64" # Debian/Ubuntu
    elif [[ -d /usr/lib/jvm/java-21-openjdk ]]; then
      export JAVA_HOME="/usr/lib/jvm/java-21-openjdk" # Fedora/RHEL
    fi
  fi
fi

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

# Clipboard (Wayland)
if command -v wl-copy &>/dev/null; then
  alias pbcopy='wl-copy'
  alias pbpaste='wl-paste'
fi

# Clawdbot tmux shortcut
alias ctmux="tmux -S /tmp/clawdbot-tmux-sockets/clawdbot.sock"

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
export RBENV_ROOT="${RBENV_ROOT:-$HOME/.rbenv}"
export PATH="$RBENV_ROOT/shims:$PATH"

rbenv() {
  unset -f rbenv
  eval "$(command rbenv init - zsh)"
  rbenv "$@"
}

# Go Version Manager
if [ -f "$HOME/.gvm/scripts/gvm" ]; then
  source $HOME/.gvm/scripts/gvm
fi

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/path.zsh.inc"
fi

# Lazy-load gcloud completions.
# Load once on first ZLE line init so completions are ready
# when you hit <tab>, without blocking shell startup.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  __gcloud_completions_loaded=0

  __load_gcloud_completions_once() {
    if ((__gcloud_completions_loaded == 0)); then
      . "$HOME/google-cloud-sdk/completion.zsh.inc"
      __gcloud_completions_loaded=1
      add-zle-hook-widget -d line-init __load_gcloud_completions_once 2>/dev/null
    fi
  }

  autoload -Uz add-zle-hook-widget
  add-zle-hook-widget line-init __load_gcloud_completions_once
fi

# Lazy-load bun completions.
# Define a stub completion function that loads the real one on first use.
if [ -s "$HOME/.bun/_bun" ]; then
  _bun() {
    source "$HOME/.bun/_bun"
    _bun "$@"
  }

  compdef _bun bun
fi

# zprof

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/home/gordon/.bun/_bun" ] && source "/home/gordon/.bun/_bun"

# OpenClaw Completion
source "/Users/gordon/.openclaw/completions/openclaw.zsh"
