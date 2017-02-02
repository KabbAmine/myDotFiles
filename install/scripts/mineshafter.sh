#!/bin/bash

DEFAULT_IFS=$IFS
IFS='
'

url="https://mineshafter.info/files/jars/Mineshafter-launcher.jar"
name="Mineshafter-launcher.jar"
path="$HOME/.minecraft"
file="${path}/${name}"

# Create the path in all cases
mkdir -vp "$path"

# Backup old jar file
if [ -f "$file" ]; then
	mv -v "$file" "${file}_BACKUP"
	echo ""
fi

wget --no-verbose --show-progress "$url" -O "$file"
if [ -f "$file" ] && [ $? -eq 0 ]; then
	rm -v "${file}_BACKUP"
	echo ""
fi

chmod -v +x "${file}"
echo ""

sudo ln -svf "$file" /usr/local/bin/minecraft
echo ""

IFS=$DEFAULT_IFS
