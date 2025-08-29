#!/bin/bash

# Usage: ./tmux_nvim_terminal.sh /path/to/folder [session_name]

# Set defaults
workdir="$HOME/work"
session_name="work"

# Start new tmux session with a window running nvim in the specified directory
tmux new-session -d -s "$session_name" -c "$workdir/webapp" -n app-editor "nvim ."

# Add a second window with just a terminal
tmux new-window -t "$session_name" -n app -c "$workdir/webapp"
tmux new-window -t "$session_name" -n api -c "$workdir/webapi"
tmux new-window -t "$session_name" -n api-editor -c "$workdir/webapi" "nvim ."

# Ensure we focus back on the Neovim window before attaching
tmux select-window -t "$session_name:app-editor"

# Attach to session
tmux attach-session -t "$session_name"

