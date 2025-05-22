#!/bin/bash

TAPS=()

PACKAGES=(
  adr-tools
  asdf
  fd
  gh
  jq
  make
  mysql-client
  neovim
  nmap
  ripgrep
  sqlite
  telnet
  terraform
  watch
  wget
)

CASKS=(
  brave-browser
  deezer
  font-fira-code-nerd-font
  hammerspoon
  iterm2
  monitorcontrol
  obsidian
  ollama
  visual-studio-code
)

VSCODE_EXT=(
  EditorConfig.EditorConfig
  Orta.vscode-jest
  arcticicestudio.nord-visual-studio-code
  bierner.markdown-mermaid
  davidanson.vscode-markdownlint
  dbaeumer.vscode-eslint
  eamodio.gitlens
  esbenp.prettier-vscode
  huytd.nord-light
  ms-python.black-formatter
  ms-python.debugpy
  ms-python.python
  ms-toolsai.jupyter
  ms-toolsai.jupyter-renderers
  ms-vscode.makefile-tools
  sumneko.lua
  virgilsisoe.hammerspoon
)

###############
### Prereqs ###
###############

read -p "Git email: " email

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

CODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"
code --install-extension ${VSCODE_EXT[@]}
rm -f $CODE_SETTINGS
ln -s $(pwd)/vscode-settings.json $CODE_SETTINGS

#################
### oh-my-zsh ###
#################

if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  sed -i.bak 's/\(plugins=\).*$/\1(git asdf)/' ~/.zshrc
fi

############
### asdf ###
############

if ! grep -q asdf ~/.zprofile; then
  echo 'export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"' >> ~/.zprofile
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
  rm Nord.terminal
  mv Nord-cj.terminal Nord.terminal
  open Nord.terminal
  defaults write com.apple.terminal "Default Window Settings" -string "Nord"
  defaults write com.apple.terminal "Startup Window Settings" -string "Nord"
  rm Nord-cj.terminal
fi

############################
#### iterm2 preferences ####
############################

defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
defaults write com.googlecode.iterm2 PrefsCustomFolder ~/code/setup-scripts/iterm2-settings
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile -bool true
defaults write com.googlecode.iterm2 "NoSyncNeverRemindPrefsChangesLostForFile_selection" 2
defaults write com.googlecode.iterm2 SUEnableAutomaticChecks -bool true
defaults write com.googlecode.iterm2 SUSendProfileInfo -bool false
defaults write com.googlecode.iterm2 NoSyncDoNotWarnBeforeMultilinePaste -bool true
defaults write com.googlecode.iterm2 NoSyncDoNotWarnBeforeMultilinePaste_selection -bool false
defaults write com.googlecode.iterm2 NoSyncPermissionToShowTip -bool false

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
  ln -s $(pwd)/.vimrc ~/.vimrc
fi

if [ ! -d ~/.config/nvim ]; then
  ln -s $(pwd)/nvim ~/.config/nvim
fi

echo 'alias e="nvim"' >> ~/.zshrc

###################################
### Remove annoying keybindings ###
###################################
# Disable input source switcher (Cmd+Space and Ctrl+Space)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 "<dict><key>enabled</key><false/></dict>"
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

#################
### git setup ###
#################

git config --global user.name "Chris Johnson"
git config --global user.email "$email"
git config --global push.autoSetupRemote true
git config --global core.excludesfile ~/.gitignore_global
echo '.DS_Store' >> ~/.gitignore_global
echo '.phpactor.json' >> ~/.gitignore_global

#################
### wallpaper ###
#################

wget https://images.wallpaperscraft.com/image/single/bridge_aerial_view_river_130099_3840x2160.jpg
osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$(pwd)/bridge_aerial_view_river_130099_3840x2160.jpg\""
# rm -f bridge_aerial_view_river_130099_3840x2160.jpg

##########################
### Browser Extensions ###
##########################

echo "
The following browser extensions are ready for install once you set your default browser to Brave:

https://chromewebstore.google.com/detail/meetings-page-auto-closer/pbgidoglkjhfgjhalbbiiahdlokjcplb
https://chromewebstore.google.com/detail/json-viewer/gbmdgpbipfallnflgajpaliibnhdgobh
https://chromewebstore.google.com/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi
https://chromewebstore.google.com/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb
"
