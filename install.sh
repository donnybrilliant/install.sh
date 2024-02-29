#!/bin/zsh

# ESSENTIAL PACKAGES

CASKS=(
  iterm2
  google-chrome
  arc
  visual-studio-code
  spotify
  vlc
  dropbox
  google-drive
  sync
  github
  cyberduck
  postman
  discord
  microsoft-teams
  silicon
  qflipper
  pieces
  ollama
  devtoys
  the-unarchiver
  cheatsheet
  zenmap
  tiled
  arduino-ide

)

FORMULAE=(
  speedtest-cli
  tree
  nmap
  wget
  git
  pinentry-mac
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
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# Update macOS // is sudo needed?
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

  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

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
echo -n "${RED}Install Firefox Developer? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  brew tap homebrew/cask-versions
  brew install firefox-developer-edition
fi

echo
echo -n "${RED}Install Figma? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  brew install figma
fi

echo
echo -n "${RED}Install Netlify CLI? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  brew install netlify-cli
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

echo
echo -n "${RED}Install Binance? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  brew install binance
fi

echo
echo -n "${RED}Install Transmission? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  brew install transmission
  brew install --cask transmission
fi

# Cleanup
echo
echo "${GREEN}Cleaning up..."
brew update && brew upgrade && brew cleanup && brew doctor
mkdir -p /Users/daniel/Library/LaunchAgents
brew tap homebrew/autoupdate
brew autoupdate start 86400 --upgrade --cleanup --immediate --sudo

# Settings
echo
echo -n "${RED}Configure default system settings? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "${GREEN}Configuring default settings..."
  defaults write -g com.apple.mouse.scaling 3
  defaults write -g com.apple.trackpad.scaling 3
  defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton
  defaults write com.apple.AppleMultitouchMouse.plist MouseButtonMode TwoButton
  defaults write -g AppleShowAllExtensions -bool true
  defaults write com.apple.finder AppleShowAllFiles true
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write com.apple.finder ShowStatusBar -bool true
  defaults write com.apple.finder NewWindowTarget PfHm
  defaults write com.apple.Finder FXPreferredViewStyle Nlsv
  defaults write com.apple.finder _FXSortFoldersFirst -bool true
  chflags nohidden ~/Library
fi

# Dock settings
## Very little flexible.. Based on language.. And all fails if one fails..
echo
echo -n "${RED}Apply Dock settings?? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  dockutil --add /Applications/Google\ Chrome.app --replacing 'Safari' &&
    dockutil --add /Applications/iTerm.app &&
    dockutil --add /Applications/Visual\ Studio\ Code.app &&
    dockutil --add /Applications/GitHub\ Desktop.app &&
    dockutil --add /Applications/Spotify.app &&
    dockutil --add /Applications/Discord.app &&
    dockutil --add /Applications/Microsoft\ Teams\ \(work\ or\ school\).app &&
    dockutil --remove 'Meldinger' &&
    dockutil --remove 'Kart' &&
    dockutil --remove 'Bilder' &&
    dockutil --remove 'Påminnelser' &&
    dockutil --remove 'FaceTime' &&
    dockutil --remove 'Kontakter' &&
    dockutil --remove 'TV' &&
    dockutil --remove 'Musikk' &&
    dockutil --remove 'Mail'
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
  code --install-extension esbenp.prettier-vscode
  code --install-extension GitHub.copilot
  code --install-extension dsznajder.es7-react-js-snippets
  code --install-extension ritwickdey.liveserver
  code --install-extension github.vscode-pull-request-github
  code --install-extension sourcegraph.cody-ai
  code --install-extension eamodio.gitlens
  code --install-extension meshintelligenttechnologiesinc.pieces-vscode
#auto rename
#auto closE?
#color brackets
#html?
#typescript?
#typescript react?
#other intellisenses?
fi

# MAS
echo
echo -n "${RED}Do you want to install Pages, Numbers & Trello from App Store? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  brew install mas
  mas install 409201541
  mas install 409203825
  mas install 1278508951
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
