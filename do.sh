#######################################################################
#								do.sh
#######################################################################
# Author            : Kabbaj Amine
# Date Creation     : 2014-06-21
# Last modification : 2016-06-13

# DESCRIPTION
# - Create symbolic links for my dotfiles.

# USAGE
# - Specify the dotfiles folder in the variables.
# - Specify the symbolic links and files to copy in the PROCESSING PART:
#	* makeDir directory
#	* createLink file link [h(If hidden)]
#	* copyFile file destination [h(If hidden)]

# TODO
# - Create the symb links with a loop (Stock the informations in a dict-like if possible).
#######################################################################

#!/bin/bash
DEFAULT_IFS=$IFS
IFS='
'

# #####################
#		VARIABLES
# #####################

# Folders.
script_folder=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
dotfiles_folder="/home/k-bag/.dotfiles/"

# Colors.
red_bold='\033[01;31m'
red='\033[31m'
white="\033[0m"
green="\033[01;32m"
yellow="\033[33m"


# #####################
#		FUNCTIONS
# #####################

checkFile() {
	# Check if $1 is a file,
	# if not interrupt the process

	if [ ! -e $1 ]; then
		echo -e "${1}${red} does not exist${white}"
		kill -SIGINT $$
	fi
}
getProperties() {
	# Get from $1 and $2 the file's name and location
	# and return them in $file_name, $file_location
	# (& $link if $3 exists)

	file_name=$(echo $1 | rev | cut -d '/' -f 1 | rev) &&
	file_location=$2 &&
	case $3 in
		'h' )
			link="$2/.$file_name"
			;;
		* )
			link="$2/$file_name"
			;;
	esac
}
createLink() {
	file="${dotfiles_folder}${1}" &&
	link="$2" &&
	option="$3" &&

	checkFile "$file" &&
	getProperties "$file" "$link" "$option" &&

	if [ ! -L "$link" ]; then
		ln -s "$file" "$link" &&
		echo -e "$link ${yellow}was successfully created${white}"
	else
		echo -e "$link ${red}already exist${white}"
	fi
}
copyFile() {
	file="${dotfiles_folder}${1}" &&
	destination="$2" &&
	option="$3" &&
	
	checkFile "$file" &&
	getProperties "$file" "$destination" "$option" &&

	if [ ! -e "$destination" ] || [ "$file" -nt "$link" ]; then
		cp "$file" "$link"
		echo -e "$file ${yellow}was successfully copied to ${white} $link"
	else
		echo -e "$file ${red}is the same as${white} $link"
	fi
}
makeDir() {
	if [ ! -d "$1" ]; then
		mkdir -p "$1"
		echo -e "${1}${yellow} was successfully created${white}"
	else
		echo -e "${1}${red} already exist ${white}"
	fi
}
showTitle () {
	# showTitle "title"
	# showTitle "title" ["s" (Sub-title) ]

	if [[ $2 = "sub" ]]; then
		echo -e "${yellow}********** $1 ***********${white}"
	else
		echo -e "${green}\n~~~~~~~~~~ $1 ~~~~~~~~~~\n${white}"
	fi
}


# #####################
#		PROCESSING
# #####################

echo -e "${red_bold}============================================================="
echo -e "  _____   ____       _     "
echo -e "${green} |  __ \ / __ \     | |    "
echo -e "${yellow} | |  | | |  | | ___| |__  "
echo -e "${red_bold} | |  | | |  | |/ __| '_ \ "
echo -e "${green} | |__| | |__| |\__ \ | | |"
echo -e "${yellow} |_____/ \____(_)___/_| |_|"
echo -e "                           "
echo -e "${red_bold}Create or link my dotfiles in the right place"
echo -e "============================================================="
echo -e "${white}                                                             "

showTitle "Creation of directories" &&

makeDir ~/.config/xfce4/terminal &&
makeDir ~/.config/zathura &&
makeDir ~/.config/Shiba &&
makeDir ~/.cmus &&
makeDir ~/.i3 &&

showTitle "Creation of symbolic links" &&

# Bash.
createLink bash/bash_profile ~ h &&
createLink bash/bashrc ~ h &&
# Tmux.
createLink tmux/tmux.conf ~ h &&
# Quicktile.
createLink quicktile/quicktile.cfg ~/.config &&
# Ctags
createLink ctags/ctags ~ h &&
# Zathura
createLink zathura/zathurarc ~/.config/zathura &&
# tudu
createLink tudu/tudurc ~ h &&
# cmus
createLink cmus/rc ~/.cmus &&
# ag
createLink ag/agignore ~ h &&
# i3
createLink i3 ~/.i3 &&
# Shiba
createLink shiba/config.yml ~/.config/Shiba &&
# Xmodmap
createLink xmodmap/xmodmaprc ~ h &&

showTitle "Copy files" &&

# Xfce4-terminal.
copyFile xfce4-terminal/terminalrc ~/.config/xfce4/terminal &&
# Git
copyFile git/gitconfig ~ h &&
copyFile git/gitignore_global ~ h &&

echo -e "\n" &&
exit

IFS=$DEFAULT_IFS
