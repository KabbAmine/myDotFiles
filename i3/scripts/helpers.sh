#!/bin/bash

# CREATION     : 2016-07-06
# MODIFICATION : 2016-07-10

TERMINAL='xfce4-terminal'

get-current-width() {
	# Return the width of the current window
	# P.S: Needs xwininfo

	local h=$(xwininfo -id $(xdotool getactivewindow) | awk '/Width/{print $2}')
	echo $h
}

get-current-height() {
	# Return the height of the current window
	# P.S: Needs xwininfo

	local h=$(xwininfo -id $(xdotool getactivewindow) | awk '/Height/{print $2}')
	echo $h
}

exec-in-term() {
	# Execute $1 in a new terminal

	$TERMINAL --title="$1" -e "bash -c \"$2; exec bash\""
}

############
# I3 related
############

i3-mark() {
	i3-msg "mark --add $1"
}

i3-goto-mark() {
	i3-msg "[con_mark=\"$1\"] focus"
}
