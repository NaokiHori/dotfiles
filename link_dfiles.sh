#!/usr/local/bin/zsh

for dfile in $(find . -type f -name "\.*" | xargs basename); do
  cmd="ln -sf ~/.dotfiles/${dfile} ~/${dfile}"
  echo ${cmd}
  eval ${cmd}
done
