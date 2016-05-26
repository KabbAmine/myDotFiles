MyDotFiles
==========

This repository contains dotfiles and configuration files that I'm using on my GNU/Linux systems plus some scripts for app & packages installation.

<div style="text-align:center"><img src=".img/term.png" alt="Basic terminal window" /></div>

Content
-------

- agignore
- bash (rc, profile, aliases, functions...)
- ctags
- git:
  * gitconfig
  * A global gitignore
- i3
- quicktile.cfg
- Script for displaying git branch name in the prompt.
- tmux.conf
- CLI & graphical applications:
  * cmus: rc
  * tudu: tudurc
  * xfce4-terminal: terminal.rc
  * zathura: zathurarc
- Installation scripts:
  * Nodejs modules (From `install/npm/packages.txt`)
  * Pip packages (From `install/pip/packages.txt`)

Usage
-----

### Dotfiles

First specify parameters in the `do.sh` script:

1. `dotfiles_folder` variable.

2. Direcory(ies) to create if they does not exist:

  ```sh
  makeDir path/to/dir &&
  ```

3. Symbolic links to create using the following syntax:

  ```sh
  createLink relative/path/to/file /absolute/path/to/link [h(if hidden file)] &&
  ```

4. Where and what files need to be copied.

  ```sh
  copyFile relative/path/to/file /absolute/path/to/destination [h(if hidden file)] &&
  ```

Then simply execute the script in a terminal to have a visible output.

### Installation script

Create a script in `install/` (e.g. `apt/apt.sh`) who need a password variable as 1st parameter, then add it to `install.sh`:

```sh
sourceFile 'apt\apt.sh' $pass &&	 #pass exists already in install.sh
```

Now, execute `install.sh` to have a visible output.
