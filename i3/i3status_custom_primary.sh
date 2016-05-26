#!/bin/bash
####################################################
#				i3status_custom_primary
####################################################

# CREATION     : 2016-05-26
# MODIFICATION : 2016-05-26
# MAINTAINER   : Kabbaj Amine <amine.kabb@gmail.com>

# DESCRIPTION
# - Custom status line to use in i3bar for primary monitor
####################################################

sep="|"

# Get current keyboard layaout
# Need https://github.com/nonpop/xkblayout-state
getLayout() {
	echo "$(xkblayout-state print %s)"
}

getCmus() {
	if [ ! -x "/usr/bin/cmus" ]
	then
		echo ""
		return 1
	fi

	status=$(cmus-remote -Q | grep "status " | cut -d " " -f 2)
	artist=$(cmus-remote -Q | grep "^tag artist " | sed -e "s/^tag artist //")
	title=$(cmus-remote -Q | grep "^tag title " | sed -e "s/^tag title //")

	if [ -z "$status" ]
	then
		echo ""
		return 1
	fi

	case $status in
		"playing" )
			icon="";;
		"paused" )
			icon="";;
		"stopped" )
			icon="";;
	esac

	if [ -z "$artist" ] && [ -z "$title" ]
	then
		echo "$icon"
	else
		echo "$icon ${artist} - ${title}"
	fi
}

# Main loop

i3status -c "~/.i3/i3status_primary.conf" | while true
do
	custom="$(getCmus) $sep $(getLayout)"
	read line
	echo "$custom $sep $line" || exit 1
done
