#!/usr/local/bin/zsh

bgcolor="#f5c2e7"

# wifi connection
is_active=$(ifconfig en0 | awk '/status:/{print $2}')
if [[ "${is_active}" == "active" ]]; then
  wifi="#[bg=#${bgcolor},bold,underscore] Wi-Fi #[default]"
else
  wifi="#[bg=#${bgcolor}                ] Wi-Fi #[default]"
fi

# power
power_rate=$(pmset -g ps | grep -o '[0-9]\+%')
is_discharging=$(pmset -g ps | grep -o discharging)
if [[ "${is_discharging}" == "discharging" ]]; then
  power="#[bg=#${bgcolor}                ] Bat ${power_rate} #[default]"
else
  power="#[bg=#${bgcolor},bold,underscore] Bat ${power_rate} #[default]"
fi

# memory
vm_stat=$(vm_stat)
pages_free=$(       echo "$vm_stat" | awk '/Pages free/                 {print $3}' | tr -d '.')
pages_active=$(     echo "$vm_stat" | awk '/Pages active/               {print $3}' | tr -d '.')
pages_inactive=$(   echo "$vm_stat" | awk '/Pages inactive/             {print $3}' | tr -d '.')
pages_speculative=$(echo "$vm_stat" | awk '/Pages speculative/          {print $3}' | tr -d '.')
pages_wired=$(      echo "$vm_stat" | awk '/Pages wired down/           {print $4}' | tr -d '.')
pages_compressed=$( echo "$vm_stat" | awk '/Pages stored in compressor/ {print $5}' | tr -d '.')
pages_purgeable=$(  echo "$vm_stat" | awk '/Pages purgeable/            {print $3}' | tr -d '.')
pages_file=$(       echo "$vm_stat" | awk '/File-backed pages/          {print $3}' | tr -d '.')
pages_app=$(        echo "$vm_stat" | awk '/Anonymous pages/            {print $3}' | tr -d '.')
used_and_cached_mem=$(($pages_active + $pages_inactive + $pages_speculative + $pages_wired + $pages_compressed))
cached_mem=$(($pages_purgeable + $pages_file))
total_mem=$(($used_and_cached_mem + $pages_free))
used_mem=$(($used_and_cached_mem - $cached_mem))
free_mem=$(($total_mem - $used_mem))
mem_rate=$((100 * ${used_mem} / ${total_mem}))
memory="#[bg=#${bgcolor}] Mem ${mem_rate}% #[default]"

# date
date=$(date +"%d %b %H:%M")
date="#[bg=${bgcolor}] ${date} #[default]"

# show less when window size is small
width=${1}
if [ ${width} -lt 100 ]; then
  res=" ${date} "
else
  res=" ${wifi} ${power} ${memory} ${date} "
fi
echo ${res}
