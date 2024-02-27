#!/bin/bash

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Create dir, check if it alreadys exists, in which case check if its empty if not exit with a message
mkdir -p ~/.iterm2/color-schemes/
if [ -d ~/.iterm2/color-schemes/ ]; then
    if [ "$(ls -A ~/.iterm2/color-schemes/)" ]; then
        printf "${YELLOW}iTerm2 color schemes directory already has some schemes already in it...${NC}\n"
    else
        # Clone the repo in ~/.iterm2/color-schemes (verbose mode)
        printf "${GREEN}iTerm2 color schemes directory is empty, cloning iTerm2 color schemes...${NC}\n"
        git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git ~/.iterm2/color-schemes --verbose
    fi
    # If the repo is already cloned, check if the repo is already up to date
    printf "${GREEN}Checking for color scheme updates...${NC}\n"
    pushd ~/.iterm2/color-schemes > /dev/null || exit
    git pull
    popd > /dev/null || exit
fi

# Import all color schemes
printf "${GREEN}Continue importing all color schemes? (y/n)${NC}\n"
read -r user_input
# make user input case insensitive
user_input=$(echo "$user_input" | tr '[:upper:]' '[:lower:]')
if [ "$user_input" != "y" ]; then
    printf "${YELLOW}Skipping importing color schemes...${NC}\n"
else
    printf "${GREEN}Importing color schemes...${NC}\n"
    pushd ~/.iterm2/color-schemes > /dev/null || exit
    tools/import-scheme.sh schemes/*
    popd > /dev/null || exit
fi

# Add steps to customize iterm with preloaded preferences
printf "${GREEN}Setup iTerm2 Preferences to Presets? (y/n)${NC}\n"
read -r user_input
# make user input case insensitive
user_input=$(echo "$user_input" | tr '[:upper:]' '[:lower:]')
if [ "$user_input" != "y" ]; then
    printf "${YELLOW}Skipping iTerm2 Preferences setup...${NC}\n"
else
    printf "${GREEN}To Setup iTerm2 Profile Presets, follow these steps...${NC}\n"
    printf "${GREEN}  1. Open iTerm2 > From Menu Bar > iTerm2 > Settings > General > Preferences:${NC} Select 'Load preferences from a custom folder or URL'\n"
    # Go a level up from the current directory
    pushd ${PWD}/.. > /dev/null || exit
    printf "${GREEN}  2. Add the Following path:${NC} ${PWD}/res/iterm2_configs\n"
    popd > /dev/null || exit
    printf "${GREEN}  3. Under Save Changes, set it to:${NC} Automatically\n"
    printf "${GREEN}  4. Close the preferences window${NC}\n"
    # Take user input if the steps above are done
    printf "${YELLOW}Did you have follow above instructions and are ready to proceed? (y/n)${NC}\n"
    read -r user_input
    # make user input case insensitive
    user_input=$(echo "$user_input" | tr '[:upper:]' '[:lower:]')
    if [ "$user_input" != "y" ]; then
        printf "${RED}Please follow the above instructions and try again...${NC}\n"
        exit 1
    else
        # Print a message
        printf "${GREEN}Setup Complete Restarting iTerm2...${NC}\n"
        # Restart iTerm2
        osascript -e 'tell application "iTerm" to quit'
        open -a iTerm
        exit 1
    fi
fi
