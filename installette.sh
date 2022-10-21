#!/bin/bash

# Author: Nuno Carvalho (Kuninoto)
# LINUX

# ANSI COLOR CODES
CYAN='\033[0;36m'
BLUE='\033[1;34m'
RED='\033[0;31m'
GREEN='\033[0;32m'
WHITE='\033[0;37m'
RESET='\033[0m'

# UPDATE && UPGRADE SYSTEM
notify-send "Updating Your System. This may take some time..."
sudo apt update
sudo apt upgrade -y
echo -n -e "\n"

# PYTHON3 & PIP CHECK
if ! [ -x "$(command -v python3)" ]; then
  echo -e "${RED}Error${RESET}: python3 is not installed."
  echo -e "${CYAN}Proceeding to install python3...${RESET}"
  sudo apt-get install python3
fi

if ! [ -x "$(command -v pip)" ]; then
  echo -e "${RED}Error${RESET}: pip is not installed."
  echo "${CYAN}Proceeding to install pip...${RESET}"
  sudo apt-get install python3-pip
fi

for arg in "$@"
do
	case "$arg" in
		"-v" | "--vim"*)
			echo -e "${BLUE}VIM${RESET}"
			if [ -x "$(command -v vim)" ]; then
				echo -e "${CYAN}vim is already installed. Skipping...${RESET}"
			else
				echo "${CYAN}Installing Vim...${RESET}"
				sudo apt-get install vim
			fi;;

		"-h" | "--header"*)
			echo -e "${BLUE}42 HEADER${RESET}"
			if [ -x "$(command -v vim)" ]; then
				echo -e -n "${CYAN}Please insert your 42username${RESET}: "
				read -r FT_User
				if ! grep -q 'MAIL=' "/home/$(whoami)/.bashrc"; then
				{	echo "USER=$FT_User"
					echo "MAIL=$FT_User@student.42.fr"
					echo "export MAIL"; } >> ~/.bashrc
				fi
				# mkdir with -p option creates dir if it doesnt exist; if it exists, does nothing.
				mkdir -p ~/.vim/plugin
				cp stdheader.vim ~/.vim/plugin/
				echo "nmap <f1> :FortyTwoHeader<CR>" >> ~/.vimrc
				echo -e "${GREEN}Sucessfully installed 42Header!${RESET}"
			else
				echo -e "${RED}Error${RESET}: vim is not installed."
				echo -e "${CYAN}Run installette with the -v or --vim option${RESET}"
			fi;;

		"-n" | "--norminette"*)
			echo -e "${BLUE}NORMINETTE${RESET}"
			if [ -x "$(command -v norminette)" ]; then
				echo -e "${CYAN}Norminette is already installed. Skipping...${RESET}"
			else
				echo -e "${CYAN}Installing Norminette...${RESET}"
				python3 -m pip install --upgrade pip setuptools
				python3 -m pip install norminette
				echo -e "${CYAN}Updating PATH...${RESET}"
				echo "export PATH=$PATH: /home/$(whoami)/.local/bin/" >> ~/.bashrc
			fi;;

		"-f" | "--formatter"*)
			echo -e "${BLUE}FORMATTER${RESET}"
			if [ -x "$(command -v c_formatter_42)" ]; then
				echo -e "${CYAN}c-formatter-42 is already installed. Skipping...${RESET}"
			else
				echo -e "${CYAN}Installing c_formatter_42...${RESET}"
				pip3 install c-formatter-42
				pip3 install --user c-formatter-42
			fi;;

		"-u" | "--uninstall"*)
			echo -e "${BLUE}UNISTALL${RESET}"
			#sed's -i option edits files in place
			sed -i '/^USER/d' ~/.bashrc
			echo -e "${CYAN}Unistalling 42Header...${RESET}"
			sed -i '/^MAIL/d' ~/.bashrc
			sed -i '/export MAIL/d' ~/.bashrc
			sed -i '/nmap <f1> :Forty/d' ~/.vimrc
			rm -rf ~/.vim/plugin/stdheader.vim
			echo -e "${GREEN}Sucessfully uninstalled 42Header.${RESET}";;
	esac
done

echo -e "\n${GREEN}Installette terminated!${WHITE}"
echo -e "Thanks for using Installette =)"
echo -e "Yours truly, ${CYAN}Nuno Carvalho (Kuninoto)\n${WHITE}nnuno-ca@42porto.student.com${RESET}"
