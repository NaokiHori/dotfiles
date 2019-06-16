# .bashrc

function _reset_path {
  local p
  for p in PATH; do
    local ip=$(eval echo "\$INIT_$p")
    if [ -z "$ip" ]; then
      eval export INIT_$p="\$$p"
    else
      eval export $p="$ip"
    fi
  done
}
_reset_path

export PATH=$HOME/.local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$HOME

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific aliases and functions
VIM=~/.vim
XDG_CONFIG_HOME=~/.config
alias vi="nvim -u $HOME/.vimrc"
alias gl='git log --all --date-order --graph --oneline --decorate'
alias pcs='pycodestyle'
alias bring='cp ~/fluid/storage/movie.py .'
# personal
if [ -f ~/.others ]; then
  source ~/.others
fi
# tex
if [ -f ~/.texrc ]; then
  source ~/.texrc
fi
# local libraries
export PATH=$HOME/.local/bin:$PATH
export CPATH=/home/naokihori/.local/include
export MANPATH=/usr/local/texlive/2019/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2019/texmf-dist/doc/info:$INFOPATH
export PATH=/usr/local/texlive/2019/bin/x86_64-linux:$PATH
# git completion
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi
export PYTHONDONTWRITEBYTECODE=1
export OMP_NUM_THREADS=4
# debug
ulimit -c unlimited
alias grep='grep --color'

# entering tmux
export TERM=xterm-256color
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
  if is_screen_or_tmux_running; then
    ! is_exists 'tmux' && return 1
    if is_screen_running; then
      echo "This is on screen."
    fi
  else
    if shell_has_started_interactively && ! is_ssh_running; then
      if ! is_exists 'tmux'; then
        echo 'Error: tmux command not found' 2>&1
        return 1
      fi
      if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
        # detached session exists
        tmux list-sessions
        echo -n "Tmux: attach? (y/N/num) "
        read
        if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
          tmux attach-session
          if [ $? -eq 0 ]; then
            echo "$(tmux -V) attached session"
            return 0
          fi
        elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
          tmux attach -t "$REPLY"
          if [ $? -eq 0 ]; then
            echo "$(tmux -V) attached session"
            return 0
          fi
        fi
      fi
      if is_osx && is_exists 'reattach-to-user-namespace'; then
        tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
        tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
      else
        tmux new-session
      fi
    fi
  fi
}
tmux_automatically_attach_session
source $HOME/.dotfiles/.tmux/rename

PS1="[UT-Desktop \W]$ "
