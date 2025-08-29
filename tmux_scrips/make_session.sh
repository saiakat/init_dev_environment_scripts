#!/bin/bash

read -r -p "What is the session called : " NAME
read -r -p "What is the workdir : " dir 

read -r -p "how many windows will there be : " COUNT


workdir="$HOME/$dir"
declare -A windows

while [[ $COUNT > 0 ]]; do 
  read -r -p "Name of window ($COUNT remaining) : " window_name
  read -r -p "Path of window ($COUNT remaining) : " window
  # Add a second window with just a terminal
  windows["$window_name"]=["$window"]
  ((COUNT--))
done

tmux new-session -d -s "$NAME" -c "$workdir" -n editor "nvim ."

for key in "${!windows[@]}"; do
  value="${windows[$key]}"
  value=$(echo "$value" | sed 's/\[//g')
  value=$(echo "$value" | sed 's/\]//g')
  tmux new-window -t "$NAME" -n $key -c "$workdir/$value"
done

# Ensure we focus back on the Neovim window before attaching
tmux select-window -t "$NAME:editor"

# Attach to session
tmux attach-session -t "$NAME"
