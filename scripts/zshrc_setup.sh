#!/bin/bash

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Install oh-my-zsh
if [ -d ~/.oh-my-zsh ]; then
    printf "${YELLOW}oh-my-zsh already installed...${NC}\n"
else
    printf "${YELLOW}Installing oh-my-zsh...${NC}\n"
    pushd ~ || exit
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    popd || exit
fi

# Install powerlevel10k
if [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    printf "${YELLOW}powerlevel10k already installed...${NC}\n"
else
    printf "${YELLOW}Installing powerlevel10k...${NC}\n"
    pushd ~ || exit
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    popd || exit

    # Set ZSH_THEME to powerlevel10k
    printf "${YELLOW}Setting ZSH_THEME...${NC}\n"
    sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
fi

# Install zsh-autosuggestions
if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    printf "${YELLOW}zsh-autosuggestions already installed...${NC}\n"
else
    printf "${YELLOW}Installing zsh-autosuggestions...${NC}\n"
    pushd ~ || exit
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    popd || exit

    # Add zsh-autosuggestions to plugins in ~/.zshrc
    printf "${YELLOW}Adding zsh-autosuggestions to plugins...${NC}\n"
    sed -i '' 's/plugins=(git)/plugins=(git zsh-autosuggestions)/' ~/.zshrc
fi

# Install zsh-syntax-highlighting
if [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    printf "${YELLOW}zsh-syntax-highlighting already installed...${NC}\n"
else
    printf "${YELLOW}Installing zsh-syntax-highlighting...${NC}\n"
    pushd ~ || exit
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    popd || exit

    # Add zsh-syntax-highlighting to plugins in ~/.zshrc
    printf "${YELLOW}Adding zsh-syntax-highlighting to plugins...${NC}\n"
    sed -i '' 's/plugins=(git zsh-autosuggestions)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
fi

# Lastly add suport for loading bashrc in zshrc
printf "${YELLOW}Adding support for loading bashrc in zshrc with comments...${NC}\n"
echo "" >> ~/.zshrc
echo "# Load bashrc if it exists" >> ~/.zshrc
echo "source ~/.bashrc" >> ~/.zshrc

# Run Conda init and Mamba init to add conda to the shell
conda init zsh
mamba init zsh

# Print a message
printf "${YELLOW}Installation complete, please restart your terminal to apply the changes.${NC}\n"
printf "${GREEN}Done!${NC}\n"
