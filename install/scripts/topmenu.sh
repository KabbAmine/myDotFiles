#!/bin/bash

DEFAULT_IFS=$IFS
IFS='
'

installed=$(dpkg -s xfce4-topmenu-plugin | grep Installed | cut -d ':' -f 1)
if [ "$installed" != 'Installed-Size' ]; then
	sudo apt-get -q install -y xfce4-topmenu-plugin libtopmenu-client-gtk2-0 libtopmenu-server-gtk2-0 libtopmenu-client-gtk3-0 libtopmenu-server-gtk3-0 topmenu-gtk2 topmenu-gtk3
else
	echo "Already done"
fi

# Load topmenu
echo -e '#!/bin/bash\nexport GTK_MODULES=$GTK_MODULES:topmenu-gtk-module' | sudo tee /etc/profile.d/topmenu-gtk.sh > /dev/null

IFS=$DEFAULT_IFS
