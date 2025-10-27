#!/usr/local/bin/zsh

set -u
set -e

bgcolor="#${1}"
window_width=${2}
is_active=${3}

if [ "${is_active}" = "true" ]; then
  echo "#[bg=${bgcolor}]#{?client_prefix,#[bold#,underscore],} #{window_index}:#{window_name} #[default]"
elif [ ${window_width} -ge 100 ]; then
  echo "#[bg=${bgcolor}]#{?client_prefix,#[reverse],} #{window_index}:#{window_name} #[default]"
else
  echo "#[bg=${bgcolor}]#{?client_prefix,#[reverse],} #{window_index} #[default]"
fi
