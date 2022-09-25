export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=/usr/local/opt/rabbitmq/sbin:$PATH
export PATH=/Applications/calibre.app/Contents/MacOS:$PATH
export PATH=/Users/gordon/Library/Python/3.8/bin:$PATH
export PATH=/Users/gordon/.ebcli-virtual-env/executables:$PATH

export EDITOR=vim
export GPG_TTY=`tty`

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/emulator:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=/Users/gordon/Library/Python/2.7/bin:$PATH

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

alias glog='git log --oneline --decorate --graph --color | less'

export PATH=$HOME/.nvm/versions/node/v16.13.1/bin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
if [ -f "$HOME/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh" ]; then . "$HOME/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh"; fi

function gi() {
  curl -L -s https://www.gitignore.io/api/$@ ;
}

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-syntax-highlighting-filetypes colored-man-pages)
export ZSH_THEME="gordon"
export ZSH=${HOME}/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd'

PATH="/Users/gordon/.local/share/solana/install/active_release/bin:$PATH"
