#!/bin/zsh

user=harutonguyen

RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

startInstall() {
  echo "${GREEN}$1"
  echo "${RED}Press Ctrl + C To Cancel!${NOCOLOR}"
}

startConfig() {
  echo "${GREEN}$1"
  echo "${RED}Press Ctrl + C To Cancel!${NOCOLOR}"
}

countInstall() {
  for upgradeCount in 1 2 3 4 5
  do
	  echo "${RED}Install After $upgradeCount Seconds${NOCOLOR}"
	  sleep 1s
  done 
}
countConfig() {
  for upgradeCount in 1 2 3 4 5
  do
	  echo "${RED}Config After $upgradeCount Seconds${NOCOLOR}"
	  sleep 1s
  done 
}

Done() {
  echo "${GREEN}DONE!${NOCLOR}"
}

startInstall "Upgrade System!"
countInstall

sudo pacman -Syuy --noconfirm

Done

startInstall "Installing Package!"
countConfig
  
sudo pacman -Sy --noconfirm git mpv neovim neofetch sox uwufetch vscode jdk17-openjdk gcc tmux unzip zip wget curl nodejs npm zsh 

Done

startConfig "Install Lunar Vim"
countConfig 



Done

startConfig "zsh"
countConfig

cp -r -f ./terminals/powerlevel10k /home/$user
cp -f ./terminals/.zshrc ~
cp -f ./terminals/.p10k.zsh ~
echo "Copying Success!"


Done
