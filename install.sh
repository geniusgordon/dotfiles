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

log_copy_file() {
  printf "${BLUE}Copying ${YELLOW}$@${NORMAL}\n"
}

log_git_clone() {
  printf "${BLUE}Cloning ${YELLOW}$@${NORMAL}\n"
}

start_install() {
  printf "${GREEN}Start${NORMAL} install ${YELLOW}$1${NORMAL}\n"
}

finish_install() {
  printf "${GREEN}Finish${NORMAL} install ${YELLOW}$1${NORMAL}\n"
}

install_vimrc() {
  start_install vimrc
  mkdir -p ~/.vim/bundle
  cd ~/.vim/bundle/
  git clone http://github.com/VundleVim/Vundle.vim
  log_copy_file "vimrc"
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
  log_git_clone "zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions

  log_git_clone "zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

  log_git_clone "zsh-syntax-highlighting-filetypes"
  git clone https://github.com/trapd00r/zsh-syntax-highlighting-filetypes ~/.oh-my-zsh/plugins/zsh-syntax-highlighting-filetypes

  # setup theme
  echo "Creating custom theme"
  mkdir -p ~/.oh-my-zsh/custom/themes
  cp ${DIR}/gordon.zsh-theme ~/.oh-my-zsh/custom/themes/gordon.zsh-theme

  # update zshrc
  log_copy_file "zshrc"
  cp ${DIR}/zshrc ~/.zshrc
  finish_install zshrc
}

install_tmux_conf() {
  start_install tmux.conf
  log_copy_file "tmux.conf"
  cp ${DIR}/tmux.conf ~/.tmux.conf
  finish_install tmux.conf
}

install_fonts_conf() {
  start_install fonts.conf
  mkdir -p ~/.config/fonts
  log_copy_file "fonts.conf"
  cp ${DIR}/fonts.conf ~/.config/fontconfig/fonts.conf
  finish_install fonts.conf
}

install_i3_conf() {
  start_install i3
  log_copy_file "i3/config"
  cp -r ${DIR}/i3/ ~/.config/
  log_copy_file "i3blocks/config i3blocks/blocks"
  cp -r ${DIR}/i3blocks/ ~/.config/
  finish_install i3
}

install_dunstrc() {
  start_install dunstrc
  log_copy_file "dunst/dunstrc"
  cp -r ${DIR}/dunst/ ~/.config/
  finish_install dunstrc
}

install_all() {
  install_vimrc
  install_zshrc
  install_tmux_conf
  install_fonts_conf
  install_i3_conf
  install_dunstrc
}

if [ "$#" -eq 0 ]; then
  install_all
fi

case "$@" in
  *-h|--help*)
    echo ""
    echo "  Usage: ${GREEN}./install.sh${NORMAL} <dotfiles ...> [options]"
    echo ""
    echo "  Options:"
    echo ""
    echo "    -h, --help        Show this help message"
    echo "    -l, --list        Show available dotfiles"
    echo ""
    exit 0
    ;;
  *-l|--list*)
    echo ""
    echo "  Available dotfiles:"
    echo ""
    echo "    ${YELLOW}vim/${NORMAL}vimrc"
    echo "    ${YELLOW}zsh/${NORMAL}zshrc"
    echo "    ${YELLOW}tmux/${NORMAL}tmux.conf"
    echo "    ${YELLOW}fonts/${NORMAL}fonts.conf"
    echo "    ${YELLOW}i3/${NORMAL}i3.conf,i3blocks.conf"
    echo "    ${YELLOW}dunst/${NORMAL}dunstrc"
    echo ""
    echo "  use ${GREEN}./install.sh ${BLUE}vim${NORMAL} to install"
    echo ""
    exit 0
    ;;
esac

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
    fonts)
      install_fonts_conf
      shift
      ;;
    i3)
      install_i3_conf
      shift
      ;;
    dunst)
      install_dunstrc
      shift
      ;;
    *)
      echo "No install script for $i"
      ;;
  esac
done
