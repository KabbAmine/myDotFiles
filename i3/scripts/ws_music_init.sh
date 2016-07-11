#!/bin/bash
# Last modification : 2016-07-11

# Path of current script
SC_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

# Source helpers
. "${SC_DIR}/helpers.sh"

# Layouts
layouts="$HOME/.i3/layouts/"

# The workspace name
ws="$1"

i3-msg "workspace $ws; split v; append_layout $layouts/ws-music.json"

sleep 0.5;
exec-in-term "cmus" "cmus"
geeqie -r -t
exec-in-term "lyvi" "python3 $HOME/Scripts/lyvi/lyvi.py"

