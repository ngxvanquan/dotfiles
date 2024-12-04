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
  
sudo pacman -Sy --noconfirm base-devel git mpv neovim neofetch sox tmux unzip zip wget curl nodejs npm zsh fzf

Done

startInstall "Instaling Yay"
countConfig

cd /home/harutonguyen/
git clone https://aur.archlinux.org/yay.git
cd yay 
makepkg -si --noconfirm
cd /home/harutonguyen
rm -rf yay

Done
