#!/bin/bash

####################################################
# CREATION     : 2016-06-01
# MODIFICATION : 2016-06-01

# I3block's blocklet which using xkblayout-state:
# - Display current keyboard layout
# - Set next/previous layout with the mouse
####################################################

case $BLOCK_BUTTON in
    4) xkblayout-state set -1;;  # wheel up
    5) xkblayout-state set +1;;  # wheel down
esac

layout=$(xkblayout-state print %s)

echo "$layout"
echo "$layout"
echo
