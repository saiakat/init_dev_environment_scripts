#!/usr/bin/bash
# Automatic neovim (console based text editor/ide) setup by Max

# Change to home directory
cd $HOME

if [ -e "/usr/bin/git" ]; then
  echo "git alreay installed"
else
  sudo apt install git
fi

# Check if neovim is already installed and if not download and unpack it
if [ -e "$HOME/nvim-linux-x86_64" ]; then
  echo "Neovim is already installed."
else
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
  sudo tar -C $HOME -xzf nvim-linux-x86_64.tar.gz
fi

# Check if lua is already installed and if not download and unpack it
# lua is the language neovim uses for scripting (e.g. for remapping keys, changing settings, installing plugins ...)
if [ -e "$HOME/lua-5.4.8" ]; then
  echo "lua is already installed."
else
  curl -L -R -O https://www.lua.org/ftp/lua-5.4.8.tar.gz
  tar zxf lua-5.4.8.tar.gz
  cd lua-5.4.8
  make all test
  cd $HOME
fi

# Check if ripgrep is already installed and if not download and unpack it
# ripgrep is used for searching for terms in files recursively when using telescope (plugin for finding files and terms)
# it is also necessary for global search and replaces in neovim using telescope
if [ -e "$HOME/ripgrep-14.1.1-x86_64-unknown-linux-musl" ]; then
  echo "ripgrep is already installed."
else
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-unknown-linux-musl.tar.gz
  tar zxf ripgrep-14.1.1-x86_64-unknown-linux-musl.tar.gz
fi

# Check if my (max) git repository for the neovim configuration is downloaded and if not clones it into the .config folder
# which is also created if it doesn't exist yet
# This gives you the setup for neovim with plugins for file searching, syntax highliting, autocompletion, lsp etc ...
if [ -e "$HOME/.config/nvim" ]; then
  echo "Neovim config already exists."
  cd $HOME/.config/nvim
  git pull
  cd $HOME
else
  mkdir .config
  cd .config
  git clone https://github.com/saiakat/neovim-config.git
  mv neovim-config nvim
  cd $HOME
fi

# removes all downloaded archives after they have been unpacked
if [ -e "$HOME/*.tar.gz" ]; then
  rm *.tar.gz
else
  echo 'No dependencies installed (already exist).'
fi

# The line above is not persistent between terminal sessions. To make it persistent it is added to your .profile file
# if it doesn't already exist there.
# Your .profile file is wiped every time your server restarts on peach. So I recommend running the script
# or manually adding the line to your .profile file every time you start the server
if grep -q 'export PATH="$PATH:$HOME/nvim-linux-x86_64/bin:$HOME/lua-5.4.8/src:$HOME/ripgrep-14.1.1-x86_64-unknown-linux-musl"' $HOME/.bashrc; then
  echo 'Path variable already set in .bashrc'
else
  echo 'export PATH="$PATH:$HOME/nvim-linux-x86_64/bin:$HOME/lua-5.4.8/src:$HOME/ripgrep-14.1.1-x86_64-unknown-linux-musl"' >> .bashrc
fi

if [ -e "/usr/bin/xclip" ]; then
  echo "xclip alreay installed."
else
  sudo apt install xclip
fi

source ~/.bashrc
