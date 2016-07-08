#!/bin/bash

DEFAULT_IFS=$IFS
IFS='
'
fonts_dir="$HOME/.fonts"

# Get font's url
url=($(cat "$HOME/.dotfiles/config.ini" | awk '/FONTS/{getline; print $3}'))
font=$(echo "$url" | awk -F "/" '{print $NF}' | sed "s/%20/ /g" | tr -d '"')
path_to_font="${fonts_dir}/${font}"

if [ ! -d "$fonts_dir" ]; then
	mkdir -v "$fonts_dir"
	echo ""
fi

if [ -f "$path_to_font" ]; then
	mv -v "$path_to_font" "${path_to_font}_BACKUP"
	echo ""
fi

wget --no-verbose --show-progress "$url" -O "${fonts_dir}/${font}"
if [ -f "$path_to_font" ] && [ $? -eq 0 ]; then
	rm -v "${path_to_font}_BACKUP"
	echo ""
fi

IFS=$DEFAULT_IFS
