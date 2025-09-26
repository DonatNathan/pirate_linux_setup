#!/bin/bash

# Defining variables
logfile="setup_ubuntu.log"
git_email="nathan.donat-filliod@epitech.eu"
git_name="DonatNathan"
ssh_key_name="pirate_key"

# Defining colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Defining smileys
checkbox='\xe2\x9c\x93'
cross='\xe2\x9c\x98'
arrow='\xE2\x86\x92'

# Defining functions
log() {
    echo -e "$1"
}

# Updating and install packages
log "${BLUE}=== Updating packages...${NC}" | tee $logfile
apt update | tee -a $logfile
log "${GREEN}\n${checkbox} Packages updated.${NC}" | tee -a $logfile
log "${BLUE}=== Upgrading packages...${NC}" | tee -a $logfile
apt upgrade -y | tee -a $logfile
log "${GREEN}\n${checkbox} Packages upgraded.${NC}" | tee -a $logfile
log "${BLUE}=== Installing packages...${NC}" | tee -a $logfile
apt install $(awk '{print $1}' packages.list) -y | tee -a $logfile
log "${GREEN}\n${checkbox} All packages intalled.${NC}" | tee -a $logfile

# Setting up git
log "${BLUE}=== Setting up git...${NC}" | tee -a $logfile
git config --global user.email $git_email
log "${YELLOW}${arrow} Your git email has been set to: ${git_email}${NC}" | tee -a $logfile
git config --global user.name $git_name
log "${YELLOW}${arrow} Your git name has been set to: ${git_name}${NC}" | tee -a $logfile
ssh-keygen -t rsa -b 4096 -f ~/.ssh/$ssh_key_name -C $git_email -N ""
log "${YELLOW}${arrow} Here is your new public key: ${NC}" | tee -a $logfile
cat ~/.ssh/$ssh_key_name.pub | tee -a $logfile
log "${GREEN}\n${checkbox} Git setup.${NC}" | tee -a $logfile

# Setting up zsh
log "${BLUE}=== Installing ohmyzsh...${NC}" | tee -a $logfile
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended | tee -a $logfile
log "${GREEN}\n${checkbox} Ohmyzsh intalled.${NC}" | tee -a $logfile

# Creating aliases
