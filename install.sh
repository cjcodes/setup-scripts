#!/bin/bash

PACKAGES=(
  jq
  wget
  fd-find
  ripgrep
  xclip
)

sudo apt update
sudo apt install -y ${PACKAGES[@]}

wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
tar xzvf nvim-linux-x86_64.tar.gz
sudo mv nvim-linux-x86_64 /opt/nvim
sudo ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim

mkdir -p ~/.{config,codex}

ln -s $(pwd)/nvim ~/.config/nvim
ln -s $(pwd)/AGENTS.md ~/.codex/AGENTS.md
