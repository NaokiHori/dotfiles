#!/usr/local/bin/zsh

set -u
set -e

bgcolor="#${1}"
window_width=${2}
pane_current_path="${3}"

function truncate_string () {
  local str=${1}
  local maxstrlen=${2}
  local strlen=${#str}
  if [ ${strlen} -ge ${maxstrlen} ]; then
    min=0
    max=$(( ${maxstrlen} - 3 ))
    str="${str:${min}:${max}}..."
  fi
  echo ${str}
}

function check_current_dir () {
  local current_dir=$(basename ${pane_current_path})
  current_dir=$(truncate_string ${current_dir} 16)
  echo ${current_dir}
}

function check_git_branch () {
  local branch=$(git -C ${pane_current_path} branch --show-current)
  if [ "${branch}" = "" ]; then
    branch="N/A"
  else
    branch=$(truncate_string ${branch} 16)
  fi
  echo ${branch}
}

# show less info when window size is small
current_dir=$(check_current_dir)
if [ ${window_width} -ge 100 ]; then
  branch=$(check_git_branch)
  echo " #[bg=${bgcolor}] ${current_dir} | ${branch} #[default] "
else
  echo " #[bg=${bgcolor}] ${current_dir} #[default] "
fi
