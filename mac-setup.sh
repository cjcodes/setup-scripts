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
  gh
  pianobar
  tmux
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
  pandora
  monitorcontrol
  tidal
  todoist
  jetbrains-toolbox
)

VSCODE_EXT=(
  arcticicestudio.nord-visual-studio-code
  Orta.vscode-jest
  ms-vscode.makefile-tools
  EditorConfig.EditorConfig
)

xcode-select --install

################
### Homebrew ###
################

# Check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Homebrew post-install steps
if ! grep -q Homebrew ~/.zprofile; then
  echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install packages and casks
brew tap ${TAPS[@]}
brew update
brew install ${PACKAGES[@]}
brew install ${CASKS[@]} --cask

##########################################
### Miscellaneous OS settings and apps ###
##########################################

# Delete old trash items
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# Install CameraController (not available in homebrew)
if [ ! -d /Applications/CameraController.app ]; then
  wget https://github.com/Itaybre/CameraController/releases/latest/download/CameraController.zip
  unzip CameraController.zip
  rm CameraController.zip
  mv CameraController.app /Applications/
fi

# Alert me when there are unstaged changes
echo "if [[ -n \$(git -C $(pwd) status -s) ]]; then echo \"\\e[31mYou have unstaged changes in $(pwd).\\e[0m\"; fi" >> ~/.zprofile

########################
### VS Code Settings ###
########################

code --install-extension ${VSCODE_EXT[@]}

#################
### oh-my-zsh ###
#################

if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

############
### asdf ###
############

if ! grep -q asdf ~/.zprofile; then
  echo '. /opt/homebrew/opt/asdf/libexec/asdf.sh' >> ~/.zprofile
fi

############################
### Terminal preferences ###
############################

if ! defaults read com.apple.terminal | grep -q Nord; then
  wget https://raw.githubusercontent.com/arcticicestudio/nord-terminal-app/develop/src/xml/Nord.terminal
  END_OF_DICT=`grep -n "^</dict>" Nord.terminal | cut -d : -f 1`
  head -n $(($END_OF_DICT-1)) Nord.terminal >> Nord-cj.terminal
  cat terminal-prefs.txt >> Nord-cj.terminal
  tail -n +$END_OF_DICT Nord.terminal >> Nord-cj.terminal
  open Nord.terminal
  defaults write com.apple.terminal "Default Window Settings" -string "Nord"
  defaults write com.apple.terminal "Startup Window Settings" -string "Nord"
  rm Nord.terminal
  rm Nord-cj.terminal
fi

##############################
### Hammerspoon automation ###
##############################

if [ ! -d ~/.hammerspoon ]; then
  mkdir ~/.hammerspoon
  ln -s $(pwd)/init.lua ~/.hammerspoon/init.lua
fi

#################
### Vim setup ###
#################

if [ ! -f ~/.vimrc ]; then
  ln -s $(pwd)/vimrc.lua ~/.vimrc
fi

