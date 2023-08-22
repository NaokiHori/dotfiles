#!/usr/local/bin/zsh

set -e
set -u
set -x

for file in $(find . -type f -name "\.*" | xargs basename); do
  ln -sf ~/.dotfiles/${file} ~/${file}
done
