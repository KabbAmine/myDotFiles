#!/bin/bash

DEFAULT_IFS=$IFS
IFS='
'

url="https://api.github.com/repos/kovidgoyal/calibre/releases/latest"

install() {
	sudo -v && wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"
}

if [ ! -x '/usr/bin/calibre' ]; then
	install
else
	current_version=$(calibre --version | awk '{print $3}' | tr -d ')')
	last_version=$(curl -s $url | grep 'tag_name' | cut -d '"' -f 4 | tr -d 'v')

	if [ "$current_version" == "$last_version" ]; then
		echo "Already up-to-date"
	else
		install
	fi
fi

IFS=$DEFAULT_IFS
