#!/bin/bash
####################################################
#				i3status_custom_secondary
####################################################

# CREATION     : 2016-05-26
# MODIFICATION : 2016-05-26
# MAINTAINER   : Kabbaj Amine <amine.kabb@gmail.com>

# DESCRIPTION
# - Custom status line to use in i3bar for 2nd monitor
####################################################

sep="|"

getMem() {
	mem="$(free | awk 'FNR == 3 {print $3/($3+$4)*100}' | cut -d "." -f 1)"
	echo " ${mem}%"
}

# Main loop

i3status -c "~/.i3/i3status_secondary.conf" | while true
do
	read line
	custom="$(getMem)"
	if [ -n "$custom" ]
	then
		echo "$custom $sep $line" || exit 1
	else
		echo "$line" || exit 1
	fi
done
