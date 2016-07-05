#!/bin/bash

###############################
# Modification: 2016-07-06
#
# Download, clone or pull github releases/repositories.
#	- bash-git-prompt
#	- byzanz-window
#	- fzf
#	- i3block
#	- i3gaps
#	- tidy-html5
#	- xkblayout-state
#	- glyr
#	- lyvi
###############################

DEFAULT_IFS=$IFS
IFS='
'

###########
# Variables
###########

# Colors.
white="\033[0m"
blue="\033[34m"

curr_dir=$(pwd)
dir="$HOME/Scripts"

#########
# Helpers
#########

Log() {
	echo -e "\n${blue}# "$1"${white}\n"
}

###################
# Install functions
###################

byzanzWindow() {
	local local name="byzanz-window"
	Log "$name"
	cd "$dir"

	local repo="https://api.github.com/repos/syohex/byzanz-window/releases/latest"
	local url=$(curl -s "$repo" | grep 'browser_' | cut -d '"' -f 4)
	local last_version=$(curl -s "$repo" | grep 'tag_name' | cut -d '"' -f 4 | tr -d "v")
	local file=$(echo "$url" | rev | cut -d "/" -f 1 | rev)

	if [ -x "/usr/local/bin/$name" ]; then
		local current_version=$($name -v)
	else
		local current_version=""
	fi

	if [ "$current_version" == "$last_version" ]; then
		echo "Already up-to-date."
	else
		# We remove it if it already exists
		if [ -d "$name" ]; then
			rm -vrf "$name"
			echo ""
		fi

		# We download it
		wget --no-verbose "$url" -P .
		echo ""

		mkdir -v "$name"
		echo ""

		# We extract in the new folder
		tar -vzxf "$file" -C "$name" --strip-components=1
		echo ""

		rm -vfr "$file"
		cd "$name"
		echo ""

		chmod -v +x "$name"
		echo ""

		sudo ln -vsf "$dir/$name/$name" "/usr/local/bin/"
		echo ""
	fi
}

tidyHtml5() {
	local name="tidy-html5"
	Log "$name"
	cd "$dir"

	if [ -d "$name" ]; then
		cd "$name"
		# Execute & stock
		local state=$(git pull origin master)
		echo ""
	else
		git clone https://github.com/htacg/tidy-html5 "$name" &&
		cd "$name"
		echo ""
	fi

	if [ "$state" == "Already up-to-date." ]; then
		echo $state
	else
		# Install requirements
		sudo apt-get -q install -y cmake xsltproc
		echo ""

		# Compile
		cd build/cmake
		cmake ../..
		make clean
		make
		echo ""

		# Link
		sudo ln -vfs "$dir/$name/build/cmake/tidy" "/usr/local/bin/tidy5"
		echo ""
	fi
}

fzf() {
	local name="fzf"
	Log "$name"
	cd "$dir"

	if [ -d "$name" ]; then
		cd "$name"
		local state=$(git pull origin master)
		echo ""
	else
		git clone --depth 1 https://github.com/junegunn/fzf.git "$name" &&
		cd "$name"
		echo ""
	fi

	if [ "$state" == "Already up-to-date." ]; then
		echo "$state"
	else
		./install --all
		echo ""
	fi
}

i3gaps() {
	local name="i3gaps"
	local branch="gaps-next"
	Log "$name (${branch})"
	cd "$dir"

	if [ -d "$name" ]; then
		cd "$name"
		local state=$(git pull origin "$branch")
		echo ""
	else
		git clone https://github.com/Airblader/i3 "$name" &&
		cd "$name"
		echo ""

		# Install dependencies
		sudo apt-get -q install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev
		echo ""
	fi

	if [ "$state" == "Already up-to-date." ]; then
		echo "$state"
	else
		# Compile & install
		make
		sudo make install
		echo ""
	fi
}

i3blocks() {
	local name="i3blocks"
	Log "$name"
	cd "$dir"

	if [ -d "$name" ]; then
		cd "$name"
		local state=$(git pull origin master)
		echo ""
	else
		git clone https://github.com/vivien/i3blocks "$name" &&
		cd "$name"
		echo ""
	fi

	if [ "$state" == "Already up-to-date." ]; then
		echo "$state"
	else
		# Compile & install
		make clean all
		sudo make install
		echo ""
	fi
}

xkblayoutState() {
	local name="xkblayout-state"
	Log "$name"
	cd "$dir"

	if [ -d "$name" ]; then
		cd "$name"
		local state=$(git pull origin master)
		echo ""
	else
		git clone https://github.com/nonpop/xkblayout-state "$name" &&
		cd "$name"
		echo ""
	fi

	if [ "$state" == "Already up-to-date." ]; then
		echo "$state"
	else
		# Compile
		make
		echo ""

		sudo ln -vfs "$dir/$name/xkblayout-state" "/usr/local/bin"
		echo ""
	fi
}

bashGitPrompt() {
	local name="bash-git-prompt"
	Log "$name"
	cd "$dir"

	if [ -d "$name" ]; then
		cd "$name"
		local state=$(git pull origin master)
		echo ""
	else
		git clone https://github.com/magicmonty/bash-git-prompt.git "$name" --depth=1 &&
		cd "$name"
		echo ""
	fi

	if [ "$state" == "Already up-to-date." ]; then
		echo "$state"
	else
		ln -vsf "$dir/$name/gitprompt.sh" "$HOME/.gitprompt.sh"
		echo ""
	fi
}

glyr() {
	local name="glyr"
	Log "$name"
	cd "$dir"

	if [ -d "$name" ]; then
		cd "$name"
		local state=$(git pull origin master)
		echo ""
	else
		git clone https://github.com/sahib/glyr "$name" &&
		cd "$name"
		echo ""
	fi

	if [ "$state" == "Already up-to-date." ]; then
		echo "$state"
	else

		# Compilation & installation
		cmake -DCMAKE_INSTALL_PREFIX=/usr .
		make
		sudo make install
		echo ""
	fi
}

lyvi() {
	local name="lyvi"
	Log "$name"
	cd "$dir"

	if [ -d "$name" ]; then
		cd "$name"
		local state=$(git pull origin master)
		echo ""
	else
		git clone https://github.com/ok100/lyvi "$name" &&
		cd "$name"
		echo ""
	fi

	if [ "$state" == "Already up-to-date." ]; then
		echo "$state"
	else
		# N.B: GLYR IS A REQUIREMENT (CHECK PREVIOUS FUNCTION)

		# Pip requirements
		sudo -H pip3 install --upgrade cython
		sudo -H pip3 install --upgrade -r pip_requirements.txt
		echo ""

		sudo ln -vsf "$dir/$name/lyvi.py" "/usr/local/bin/lyvi"
		echo ""
	fi
}

##############
# Main process
##############

bashGitPrompt
byzanzWindow
fzf
i3blocks
i3gaps
tidyHtml5
xkblayoutState
glyr
lyvi

cd "$curr_dir"
IFS=$DEFAULT_IFS
