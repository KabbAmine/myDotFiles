#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#################################
# Creation         : 2016-07-02
# Last modification: 2016-07-06
#
# USAGE:
# Execute it from the dofiles
# repository.
#################################

from random import randint
import configparser
import os

cwd = os.getcwd()
os.chdir(os.path.expandvars('$HOME/.dotfiles/scripts/'))

# Configuration
###############

config = configparser.ConfigParser()
config.read('../config.ini')

dot = config['PATHS']['dot']
main_scripts = config['PATHS']['scripts']

# Colors
c = {}
for k in config['COLORS']:
    c[k] = config.get('COLORS', k)
redb = c['redb']
red = c['red']
white = c['white']
green = c['green']
yellow = c['yellow']

ascii_name = [
    "  _____   ____               ",
    " |  __ \ / __ \              ",
    " | |  | | |  | | _ __  _   _ ",
    " | |  | | |  | || '_ \| | | |",
    " | |__| | |__| || |_) | |_| |",
    " |_____/ \____(_) .__/ \__, |",
    "                | |     __/ |",
    "                |_|    |___/ ",
]

# Functions
###########


def Init():

    # Print colorful ascii_name
    c2 = c.copy()
    colors = list(c2.values())
    for l in ascii_name:
        random_color = colors[randint(0, len(colors) - 1)]
        print(random_color + l)

    # Choices
    print('{}- {}[i]{}nstall'.format(white, green, white))
    print('- {}[u]{}pdate'.format(green, white))
    print('- {}[l]{}ink & copy dofiles'.format(green, white))
    print('\n- {}[q]{}uit'.format(green, white))

    inp = input(yellow + '\n> ' + white)

    if inp == 'i':
        os.system('python3 ' + main_scripts + 'install.py')
    elif inp == 'u':
        os.system('python3 ' + main_scripts + 'update.py')
    elif inp == 'l':
        os.system('python3 ' + main_scripts + 'link.py')
    else:
        print('See ya')

    # Go back to initial cwd
    os.chdir(cwd)

# Proceed
#########

Init()

