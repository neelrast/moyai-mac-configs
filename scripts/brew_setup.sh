#!/bin/bash

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
    pushd ~ || exit
    printf "${YELLOW}Installing Homebrew...${NC}\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    popd || exit
else
    printf "${YELLOW}Homebrew already installed, skipping installation...${NC}\n"
fi

# Update Homebrew recipes
printf "${YELLOW}Updating Homebrew recipes...${NC}\n"
brew update

# Upgrade any already installed formulae
printf "${YELLOW}Upgrading any already installed formulae...${NC}\n"
brew upgrade

# Install using brewfile
printf "${YELLOW}Installing using Brewfile...${NC}\n"
brew tap homebrew/bundle
brew bundle --file=../res/Brewfile

# Remove outdated versions from the cellar
printf "${YELLOW}Removing outdated versions from the cellar...${NC}\n"
brew cleanup

# Print a message
printf "${GREEN}Homebrew setup complete, please restart your terminal to see things in effect.${NC}\n"
