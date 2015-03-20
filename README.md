MyDotFiles
==========

This repository contains some dotfiles that I use in my GNU/Linux systems and a bash script for automation process.
Also it contains an script for automatic app & packages installation.

Content
-------

As for now it contains:

- For bash:
    * Bashrc
    * Aliases
    * Functions.
    * Script for displaying git branch name in the prompt.

- For tmux:
    * tmux.conf

- For Xfce4-terminal
    * terminal.rc

- Other files:
    * quicktile.cfg
    * gitconfig
    * ctags

- Installation script:
	* Nodejs modules (From `install/npm/packages.txt`)

![Basic terminal window](.img/screen-terminal.jpg)

Usage
-----

### Dotfiles

First specify parameters in the `do.sh` script:

1- `dotfiles_folder` variable.

2- Symbolic links to create using the following syntax:

```
createLink relative/path/to/file /absolute/path/to/link [h(if hidden file)]
```

3- Where and what files need to be copied.

```
    copyFile relative/path/to/file /absolute/path/to/destination [h(if hidden file)]
```

Then simply execute the script in a terminal to have a visible output.

### Installation script

Create a script in `install/` (*Ex.* `apt/apt.sh`) who need a password variable as 1st parameter, then add it to `install.sh`:

```
sourceFile 'apt\apt.sh' $pass &&	 #pass exists already in install.sh
```

Now, execute `install.sh` to have a visible output.

