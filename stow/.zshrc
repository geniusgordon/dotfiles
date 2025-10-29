plugins=(git pass zsh-autosuggestions zsh-syntax-highlighting colored-man-pages)

export ZSH_THEME="gordon"
export ZSH=${HOME}/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR=nvim
export GPG_TTY=$(tty)

export PATH=$HOME/.local/bin:$PATH

export ANDROID_HOME=$HOME/Library/Android/sdk

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

export PATH="/Users/gordon/.local/share/solana/install/active_release/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export PATH="/opt/homebrew/opt/ffmpeg@4/bin:$PATH"

export JAVA_HOME=/opt/homebrew/Cellar/openjdk/23.0.2

alias glog='git log --oneline --decorate --graph --color | less'
alias ls=lsd
alias vim=nvim
alias vi=nvim
alias vim-nvchad='NVIM_APPNAME=nvchad nvim'
alias vim-lazy='NVIM_APPNAME=lazy-vim nvim'
alias mutt=neomutt

alias diff='nvim -d'
alias vimdiff='nvim -d'
alias view='nvim -R'
alias vimdb="nvim +DBUI"
export MANPAGER='nvim +Man!'
export MANWIDTH=80

export N_PREFIX=$HOME/.local

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi
if [ -f "$HOME/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh" ]; then
  . "$HOME/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh"
fi

function gi() {
  curl -L -s https://www.gitignore.io/api/$@
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd'

eval "$(rbenv init - zsh)"
eval "$(gh completion -s zsh)"

if [ -f "$HOME/.gvm/scripts/gvm" ]; then
  source $HOME/.gvm/scripts/gvm
fi

# check if $THEME is set
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

function tmux_sessionizer() {
  exec </dev/tty
  exec <&1
  tmux-sessionizer
}

zle -N tmux_sessionizer

bindkey '^s' tmux_sessionizer

# Set the history file path
HISTFILE=~/.zsh_history
# Number of commands to remember in the current session
HISTSIZE=100000
# Number of commands to save in the history file
SAVEHIST=100000

# Append history lines as soon as they are entered
setopt INC_APPEND_HISTORY
# Share history across all sessions
setopt SHARE_HISTORY
# Avoid duplicate entries
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
# Remove superfluous blanks
setopt HIST_REDUCE_BLANKS
# Record timestamp of each command
setopt EXTENDED_HISTORY

# Added by Windsurf
export PATH="/Users/gordon/.codeium/windsurf/bin:$PATH"
