#!/usr/local/bin/zsh

set -u
set -e

bgcolor="#${1}"
window_width=${2}

function check_wifi () {
  local is_active=$(ifconfig en0 | awk '/status:/{print $2}')
  if [[ "${is_active}" == "active" ]]; then
    local wifi="Wi-Fi"
  else
    local wifi="No Wi-Fi"
  fi
  echo ${wifi}
}

function check_power () {
  local power_rate=$(pmset -g ps | grep -o '[0-9]\+%')
  local is_discharging=$(pmset -g ps | grep -o discharging)
  local power="Bat ${power_rate}"
  echo ${power}
}

function check_memory () {
  local vm_stat=$(vm_stat)
  local pages_free=$(       echo "$vm_stat" | awk '/Pages free/                 {print $3}' | tr -d '.')
  local pages_active=$(     echo "$vm_stat" | awk '/Pages active/               {print $3}' | tr -d '.')
  local pages_inactive=$(   echo "$vm_stat" | awk '/Pages inactive/             {print $3}' | tr -d '.')
  local pages_speculative=$(echo "$vm_stat" | awk '/Pages speculative/          {print $3}' | tr -d '.')
  local pages_wired=$(      echo "$vm_stat" | awk '/Pages wired down/           {print $4}' | tr -d '.')
  local pages_compressed=$( echo "$vm_stat" | awk '/Pages stored in compressor/ {print $5}' | tr -d '.')
  local pages_purgeable=$(  echo "$vm_stat" | awk '/Pages purgeable/            {print $3}' | tr -d '.')
  local pages_file=$(       echo "$vm_stat" | awk '/File-backed pages/          {print $3}' | tr -d '.')
  local pages_app=$(        echo "$vm_stat" | awk '/Anonymous pages/            {print $3}' | tr -d '.')
  local used_and_cached_mem=$(( \
      ${pages_active} \
    + ${pages_inactive} \
    + ${pages_speculative} \
    + ${pages_wired} \
    + ${pages_compressed} \
  ))
  local cached_mem=$(( ${pages_purgeable} + ${pages_file} ))
  local total_mem=$(( ${used_and_cached_mem} + ${pages_free} ))
  local used_mem=$(( ${used_and_cached_mem} - ${cached_mem} ))
  local mem_rate=$(( 100 * ${used_mem} / ${total_mem} ))
  local memory="Mem ${mem_rate}%"
  echo ${memory}
}

# show less info when window size is small
if [ ${window_width} -ge 100 ]; then
  wifi=$(check_wifi)
  power=$(check_power)
  memory=$(check_memory)
  date=$(date "+%d %b %H:%M")
  echo " #[bg=${bgcolor}] ${wifi} | ${power} | ${memory} #[default] #[bg=${bgcolor}] ${date} #[default] "
else
  date=$(date "+%H:%M")
  echo " #[bg=${bgcolor}] ${date} #[default] "
fi
