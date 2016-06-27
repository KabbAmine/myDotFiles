#!/bin/bash

# Last modification: 2016-06-25

# Clone or pull the following github repositories:
#	- byzanz-window
# 	- fzf
# 	- i3gaps
# 	- i3block
# 	- xkblayout-state
# 	- bash-git-prompt

DEFAULT_IFS=$IFS
IFS='
'

###########
# Variables
###########

# Colors.
white="\033[0m"
yellow="\033[33m"

curr_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
dir="$HOME/Scripts"

#########
# Helpers
#########

Log() {
	echo -e "\n${yellow}##### "$1" #####${white}\n"
}

###################
# Install functions
###################

byzanzWindow() {
	name="byzanz-window"
	Log "$name"
	cd "$dir"
	
	url=$(curl -s https://api.github.com/repos/syohex/byzanz-window/releases/latest | grep 'browser_' | cut -d '"' -f 4)
	file=$(echo "$url" | rev | cut -d "/" -f 1 | rev)
	
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
	sudo ln -vsf "$dir/$name/$name" /usr/local/bin/
}

fzf() {
	name="fzf"
	Log "$name"
	cd "$dir"

	if [ -d "$name" ]; then
		cd "$name"
		git pull origin master
		echo ""
	else
		git clone --depth 1 https://github.com/junegunn/fzf.git "$name" &&
		cd "$name"
		echo ""
	fi

	./install --all
}

i3gaps() {
	name="i3gaps"
	Log "$name"
	cd "$dir"

	if [ -d "$name" ]; then
		cd "$name"
		git pull origin master
		echo ""
	else
		git clone https://github.com/Airblader/i3 "$name" &&
			cd "$name"
		echo ""

		# Install dependencies
		sudo apt-get -q install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev
		echo ""
	fi

	# Compile & install
	make
	sudo make install
}

i3blocks() {
	name="i3blocks"
	Log "$name"
	cd "$dir"

	if [ -d "$name" ]; then
		cd "$name"
		git pull origin master
		echo ""
	else
		git clone https://github.com/vivien/i3blocks "$name" &&
		cd "$name"
		echo ""
	fi

	# Compile & install
	make clean all
	sudo make install
}

xkblayoutState() {
	name="xkblayout-state"
	Log "$name"
	cd "$dir"

	if [ -d "$name" ]; then
		cd "$name"
		git pull origin master
		echo ""
	else
		git clone https://github.com/nonpop/xkblayout-state "$name" &&
		cd "$name"
		echo ""
	fi

	# Compile
	make
	echo ""

	sudo ln -vfs "$dir/$name/xkblayout-state" "/usr/local/bin"
}

bashGitPrompt() {
	name="bash-git-prompt"
	Log "$name"
	cd "$dir"

	if [ -d "$name" ]; then
		cd "$name"
		git pull origin master
		echo ""
	else
		git clone https://github.com/magicmonty/bash-git-prompt.git "$name" --depth=1 &&
		cd "$name"
		echo ""
	fi

	ln -vsf "$dir/$name/gitprompt.sh" "$HOME/.gitprompt.sh"
}

##############
# Main process
##############

byzanzWindow
fzf
i3gaps
i3blocks
xkblayoutState
bashGitPrompt

cd "$curr_dir"
IFS=$DEFAULT_IFS
