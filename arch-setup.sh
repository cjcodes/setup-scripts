#!/bin/bash

PACKAGES=(
  # asdf
  jq
  # python3
  sqlite
  wget
  github-cli
  terraform
  fd
  ripgrep
  neovim
  xclip
)

sudo pacman -S ${PACKAGES[@]}

if [ ! -d ~/.config/nvim ]; then
  ln -s $(pwd)/nvim ~/.config/nvim
fi
