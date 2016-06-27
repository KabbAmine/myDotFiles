#######################################################################
#							update_scripts.sh
#######################################################################
# Author            : Kabbaj Amine
# Date Creation     : 2015-08-30
# Last modification : 2016-06-27

# DESCRIPTION
# - Update all git projects in the defined directories

# USAGE
# Define the directories in proj_dirs variable then execute the script:
#	./update_scripts.sh
#######################################################################

#!/bin/bash
DEFAULT_IFS=$IFS
IFS='
'

# #####################
#		VARIABLES
# #####################

# Folders
curr_dir=$(pwd)
proj_dirs=("$HOME/Scripts/misc/" "$HOME/Scripts/minetest/mods/" "$HOME/Scripts/minetest/textures/")

# Colors.
red_bold='\033[01;31m'
red='\033[31m'
white="\033[0m"
green="\033[01;32m"
yellow="\033[33m"

# #####################
#		FUNCTIONS
# #####################

Echo () {
	# If $1 is:
	# - 0, echo $2 in yellow (ok).
	# - 1, echo in green (upd).
	# - 2, echo in red (err).

	if [ ${1} == 0 ]; then
		echo -e "${yellow}[OK] ${d} (${git_branch}) ${white}"
	elif [ ${1} == 1 ]; then
		echo -e "${green}[UPD] ${d} (${git_branch}) ${white}"
	else
		echo -e "${red_bold}[ERR] ${d} (${git_branch}) ${white}"
	fi
}

# #####################
#		PROCESSING
# #####################

echo -e "\n${green}####################################"
echo -e "\tGIT REPOS UPDATE\t"
echo -e "####################################${white}\n"

for proj_dir in ${proj_dirs[*]}; do

	if [ ! -d $proj_dir ]
	then
		echo -e "${red}ERROR: ${white}The directory ${red_bold}${proj_dir}${white} doesn't exist" &&
		kill -SIGINT $$
	else
		echo -e "In the directory ${red_bold}${proj_dir}${white}:"
	fi

	updated=0
	errors=0
	for d in $(ls -F $proj_dir | grep '/$' | cut -d '/' -f 1)
	do
		cd "${proj_dir}${d}" &&
		if [ -d ".git" ]
		then
			git_branch=$(git branch  2> /dev/null | grep '^*' | cut -d " " -f 2)
			git fetch origin ${git_branch} --quiet 2> /dev/null &&
			git_log=$(git log HEAD..origin/${git_branch} --oneline 2> /dev/null | head -n 1)
			# If git_log is empty, then no need to update
			if [ $? != 0 ]; then
				errors=$((errors+1))
				Echo 2 ${d} ${git_branch}
				# : go allows to quit condition (break-like)
				# :
			elif [ -z ${git_log} ]; then
				Echo 0 ${d} ${git_branch}
			else
				Echo 1 ${d} ${git_branch}
				git merge origin/${git_branch} --quiet
				# Stock updated repos number
				updated=$((updated+1))
			fi
		fi
		cd ..
	done
	if [ ${errors} != 0 ]; then
		echo -e "${red_bold}---> ${errors}${white} error(s) occured"
	fi
	if [ ${updated} != 0 ]; then
		echo -e "${green}---> ${updated}${white} repo(s) updated"
	else
		echo -e "---> Nothing to update"
	fi

	echo -e "" &&
	cd "$curr_dir"

done

IFS=$DEFAULT_IFS
