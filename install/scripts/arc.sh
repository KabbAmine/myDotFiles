#!/bin/bash

DEFAULT_IFS=$IFS
IFS='
'

sf='/etc/apt/sources.list'
repo="deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /"

echo "# Arc-theme" | sudo tee -a "$sf" > /dev/null

if [ -z $(grep "$repo" "$sf") ]; then
	echo -n "$repo" | sudo tee -a "$sf" > /dev/null

	wget http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key
	sudo apt-key add - < Release.key
	rm -v Release.key

	# Remove duplicates
	awk '!seen[$0]++' "$sf" | sudo tee "$sf" > /dev/null
fi

installed=$(dpkg -s arc-theme | grep Installed | cut -d ':' -f 1)
if [ "$installed" != 'Installed-Size' ]; then
	sudo apt-get -q update
	sudo apt-get -q install -y arc-theme
else
	echo "Already done"
fi

IFS=$DEFAULT_IFS
