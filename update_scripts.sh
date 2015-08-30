#######################################################################
#							update_scripts.sh
#######################################################################
# Author            : Kabbaj Amine
# Date Creation     : 2015-08-30
# Last modification : 2015-08-30

# DESCRIPTION
# - Update all git projects in this directory.

# USAGE
# Define the directory in proj_dir variable then execute the script:
#	./update_scripts.sh
#######################################################################

#!/bin/bash
IFS='
'

# #####################
#		VARIABLES
# #####################

# My project's directory
proj_dir='/home/k-bag/Scripts/'

# Colors.
red_bold='\033[01;31m'
red='\033[31m'
white="\033[0m"
green="\033[01;32m"
yellow="\033[33m"

# #####################
#		FUNCTIONS
# #####################

showTitle () {
	# showTitle "title"
	# showTitle "title" ["sub" (Sub-title) ]

	if [[ $2 = "sub" ]]; then
		echo -e $yellow"********** $1 ***********\n"$white
	else
		echo -e $green"\n~~~~~~~~~~ $1 ~~~~~~~~~~\n"$white
	fi
}

# #####################
#		PROCESSING
# #####################

if [ ! -d $proj_dir ]
then
	echo -e "$red""ERROR: $white""The directory $red_bold""$proj_dir""$white doesn't exist" &&
	kill -SIGINT $$
else
	echo -e "In the directory $red_bold""$proj_dir""$white:"
fi

for d in $(ls -F $proj_dir | grep '/$' | cut -d '/' -f 1)
do
	cd "$proj_dir""$d" &&
	if [ -d ".git" ]
	then
		git_branch=$(git branch | grep '^*' | cut -d " " -f 2)
		showTitle "$d" && showTitle "$git_branch" "sub" &&
		git pull origin "$git_branch"
	fi &&
	cd ..
done
