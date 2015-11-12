#######################################################################
#								do.sh
#######################################################################
# Author            : Kabbaj Amine
# Date Creation     : 2014-06-21
# Last modification : date

# DESCRIPTION
# - Create symbolic links for my dotfiles.

# USAGE
# - Specify the dotfiles folder in the variables.
# - Specify the symbolic links and files to copy in the PROCESSING PART:
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

	if [ ! -e $1 ]; then
		echo -e "$1 "$red"does not exist."$white
		kill -SIGINT $$
	fi

}
getProperties() {

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

	file=$dotfiles_folder"$1" &&
	link=$2 &&
	option=$3 &&

	checkFile $file &&
	getProperties $file $link $option &&

	if [ ! -L "$link" ]; then
		ln -s $file $link &&
		echo -e "$link "$yellow"was successfully created"$white
	else
		echo -e "$link "$red"already exist"$white
	fi

}
copyFile() {

	file=$dotfiles_folder"$1" &&
	destination=$2 &&
	option=$3 &&
	
	checkFile $file &&
	getProperties $file $destination $option &&

	if [ ! -e $destination ] || [ $file -nt $link ]; then
		cp $file $link
		echo -e "$file "$yellow"was successfully copied to "$white" $link"
	else
		echo -e "$file "$red"is the same as"$white" $link"
	fi

}
showTitle () {
	# showTitle "title"
	# showTitle "title" ["s" (Sub-title) ]

	if [[ $2 = "sub" ]]; then
		echo -e $yellow"********** $1 ***********\n"$white
	else
		echo -e $green"\n~~~~~~~~~~ $1 ~~~~~~~~~~\n"$white
	fi

}


# #####################
#		PROCESSING
# #####################

echo -e $red_bold"============================================================="
echo -e "  _____   ____       _     "
echo -e $green" |  __ \ / __ \     | |    "
echo -e $yellow" | |  | | |  | | ___| |__  "
echo -e $red_bold" | |  | | |  | |/ __| '_ \ "
echo -e $green" | |__| | |__| |\__ \ | | |"
echo -e $yellow" |_____/ \____(_)___/_| |_|"
echo -e "                           "
echo -e $red_bold"Create or link my dotfiles in the right place"
echo -e "============================================================="
echo -e $white"                                                             "


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

showTitle "Copy files" &&

# Xfce4-terminal.
copyFile xfce4-terminal/terminalrc ~/.config/xfce4/terminal &&
# Git
copyFile git/gitconfig ~ h &&

echo -e "\n" &&
exit

IFS=$DEFAULT_IFS
