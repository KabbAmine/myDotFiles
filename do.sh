#######################################################################
#								do.sh
#######################################################################
# Author            : Kabbaj Amine
# Date Creation     : 2014-06-21
# Last modification : 2014-06-25

# DESCRIPTION
# - Create symbolic links for my dotfiles.

# USAGE
# - Specify the dotfiles folder in the variables.
# - Specify the symb links in the PROCESSING PART:
#	* createLink file link [h(If hidden)]

# TODO
# - Test if file newer that link (-nt?).
# - Create the symb links with a loop (Stock the informations in a dict-like if possible).
#######################################################################

#!/bin/bash
IFS='
'

# #####################
#		VARIABLES
# #####################

# Folders.
script_folder=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
dotfiles_folder="/home/k-bag/.dotfiles/"

# Colors.
red="\033[31m"
white="\033[0m"
green="\033[32m"
yellow="\033[33m"


# #####################
#		FUNCTIONS
# #####################

checkFile() {

	if [ ! -e $1 ]; then
		echo -e $red"$1"$white" does not exist."
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
		echo -e $yellow"$link"$white" was successfully created"
	else
		ln -sfn $file $link &&
		echo -e $yellow"$link"$white" was successfully updated"
	fi

}
showTitle () {

	echo -e $green"\n~~~~~~~~~~ $1 ~~~~~~~~~~\n"$white

}


# #####################
#		PROCESSING
# #####################

showTitle "Creation of symbolic links" &&

# Bash.
createLink bash/bash_profile ~ h &&
createLink bash/bashrc ~ h &&
# Tmux.
createLink tmux/tmux.conf ~ h &&
# Quicktile.
createLink quicktile/quicktile.cfg ~/.config &&
# Stjerm.
createLink stjerm/Xdefaults ~ h &&
# Xfce4-terminal.
createLink xfce4-terminal/terminalrc ~/.config/xfce4/terminal &&

echo -e "\n" &&
exit
