#!/bin/bash

if which tput >/dev/null 2>&1; then
  ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi

log() {
  printf "${BLUE}"
  echo $1
  printf "${NORMAL}"
}

command_exists() {
  type "$1" &>/dev/null;
}

# check if zsh exists
if ! command_exists zsh; then
  echo "zsh is not installed on your system."
  exit 1;
fi

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo ''
# install zsh-plugins
log 'Cloning zsh-autosuggestions'
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions

log 'Cloning zsh-syntax-highlighting'
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

log 'Cloning zsh-syntax-highlighting-filetypes'
git clone https://github.com/trapd00r/zsh-syntax-highlighting-filetypes ~/.oh-my-zsh/plugins/zsh-syntax-highlighting-filetypes

echo ''
# setup theme
log 'Creating custom theme'
mkdir -p ~/.oh-my-zsh/custom/themes
cp ~/.oh-my-zsh/themes/robbyrussell.zsh-theme ~/.oh-my-zsh/custom/themes/gordon.zsh-theme
ret_status='local ret_status="%(?:%{$bg[blue]%}:%{$bg[red]%}) %M %{$reset_color%}"'

echo ''
# update zshrc
log 'Updating zshrc'
plugins='(git zsh-autosuggestions zsh-syntax-highlighting zsh-syntax-highlighting-filetypes)'
sed -i "1,\$s/^plugins=.*/plugins=${plugins}/" ~/.zshrc

sed -i "1s/.*/${ret_status}/" ~/.oh-my-zsh/custom/themes/gordon.zsh-theme
sed -i '1,$s/^ZSH_THEME=.*/ZSH_THEME="gordon"/' ~/.zshrc

printf "${GREEN}"
echo ''
echo 'Done'
echo ''
printf "${NORMAL}"

