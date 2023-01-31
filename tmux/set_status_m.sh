#!/usr/local/bin/zsh

window_index="#{window_index}"
window_name="#{window_name}"

function truncate_string {
  local str=$1
  local maxstrlen=$2
  local strlen=${#str}
  if [[ ${strlen} -ge ${maxstrlen} ]]; then
    local str="${str:0:-3}... "
  fi
  echo ${str}
}

# for active pane, hightlight and show additional info
# first argument is #(pane_current_path)
if [[ $# == 1 ]]; then
  window_info="${window_index}:${window_name} "
  current_dir="Pwd:$(basename $1) "
  maxstrlen=24
  current_dir=$( truncate_string ${current_dir} ${maxstrlen} )
  branch="Branch:$(git -C $1 branch --show-current) "
  if [[ $? != 0 ]]; then
    branch=""
  else
    maxstrlen=16
    branch=$( truncate_string ${branch} ${maxstrlen} )
  fi
  format="#[bg=#89dceb,underscore,bold]#{?client_prefix,#[reverse],} "
else
  window_info="${window_index}:${window_name} "
  current_dir=""
  branch=""
  format="#[bg=#cdd6f4] "
fi

res="${format}${window_info}${current_dir}${branch}#[default]"
echo ${res}
