#!/bin/bash

####################################################
# CREATION     : 2016-06-02
# MODIFICATION : 2016-06-02
####################################################

DEFAULT_IFS=$IFS
IFS='
'

case $1 in
	'reboot') sudo reboot;;
	'shutdown') sudo shutdown -h now;;
	'suspend') sudo pm-suspend;;
esac

IFS=$DEFAULT_IFS
