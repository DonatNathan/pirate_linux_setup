#!/bin/bash

# Defining variables
logfile="setup_ubuntu.log"
git_email="nathan.donat-filliod@epitech.eu"
git_name="DonatNathan"
git_init_branch="main"
git_editor="nano"
ssh_key_name="pirate_key"

# Defining colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Defining smileys
checkbox='✓'
cross='✗'
arrow='\xE2\x86\x92'
big_arrow='➽'

# Defining functions
log() {
    echo -e "$1"
}

# Updating and install packages
log "${BLUE}${big_arrow} Updating packages...${NC}" | tee $logfile
sudo apt-get update >> $logfile
log "${GREEN}${checkbox} Packages updated.${NC}" | tee -a $logfile
log "${BLUE}${big_arrow} Upgrading packages...${NC}" | tee -a $logfile
sudo apt-get upgrade -y >> $logfile
log "${GREEN}${checkbox} Packages upgraded.${NC}" | tee -a $logfile
log "${BLUE}${big_arrow} Installing packages...${NC}" | tee -a $logfile
sudo apt-get install $(awk '{print $1}' packages.list) -y >> $logfile
log "${GREEN}${checkbox} All packages intalled.${NC}" | tee -a $logfile

# Setting up git
log "${BLUE}${big_arrow} Setting up git...${NC}" | tee -a $logfile
git config --global user.email $git_email
log "${YELLOW} ${arrow} Your git email has been set to: ${git_email}${NC}" | tee -a $logfile
git config --global user.name $git_name
log "${YELLOW} ${arrow} Your git name has been set to: ${git_name}${NC}" | tee -a $logfile
git config --global core.editor $git_editor
log "${YELLOW} ${arrow} Your git editor has been set to: ${git_editor}${NC}" | tee -a $logfile
git config --global init.defaultBranch $git_init_branch
log "${YELLOW} ${arrow} Your git init branch has been set to: ${git_init_branch}${NC}" | tee -a $logfile
ssh-keygen -t rsa -b 4096 -f ~/.ssh/$ssh_key_name -C $git_email -N "" >> $logfile
log "${YELLOW} ${arrow} Here is your new public key: ${NC}" | tee -a $logfile
cat ~/.ssh/$ssh_key_name.pub | tee -a $logfile
log "${GREEN}${checkbox} Git setup.${NC}" | tee -a $logfile

# Setting up zsh
log "${BLUE}${big_arrow} Installing ohmyzsh...${NC}" | tee -a $logfile
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended >> $logfile
log "${GREEN}${checkbox} Ohmyzsh intalled.${NC}" | tee -a $logfile

# Creating aliases
echo "" >> ~/.zshrc
echo "# Pirate setup:" >> ~/.zshrc
echo "alias c='clear'" >> ~/.zshrc

# Cleaning for performance
sudo apt-get autoremove -y | sed 's/^/  /' >> $logfile
sudo apt-get clean | sed 's/^/  /' >> $logfile
