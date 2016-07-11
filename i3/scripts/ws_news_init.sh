#!/bin/bash
# Last modification: 2016-07-11

# Layouts
layouts="$HOME/.i3/layouts/"

# Workspace name
ws="$1"

i3-msg "workspace $ws; split h; append_layout $layouts/ws-news.json"

sleep 0.5;
liferea &
corebird &
