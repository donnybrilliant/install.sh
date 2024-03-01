#!/bin/zsh

source ./config

# COLOR
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

###########################################
# Start
##########################################
clear
echo " _           _        _ _       _     "
echo "(_)         | |      | | |     | |    "
echo " _ _ __  ___| |_ __ _| | |  ___| |__  "
echo "| | |_ \/ __| __/ _  | | | / __| |_ \ "
echo "| | | | \__ \ || (_| | | |_\__ \ | | |"
echo "|_|_| |_|___/\__\__,_|_|_(_)___/_| |_|"
echo
echo
echo Enter root password

# Ask for the administrator password upfront.
sudo -v

# Keep Sudo Until Script is finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# Update macOS
echo
echo "${GREEN}Looking for updates.."
echo
sudo softwareupdate -i -a

# Homebrew
echo
echo "${GREEN}Installing Homebrew"
echo
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Append Homebrew initialization to .zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>${HOME}/.zprofile
# Immediately evaluate the Homebrew environment settings for the current session
eval "$(/opt/homebrew/bin/brew shellenv)"

# Update, upgrade and clean
echo
echo "${GREEN}Cleaning up.."
echo
brew update && brew upgrade && brew cleanup && brew doctor

# Install essentials
echo
echo "${GREEN}Installing formulae..."
brew install ${FORMULAE[@]}
echo
echo "${GREEN}Installing casks..."
brew install --cask ${CASKS[@]}

# Install Node
echo
echo -n "${RED}Install Node via NVM or Brew? ${NC}[N/b]"
read REPLY
if [[ $REPLY =~ ^[Nn]$ ]]; then
  echo "${GREEN}Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

  # Loads NVM
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  echo "${GREEN}Installing Node via NVM..."
  nvm install --lts
  nvm install node
  nvm alias default node
  nvm use default

fi
if [[ $REPLY =~ ^[Bb]$ ]]; then
  echo "${GREEN}Installing Node via Homebrew..."
  brew install node

fi

echo
echo "${GREEN}Installing Global NPM Packages..."
npm install -g ${NPMPACKAGES[@]}

# Optional Packages
echo
echo -n "${RED}Install .NET? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  brew install dotnet
  export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"
fi

echo
echo -n "${RED}Install Firefox Developer Edition? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  brew tap homebrew/cask-versions
  brew install firefox-developer-edition
fi

echo
echo -n "${RED}Install Databases? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  brew install postgresql

  brew install mysql
  brew services restart mysql
  mysql_secure_installation

  brew tap mongodb/brew
  brew install mongodb-community
fi

echo
echo -n "${RED}Install Epic & Steam ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  brew install steam epic-games
fi

echo
echo -n "${RED}Install Unity Hub? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  brew install unity-hub
fi

# Cleanup
echo
echo "${GREEN}Cleaning up..."
brew update && brew upgrade && brew cleanup && brew doctor
mkdir -p /Users/daniel/Library/LaunchAgents
brew tap homebrew/autoupdate
brew autoupdate start $HOMEBREW_UPDATE_FREQUENCY --upgrade --cleanup --immediate --sudo

# Settings
echo
echo -n "${RED}Configure default system settings? ${NC}[Y/n]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "${GREEN}Configuring default settings..."
  # Apply settings from config.sh file
  for setting in "${SETTINGS[@]}"; do
    eval $setting
  done
fi

# Dock settings
echo
echo -n "${RED}Apply Dock settings?? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  # Apply dock settings from config.sh file
  for app in "${DOCK[@]}"; do
    eval "dockutil --add $app"
  done
fi

# Git Login
echo
echo "${GREEN}GIT LOGIN"
echo

echo "${RED}Please enter your git username:${NC}"
read name
echo "${RED}Please enter your git email:${NC}"
read email

git config --global user.name "$name"
git config --global user.email "$email"
git config --global color.ui true

echo
echo "${GREEN}GITTY UP!"

# VS Code Extensions
echo
echo -n "${RED}Install VSCode Extensions? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  # Install VS Code extensions from config.sh file
  for extension in "${VSCODE[@]}"; do
    eval "code --install-extension $extension"
  done
fi

# App Store
echo
echo -n "${RED}Do you want to install Pages, Numbers & Trello from App Store? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  brew install mas
  for app in "${APPSTORE[@]}"; do
    eval "mas install $app"
  done
fi

# ohmyzsh
echo
echo "${GREEN}Installing ohmyzsh!"
echo
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

clear
echo "${GREEN}______ _____ _   _  _____ "
echo "${GREEN}|  _  \  _  | \ | ||  ___|"
echo "${GREEN}| | | | | | |  \| || |__  "
echo "${GREEN}| | | | | | | .   ||  __| "
echo "${GREEN}| |/ /\ \_/ / |\  || |___ "
echo "${GREEN}|___/  \___/\_| \_/\____/ "

echo
echo
printf "${RED}"
read -s -k $'?Press ANY KEY to REBOOT\n'
sudo reboot
exit
