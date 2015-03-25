#######################################################################
#								install.sh
#######################################################################
# Author            : Kabbaj Amine
# Date Creation     : 2015-03-20
# Last modification : 2015-03-20

# DESCRIPTION
# - Install apps, packages & others.

# USAGE
# - Execute installation scripts from install/
#	* 
#	* sourceFile file [option]

#######################################################################

#!/bin/bash
IFS='
'

# #####################
#		VARIABLES
# #####################

# Folders.
script_folder=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
install_folder="/home/k-bag/.dotfiles/install/"

# Colors.
red='\033[31m'
red_bold='\033[01;31m'
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
showTitle () {
	# showTitle "title"
	# showTitle "title" ["s" (Sub-title) ]

	if [[ $2 = "sub" ]]; then
		echo -e $yellow"********** $1 ***********\n"$white
	else
		echo -e $green"\n~~~~~~~~~~ $1 ~~~~~~~~~~\n"$white
	fi

}
sourceFile() {

	file=$install_folder"$1" &&
	option=$2 &&
	
	checkFile $file &&
	. $file $option

}


# #####################
#		PROCESSING
# #####################

echo -e $red_bold"============================================================="
echo -e "  _____ _   _  _____ _______       _      _            _     "
echo -e $green" |_   _| \ | |/ ____|__   __|/\   | |    | |          | |    "
echo -e $yellow"   | | |  \| | (___    | |  /  \  | |    | |       ___| |__  "
echo -e $red_bold"   | | | .   |\___ \   | | / /\ \ | |    | |      / __| '_ \ "
echo -e $yellow"  _| |_| |\  |____) |  | |/ ____ \| |____| |____ _\__ \ | | |"
echo -e $green" |_____|_| \_|_____/   |_/_/    \_\______|______(_)___/_| |_|"$white
echo -e "                                                             "
echo -e $red_bold"Automatic installation of apps, packages & others"
echo -e "============================================================="
echo -e $white"                                                             "

# Ask for root pass
read -sp "Give me your password and I'm gonna BURN the world! > " pass &&
	echo -e "\n" &&

# Nodejs modules
showTitle "Install nodejs packages" &&

sourceFile "npm/npm_install.sh" $pass &&

echo -e "\n" &&
exit
