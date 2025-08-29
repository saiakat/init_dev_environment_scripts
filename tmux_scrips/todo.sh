#!/bin/bash

# Usage: ./tmux_nvim_terminal.sh /path/to/folder [session_name]

# Set defaults
workdir="$HOME/projects/react-todo-list"
session_name="todo"

# Start new tmux session with a window running nvim in the specified directory
tmux new-session -d -s "$session_name" -c "$workdir/frontEnd/src" -n front-editor "nvim ."

# Add a second window with just a terminal
tmux new-window -t "$session_name" -n frontEnd -c "$workdir/frontEnd"
tmux new-window -t "$session_name" -n back-editor -c "$workdir/backEnd/src" "nvim ."
tmux new-window -t "$session_name" -n backEnd -c "$workdir/backEnd"

# Ensure we focus back on the Neovim window before attaching
tmux select-window -t "$session_name:front-editor"

# Attach to session
tmux attach-session -t "$session_name"

