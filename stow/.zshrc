plugins=(git pass zsh-autosuggestions zsh-syntax-highlighting colored-man-pages)

export ZSH_THEME="gordon"
export ZSH=${HOME}/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR=nvim
export GPG_TTY=`tty`

export PATH=$HOME/.local/bin:$PATH

export ANDROID_HOME=$HOME/Library/Android/sdk

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

export PATH="/Users/gordon/.local/share/solana/install/active_release/bin:$PATH"

export JAVA_HOME=/opt/homebrew/Cellar/openjdk/17.0.2

alias glog='git log --oneline --decorate --graph --color | less'
# alias ls=colorls
alias vim=nvim
alias vi=nvim
alias mutt=neomutt
alias diff='nvim -d'
# make vimdiff execute nvim in diff mode
alias vimdiff='nvim -d'

export N_PREFIX=$HOME/.local

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/path.zsh.inc";
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/completion.zsh.inc";
fi
if [ -f "$HOME/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh" ]; then
  . "$HOME/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh";
fi

function gi() {
  curl -L -s https://www.gitignore.io/api/$@ ;
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd'

eval "$(rbenv init - zsh)"

if [ -f "$HOME/.gvm/scripts/gvm" ]; then
  source $HOME/.gvm/scripts/gvm
fi

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
