# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias vi='vim'
alias git-log='git log --all --date-order --graph --oneline --decorate'

if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi
export PYTHONDONTWRITEBYTECODE=1
export OMP_NUM_THREADS=4
