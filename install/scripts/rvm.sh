# Only if rvm is not already installed
if [ ! -x "$HOME/.rvm/bin/rvm" ]; then
	curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
	curl -sSL https://get.rvm.io | bash -s stable --ruby
else
	echo 'Already done'
fi

