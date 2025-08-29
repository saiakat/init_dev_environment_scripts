#!/usr/bin/bash

echo "==== updating package list ===="
sudo apt update

echo "==== installing gcc and dev essentials ===="
sudo apt install build-essential
echo "==== installing other dev tools ===="
sudo apt install -y \
    curl \
    wget \
    git \
    htop 
echo "==== installing node ===="
bash node.sh
echo "==== installing neovim ===="
bash neovim.sh
echo "==== installing tmux ===="
sudo apt install tmux
echo "==== installing oh by bash ===="
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
