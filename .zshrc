#!/usr/local/bin/zsh

export LANG=en_US.UTF-8

# enable coloured prompt, use xterm-256color
autoload -Uz colors; colors
export TERM=xterm-256color

# enable completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit; compinit
fi

# vim-like key bind
bindkey -v

# history-related settings
setopt share_history
setopt histignorealldups
setopt nonomatch
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# correct typo automatically
setopt correct

# load auxiliary configs
source ~/.zsh_alias

# unique path
typeset -U path
export PATH=${HOME}/.local/bin:${PATH}

# no python cache
export PYTHONDONTWRITEBYTECODE=1

# prompt info
PROMPT='%F{6}[%n: %c]$%f '

# to avoid MPI warnings
export TMPDIR=/tmp

