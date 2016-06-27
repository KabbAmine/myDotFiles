#!/bin/bash

DEFAULT_IFS=$IFS
IFS='
'

sf='/etc/apt/sources.list'
repo="deb http://ag-projects.com/ubuntu xenial main"

# if [ -z $(grep "$repo" "$sf") ]; then
	echo "# Blink" | sudo tee -a "$sf" > /dev/null
	echo "$repo" | sudo tee -a "$sf" > /dev/null
	echo -n "deb-src http://ag-projects.com/ubuntu xenial main" | sudo tee -a "$sf" > /dev/null
	
	# Install AG Projects software signing key
	wget http://download.ag-projects.com/agp-debian-gpg.key 
	sudo apt-key add agp-debian-gpg.key

	rm -v agp-debian-gpg.key

	# Remove duplicates
	awk '!seen[$0]++' "$sf" | sudo tee "$sf" > /dev/null
# fi

installed=$(dpkg -s "blink" | grep Installed | cut -d ':' -f 1)
if [ "$installed" != "Installed-Size" ]; then
	sudo apt-get -q install -y blink
else
	echo "Already done"
fi

IFS=$DEFAULT_IFS
