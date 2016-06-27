# Only if nodejs is not already installed
if [ ! -x "/usr/bin/nodejs" ]; then
	curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
	sudo apt-get install -y nodejs
else
	echo 'Already done'
fi

