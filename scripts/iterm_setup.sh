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
        printf "${RED}~/.iterm2/color-schemes/ is not empty, exiting...${NC}"
        exit 1
    fi
fi

# Clone the repo in ~/.iterm2/color-schemes (verbose mode)
printf "${GREEN}Cloning iTerm2-Color-Schemes repo in ~/.iterm2/color-schemes${NC}"
git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git ~/.iterm2/color-schemes --verbose

# Import all color schemes (verbose mode)
printf "${YELLOW}Importing all color schemes${NC}"
pushd ~/.iterm2/color-schemes
tools/import-scheme.sh -v schemes/*
popd || exit

# Print a message
printf "${YELLOW}Please restart iTerm2 (Cmd+Q) and select a color scheme from iTerm2 > Preferences > Profiles > Colors > Color Presets${NC}"
printf "${GREEN}iTerm2 setup complete.${NC}\n"
