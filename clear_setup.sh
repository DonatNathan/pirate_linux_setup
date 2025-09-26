#!/bin/bash

# Defining variables
logfile="clear_setup.log"
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

log "${BLUE}=== Purging packages...${NC}" | tee -a $logfile
apt purge $(awk '{print $1}' packages.list) -y | tee -a $logfile
log "${BLUE}=== Autoremove...${NC}" | tee -a $logfile
apt autoremove -y | tee -a $logfile
log "${BLUE}=== Cleaning...${NC}" | tee -a $logfile
apt clean | tee -a $logfile
log "${GREEN}\n${checkbox} Packages uninstalled.${NC}" | tee -a $logfile

# uninstall_oh_my_zsh | tee -a $logfile
# log "${GREEN}\n${checkbox} Ohmyzsh uninstalled.${NC}" | tee -a $logfile

rm ~/.ssh/$ssh_key_name ~/.ssh/$ssh_key_name.pub
log "${GREEN}\n${checkbox} SSH key deleted.${NC}" | tee -a $logfile
