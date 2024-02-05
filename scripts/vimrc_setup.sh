#!/bin/bash

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Update VIMRC configuration from git repository
function update() {
    printf "${YELLOW}updating configs...${NC}\n"
    # Update VIMRC configuration from git repository
    pushd ~/.vim_runtime || { printf "${RED}VIMRC directory not found, please run the script without the update flag.${NC}\n"; exit 1; }
    git pull --rebase || { printf "${RED}Failed to update VIMRC.${NC}\n"; exit 1; }
    # Restore current directory
    popd || exit
}

# Install VIMRC configuration from git repository
function install() {
    printf "${YELLOW}installing configs...${NC}\n"
    # The Ultimate vimrc is a collection of vimrc configurations to make easy the usage of vim.
    # To download the The Ultimate vimrc, install it:
    git clone https://github.com/amix/vimrc.git ~/.vim_runtime || { printf "${RED}Failed to clone VIMRC.${NC}\n"; exit 1; }
    # To install the complete version, run:
    sh ~/.vim_runtime/install_awesome_vimrc.sh || { printf "${RED}Failed to install VIMRC.${NC}\n"; exit 1; }
}

# check if ~/.vim_runtime exists
printf "${YELLOW}Looking for existing VIMRC configurations...${NC}\n"

# Install/update configs
if [ -d ~/.vim_runtime ]; then
    printf "${YELLOW}configurations already installed...${NC}\n"
    update
else
    printf "${YELLOW}configurations not found...${NC}\n"
    install
fi

printf "${GREEN}VIMRC is now configured and up-to-date.${NC}\n"
