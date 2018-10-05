#!/bin/sh
for dfile in `find -maxdepth 1 -type f | cut -c 3- | grep ^\\\.`
do
  ln -sf ~/dotfiles/${dfile} ~/${dfile}
done
