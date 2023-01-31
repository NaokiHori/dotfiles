#!/usr/local/bin/zsh


sessions=$(tmux list-sessions -F "#{session_name} #{session_created}" | sort -k 2)
counter=0
for session in ${(f)sessions}; do
  session_name=$(echo ${session} | awk '{print $1}')
  session_date=$(echo ${session} | awk '{print $2}')
  tmux rename-session -t ${session_name} ${counter}
  counter=$(($counter+1))
done
