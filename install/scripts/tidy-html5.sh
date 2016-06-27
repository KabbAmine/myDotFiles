#!/bin/bash

DEFAULT_IFS=$IFS
IFS='
'

last_version=$(curl -s http://binaries.html-tidy.org/ | grep version | head -n 1 | awk '{print $4}')
file="tidy-${last_version}-64bit.deb"
url="http://binaries.html-tidy.org/binaries/tidy-${last_version}/${file}"

# We download it
wget --no-verbose "$url" -P .
echo ""

# We install it
sudo dpkg -i ${file}
echo ""

# Then we remove the installer
rm -v "$file"

IFS=$DEFAULT_IFS
