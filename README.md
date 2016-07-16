MyDotFiles
==========

My **GNU/Linux** main repository with:

- Dot & configuration files for many different apps
- Scripts for linking dotfiles, system installation and updating.

![My terminal](.img/term.jpg "My terminal with tmux")

*N.B: This repo is frequently updated*

Content
-------

```
> tree -L 3 --dirsfirst

├── ag
│   └── agignore
├── bash
│   ├── functions
│   │   └── bash_example
│   ├── fzf
│   │   └── functions.sh
│   ├── bash_aliases
│   ├── bash_functions
│   ├── bash_profile
│   ├── bashrc
│   └── profile
├── cmus
│   ├── cmus-status-display
│   └── rc
├── ctags
│   └── ctags
├── dunst
│   └── dunstrc
├── git
│   ├── gitconfig
│   └── gitignore_global
├── i3
│   ├── blocklets
│   │   ├── cmus
│   │   ├── exit
│   │   ├── i3_restart
│   │   ├── layout
│   │   ├── menu
│   │   ├── time_and_date
│   │   ├── volume
│   │   └── weather
│   ├── scripts
│   │   ├── exit.sh
│   │   ├── helpers.sh
│   │   ├── ws_music_init.sh
│   │   └── ws_news_init.sh
│   ├── config
│   ├── i3bar_conkyrc
│   └── i3blocks_primary.conf
├── install
│   ├── scripts
│   │   ├── arc.sh
│   │   ├── blink.sh
│   │   ├── calibre.sh
│   │   ├── font.sh
│   │   ├── github_repos.sh
│   │   ├── i3.sh
│   │   ├── mineshafter.sh
│   │   ├── mkvtoolnix.sh
│   │   ├── nodejs.sh
│   │   ├── rvm.sh
│   │   └── topmenu.sh
│   ├── apt.json
│   ├── dotfiles.json
│   ├── packages.json
│   └── scripts.json
├── lyvi
│   └── lyvi.conf
├── quicktile
│   └── quicktile.cfg
├── scripts
│   ├── do.py
│   ├── install.py
│   ├── link.py
│   ├── update_github_scripts.sh
│   └── update.py
├── shiba
│   └── config.yml
├── tmux
│   ├── plugins
│   │   └── tpm
│   └── tmux.conf
├── tudu
│   └── tudurc
├── X
│   ├── xmodmaprc
│   └── Xresources
├── xfce
│   └── terminalrc
├── zathura
│   └── zathurarc
├── config.ini
└── README.md
```

Usage
-----

### What to install?

- Define dotfiles to link & copy in `install/dotfiles.json` with the syntax:

  ```json
  {
    "toLink": [
      "path/to/dotfile relative/path/to/link hidden=(True|False)",
    ],
    "toCopy": [
      "path/to/dotfile where/to/copy hidden=(True|False)",
    ]
  }
  ```

- Define apt packages and ppa's in `install/apt.json`.

- Put installation scripts in `install/scripts/` and define them in `install/scripts.json`.

- Define other packages in `install/packages.json` (gems, npm modules, pip packages & snap apps).

### How to install, update & link?

`scripts/do.py` is the main script.  

After cloning the repo the 1<sup>st</sup> time:

1. Specify the configuration in `config.ini`
2. Set the correct path in line 18 in `scripts/do.py`
4. Execute `scripts/do.py` and have fun :sunglasses:

After linking the dotfiles, you can use `Do` alias to invoke `do.py` directly.

**P.S:**

- The packages present in `install/apt.json` are intended to be used on `Xubuntu16`.
- Be aware that `config.ini` is not used by the dotfiles, only by `scripts/*`.

TODO
----

- [ ] Use a home-made sh/python framework to prevent code duplication.
- [ ] Convert `scripts/update_github_scripts.sh` to python?
- [ ] More refactoring
- [ ] A better logic?

NOTES
-----

Even if the repo is very personel, its quite easy to adapt it to other configurations.
