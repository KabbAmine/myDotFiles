#!/bin/bash

DEFAULT_IFS=$IFS
IFS='
'

wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install-papirus-root.sh | sh

# libre-office
wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-libreoffice-theme/master/install-papirus-root.sh | sh

# smplayer
sudo mkdir -vp /usr/share/smplayer/themes &&
wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-smplayer-theme/master/install-papirus-root.sh | sh


IFS=$DEFAULT_IFS
