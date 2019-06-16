# .zshrc

# enable color
autoload -Uz colors
colors
# enable completion
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit
compinit -u
# key bind
bindkey -v
# history-related settings
setopt share_history
setopt histignorealldups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# correct typo automatically
setopt correct

# User specific aliases and functions
alias vi="mvim -v -u $HOME/.vimrc"
alias gl='git log --all --date-order --graph --oneline --decorate'
alias ls='ls -G'
alias la='ls -alG'
alias ll='ls -lG'
alias grep='grep --color'
function chpwd() { ls }
#  simulation-related alias
alias paraview='open -a Paraview-5.6.0.app'
alias parallel='docker run --rm -it -v ${PWD}:/project naokihori/parallel_fftw'
alias single='docker run --rm -it -v ${PWD}:/project naokihori/single_fftw'
# tex-related alias
alias preview='open -a Preview'
alias bibdesk='open -a BibDesk'

export PYTHONDONTWRITEBYTECODE=1

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

# remove overlapped path from $PATH
_path=""
for _p in $(echo $PATH | tr ':' ' '); do
  case ":${_path}:" in
    *:"${_p}":* )
      ;;
    * )
      if [ "$_path" ]; then
        _path="$_path:$_p"
      else
        _path=$_p
      fi
      ;;
  esac
done
PATH=$_path

unset _p
unset _path

# prompt info
PROMPT='[%m: %c]$ '
