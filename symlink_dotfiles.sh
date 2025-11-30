#!/usr/zsh

set -e
set -u
set -x

function setup_symlink () {
  file_name=${1}
  ln -sf ~/dotfiles/${file_name} ~/${file_name}
}

setup_symlink .tmux.conf
setup_symlink .zsh_alias
setup_symlink .zshrc

ln -s ~/dotfiles/nvim ~/.config/nvim
