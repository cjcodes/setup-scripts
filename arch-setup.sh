#!/bin/bash

PACKAGES=(
  # asdf
  jq
  # python3
  sqlite
  wget
  github-cli
  fd
  ripgrep
  neovim
  xclip
)

sudo pacman -S ${PACKAGES[@]}

if [ ! -d ~/.config/nvim ]; then
  ln -s $(pwd)/nvim ~/.config/nvim
fi

nvim --headless '+Lazy install' +qa
