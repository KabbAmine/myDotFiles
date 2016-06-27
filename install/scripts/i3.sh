#!/bin/bash

DEFAULT_IFS=$IFS
IFS='
'

sf='/etc/apt/sources.list'
repo="deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe"

if [ -z $(grep "$repo" "$sf") ]; then
	echo "# I3" | sudo tee -a "$sf" > /dev/null
	echo -n "$repo" | sudo tee -a "$sf" > /dev/null
	
	# Remove duplicates
	awk '!seen[$0]++' "$sf" | sudo tee "$sf" > /dev/null
	
	sudo apt-get update
	sudo apt-get --allow-unauthenticated install -y sur5r-keyring
fi

installed=$(dpkg -s libxcb-xrm-dev | grep Installed | cut -d ':' -f 1)
if [ "$installed" != 'Installed-Size' ]; then
	sudo apt-get -q update
	# A depency for i3gaps
	sudo apt-get -q install -y libxcb-xrm-dev
	# sudo apt-get install -y i3
	sudo apt-get -q remove --purge -y dunst
else
	echo 'Already done'
fi

IFS=$DEFAULT_IFS
