#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

command_exists() {
  type "$1" &>/dev/null;
}

if command_exists tput; then
  ncolors=$(tput colors)
fi

if [ -t 1 ] && [ -n ${ncolors} ] && [ ${ncolors} -ge 8 ]; then
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
  echo $@
  printf "${NORMAL}"
}

start_install() {
  printf "${GREEN}"
  echo ""
  echo "Start installing $1"
  printf "${NORMAL}"
}

finish_install() {
  printf "${GREEN}"
  echo "Finish installing $1"
  printf "${NORMAL}"
}

install_vimrc() {
  start_install vimrc
  mkdir -p ~/.vim/bundle
  cd ~/.vim/bundle/
  git clone http://github.com/VundleVim/Vundle.vim
  log "Copying vimrc"
  cp ${DIR}/vimrc ~/.vimrc
  vim -c "PluginInstall" -c "qa!"
  finish_install vimrc
}

install_zshrc() {
  start_install zshrc
  # check if zsh exists
  if ! command_exists zsh; then
    echo "zsh is not installed on your system."
    exit 1;
  fi

  # install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed '/env zsh/d')"

  # install zsh-plugins
  log "Cloning zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions

  log "Cloning zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

  log "Cloning zsh-syntax-highlighting-filetypes"
  git clone https://github.com/trapd00r/zsh-syntax-highlighting-filetypes ~/.oh-my-zsh/plugins/zsh-syntax-highlighting-filetypes

  # setup theme
  log "Creating custom theme"
  mkdir -p ~/.oh-my-zsh/custom/themes
  cp ${DIR}/gordon.zsh-theme ~/.oh-my-zsh/custom/themes/gordon.zsh-theme

  # update zshrc
  log "Copying zshrc"
  cp ${DIR}/zshrc ~/.zshrc
  finish_install zshrc
}

install_tmux_conf() {
  start_install tmux.conf
  log "Copying tmux.conf"
  cp ${DIR}/tmux.conf ~/.tmux.conf
  finish_install tmux.conf
}

install_all() {
  install_vimrc
  install_zshrc
  install_tmux_conf
}

if [ "$#" -eq 0 ]; then
  install_all
fi

for i in "$@"
do
  case $i in
    vim)
      install_vimrc
      shift
      ;;
    zsh)
      install_zshrc
      shift
      ;;
    tmux)
      install_tmux_conf
      shift
      ;;
    *)
      echo "No install script for $i"
      ;;
  esac
done
