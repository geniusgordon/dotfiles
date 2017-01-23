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

log () {
  printf "${BLUE}"
  echo $1
  printf "${NORMAL}"
}

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp ${DIR}/vimrc ~/.vimrc
mkdir -p ~/.vim/bundle
cd ~/.vim/bundle/
git clone http://github.com/VundleVim/Vundle.vim
vim +PluginInstall

