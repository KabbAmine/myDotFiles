#!/bin/bash

DEFAULT_IFS=$IFS
IFS='
'

sf='/etc/apt/sources.list'
repo="deb http://mkvtoolnix.download/ubuntu/xenial/ ./"

if [ -z $(grep "$repo" "$sf") ]; then
	echo "# Mkvtoolnix" | sudo tee -a "$sf" > /dev/null
	echo "$repo" | sudo tee -a "$sf" > /dev/null
	echo -n "deb-src http://mkvtoolnix.download/ubuntu/xenial/ ./" | sudo tee -a "$sf" > /dev/null
	
	wget -q -O - https://mkvtoolnix.download/gpg-pub-moritzbunkus.txt | sudo apt-key add -
	
	# Remove duplicates
	awk '!seen[$0]++' "$sf" | sudo tee "$sf" > /dev/null
fi

installed1=$(dpkg -s mkvtoolnix | grep Installed | cut -d ':' -f 1)
installed2=$(dpkg -s mkvtoolnix-gui | grep Installed | cut -d ':' -f 1)
if [ "$installed1" != 'Installed-Size' ] && [ "$installed2" != 'Installed-Size' ]; then
	sudo apt-get -q install -y mkvtoolnix mkvtoolnix-gui
else
	echo "Already done"
fi

IFS=$DEFAULT_IFS
