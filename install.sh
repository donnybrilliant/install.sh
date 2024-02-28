#!/bin/zsh

# ESSENTIAL PACKAGES


    ESSENTIALS=(
        google-chrome
        iterm2
        zsh
        speedtest-cli
        tree
        dropbox
        google-drive
        sync
        nmap
        zenmap
        spotify
        vlc
        visual-studio-code
        wget
        the-unarchiver
        cheatsheet
        git
        github
        postman
        discord
        silicon
        cyberduck
        microsoft-teams
        qflipper
        devtoys
        tiled
        arc
        pieces
        ollama
        arduino-ide
)

# NPM PACKAGES 


      NPMPACKAGES=(
        express
      )



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
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Update macOS // is sudo needed?
echo "${GREEN}Looking for updates.."
echo
sudo softwareupdate -i -a
clear

# Homebrew
echo "${GREEN}Installing Homebrew"
echo
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
clear

# Update, upgrade and clean
echo "${GREEN}Cleaning up.."
echo
brew update && brew upgrade && brew cleanup && brew doctor
clear


# Install essentials
echo "${GREEN}Installing essentials..."
echo
brew install ${ESSENTIALS[@]}
clear

# Install Node
echo -n "${RED}Install Node via NVM or Brew? ${NC}[N/b]"
    read REPLY
    echo    
    if [[ $REPLY =~ ^[Nn]$ ]]
    then
      echo "${GREEN}Installing NVM..."
      echo
         curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash


    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

    clear

      echo "${GREEN}Installing Node via NVM..."
      echo
      nvm install node
      nvm use node
      clear
    fi
    if [[ $REPLY =~ ^[Bb]$ ]]
    then
      echo "${GREEN}Installing Node via Homebrew..."
      echo
      brew install node
      clear

    fi

echo "${GREEN}Installing Global NPM Packages..."
echo
npm install -g ${NPMPACKAGES[@]}
clear


# Optional Packages

echo -n "${RED}Install .NET? ${NC}[y/N]"
read REPLY
echo   
if [[ $REPLY =~ ^[Yy]$ ]]
then
  brew install dotnet
    fi
clear

echo -n "${RED}Install Firefox Developer? ${NC}[y/N]"
read REPLY
echo   
if [[ $REPLY =~ ^[Yy]$ ]]
then
  brew install firefox-developer-edition
    fi
clear

echo -n "${RED}Install Figma? ${NC}[y/N]"
read REPLY
echo   
if [[ $REPLY =~ ^[Yy]$ ]]
then
  brew install figma
    fi
clear

echo -n "${RED}Install Netlify CLI? ${NC}[y/N]"
read REPLY
echo   
if [[ $REPLY =~ ^[Yy]$ ]]
then
  brew install netlify-cli
    fi
clear

echo -n "${RED}Install Databases? ${NC}[y/N]"
read REPLY
echo   
if [[ $REPLY =~ ^[Yy]$ ]]
then
          brew install postgresql

          brew install mysql 
          brew services restart mysql
          mysql_secure_installation

        brew tap mongodb/brew
        brew install mongodb-community
    fi
clear

echo -n "${RED}Install Epic & Steam ${NC}[y/N]"
read REPLY
echo   
if [[ $REPLY =~ ^[Yy]$ ]]
then
  brew install steam epic-games
    fi
clear

echo -n "${RED}Install Unity Hub? ${NC}[y/N]"
read REPLY
echo   
if [[ $REPLY =~ ^[Yy]$ ]]
then
  brew install unity-hub
    fi
clear

echo -n "${RED}Install Binance? ${NC}[y/N]"
read REPLY
echo   
if [[ $REPLY =~ ^[Yy]$ ]]
then
  brew install binance
    fi
clear


echo -n "${RED}Install Transmission? ${NC}[y/N]"
read REPLY
echo   
if [[ $REPLY =~ ^[Yy]$ ]]
then
  brew install transmission
  brew install --cask transmission
    fi
clear

echo -n "${RED}Install Balena Etcher? ${NC}[y/N]"
read REPLY
echo   
if [[ $REPLY =~ ^[Yy]$ ]]
then
  brew install balenaetcher
    fi
clear

# Cleanup
echo "${GREEN}Cleaning up..."
echo
brew update && brew upgrade && brew cleanup && brew doctor
brew tap homebrew/autoupdate
brew autoupdate start 86400 --upgrade --cleanup --immediate --sudo
clear

# Settings
echo "${GREEN}Configuring default settings..."
echo
defaults write -g com.apple.mouse.scaling 3
defaults write -g com.apple.trackpad.scaling 3
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton
defaults write com.apple.AppleMultitouchMouse.plist MouseButtonMode TwoButton
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder NewWindowTarget PfHm
chflags nohidden ~/Library
clear

# Git Login

echo "${GREEN}GIT LOGIN"
echo
echo

echo "${RED}Please enter your git username:${NC}"
read name
echo "${RED}Please enter your git email:${NC}"
read email

git config --global user.name "$name"
git config --global user.email "$email"
git config --global color.ui true

printf "${GREEN}GITTY UP!"
clear

# ohmyzsh
echo "${GREEN}Installing ohmyzsh!"
echo
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
clear
echo "${GREEN}DONE!"
echo
echo
printf "${RED}"
read -s -k $'?Press ANY KEY to REBOOT\n'
sudo reboot
exit









