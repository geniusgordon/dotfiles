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
alias vim=nvim

export PATH=$HOME/.nvm/versions/node/v16.14.2/bin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

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

source /Users/gordon/.gvm/scripts/gvm
