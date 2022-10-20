#!/bin/bash

# Author: Nuno Carvalho (Kuninoto)
# LINUX

# ANSI COLOR CODES
CYAN='\033[0;36m'
RED='\033[0;31m'
WHITE='\033[0;37m'
RESET='\033[0m'

# UPDATE && UPGRADE SYSTEM
notify-send "Updating Your System. This may take some time..."
sudo apt update
sudo apt upgrade -y

# PYTHON3 & PIP CHECK
if ! [ -x "$(command -v python3)" ]; then
  echo -e "${RED}Error${RESET}: python3 is not installed."
  echo -e "Proceeding to python3 installation..."
  sudo apt-get install python3
fi

if ! [ -x "$(command -v pip)" ]; then
  echo -e "${RED}Error${RESET}: pip is not installed."
  echo "Proceeding to pip installation..."
  sudo apt-get install python3-pip
fi

for arg in "$@"
do
	case "$arg" in
		"-v"*)	if [ -x "$(command -v vim)" ]; then
					echo "Vim is already installed."
				else
					echo "${CYAN}Installing Vim"
					sudo apt-get install vim
				fi;;

		"-h"*)	if [ -x "$(command -v vim)" ]; then
					echo -e -n "${CYAN}Please insert your 42username${RESET}: "
					read -r FT_User

					if ! grep -q 'MAIL=' "/home/$(whoami)/.bashrc"; then

					{	echo "USER=$FT_User"
						echo "MAIL=$FT_User@student.42.fr"
						echo "export MAIL"; } >> ~/.bashrc
					
					fi
					# mkdir with -p option creates folder if it doesnt exist, if it exists, does nothing.
					mkdir -p ~/.vim/plugin
					cp stdheader.vim ~/.vim/plugin/
					echo "nmap <f1> :FortyTwoHeader<CR>" >> ~/.vimrc
				else
					echo "${RED}Error${RESET}: vim is not installed."
					echo "Run norminette_installer with -v option"
				fi;;

		"-n"*)	if [ -x "$(command -v norminette)" ]; then
					echo "Norminette is already installed."
				else
					echo -e "${CYAN}Installing Norminette"
					python3 -m pip install --upgrade pip setuptools
					python3 -m pip install norminette
					echo "Setting norminette path on PATH env variable"
					echo "export PATH=$PATH: /home/$(whoami)/.local/bin/">> ~/.bashrc
				fi;;

		"-u"*)  sed -i '/^USER/d' ~/.bashrc
				sed -i '/^MAIL/d' ~/.bashrc
				sed -i '/export MAIL/d' ~/.bashrc
				sed -i '/nmap <f1> :Forty/d' ~/.vimrc
				rm -rf ~/.vim/plugin/stdheader.vim;;
	esac
done

echo -e "\n${WHITE}Installette terminated."
echo -e "Thanks for using Installette =)"
echo -e "Yours truly, ${CYAN}Nuno Carvalho (Kuninoto)\n${WHITE}nnuno-ca@42porto.student.com${RESET}"