#!/usr/bin/bash

echo "==== updating package list ===="
sudo apt update

echo "==== installing node ===="
bash node.sh
echo "==== installing neovim ===="
bash neovim.sh
echo "==== installing tmux ===="
sudo apt install tmux
echo "==== installing oh by bash ===="
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
echo "==== installing gcc ===="
sudo apt install gcc
