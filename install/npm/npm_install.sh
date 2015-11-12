# ############################################
# Last modification: 2015-11-12
# ############################################
# DESCRIPTION
# Install node packages listed in packages.txt
# if npm is present.
#
# USAGE
# ./script root_pass
# ############################################

DEFAULT_IFS=$IFS
IFS="
"

# Pass for sudo
pass=${1:?"Need a pass for global installation"}

# Current dir
SC_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)

# Colors.
red='\033[;31m'
white="\033[0m"
green="\033[32m"
yellow="\033[33m"

# Npm path
npm_bin="/usr/bin/npm"

# Npm packages
packages_file="${SC_DIR}/packages.txt"
packages=$(cat $packages_file)

if [ -x $npm_bin ]; then
	if [ -f $packages_file ]; then
		for p in $packages; do
			echo -e $red"$p ===>"$white
			echo -e "$pass\n" | sudo -S npm install -g $p
			echo -e $red"<=== $p\n"$white
		done
	fi
else
	echo -e $red"Npm not found"$white
fi

IFS=$DEFAULT_IFS
