#!/bin/bash

TAPS=(
  null-dev/firefox-profile-switcher
)

PACKAGES=(
  adr-tools
  asdf
  firefox-profile-switcher-connector
  jq
  python3
  sqlite
  telnet
  watch
  wget
)

CASKS=(
  visual-studio-code
  hammerspoon
  firefox
  krisp
  bitwarden
  1password
  1password-cli
  signal
  caffeine
  datagrip
  pandora
  monitorcontrol
  tidal
  todoist
)

VSCODE_EXT=(
  arcticicestudio.nord-visual-studio-code
  Orta.vscode-jest
)

xcode-select --install

# Check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! grep -q Homebrew ~/.zprofile; then
  echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew tap ${TAPS[@]}

brew update

brew install ${PACKAGES[@]}

brew install ${CASKS[@]} --cask

defaults write NSGlobalDomain AppleShowAllExtensions -bool true

code --install-extension ${VSCODE_EXT[@]}

if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if ! grep -q asdf ~/.zprofile; then
  echo '. /opt/homebrew/opt/asdf/libexec/asdf.sh' >> ~/.zprofile
fi

if ! defaults read com.apple.terminal | grep -q Nord; then
  wget https://raw.githubusercontent.com/arcticicestudio/nord-terminal-app/develop/src/xml/Nord.terminal
  open Nord.terminal
  defaults write com.apple.terminal "Default Window Settings" -string "Nord"
  defaults write com.apple.terminal "Startup Window Settings" -string "Nord"
  rm Nord.terminal
fi

if [ ! -d ~/.hammerspoon ]; then
  mkdir ~/.hammerspoon
  cp ./init.lua ~/.hammerspoon
fi

if [ ! -f ~/.vimrc ]; then
  cp ./.vimrc ~/.vimrc
fi

wget -P ~ https://github.com/arcticicestudio/nord-dircolors/blob/develop/src/dir_colors
mv ~/dir_colors ~/.dir_colors
echo "test -r \"~/.dir_colors\" && eval \$(dircolors ~/.dir_colors)" >> ~/.zshrc

if [ ! -d /Applications/CameraController.app ]; then
  wget https://github.com/Itaybre/CameraController/releases/latest/download/CameraController.zip
  unzip CameraController.zip
  rm CameraController.zip
  mv CameraController.app /Applications/
fi
