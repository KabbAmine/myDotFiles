#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#################################
# Creation         : 2016-06-27
# Last modification: 2016-06-27
#################################

from json import loads
from os import system

######################
# Global variables
######################

# Colors
c = {
    'redB': '\033[01;31m',
    'white': '\033[0m',
    'green': '\033[32m',
    'red':  '\033[31m',
    'yellow': '\033[33m',
}

# Get datas from json files
packages = loads(open('install/packages.json').read())
scripts = loads(open('install/scripts.json').read())

######################
# Configuration
######################

_ = {
    'pip': packages['pip'],
    'scripts': scripts,
}

#########
# Helpers
#########


def Log(msg, type=1):
    sep = ('#' * 10) if (type == 1) else ('-' * 10)
    color = (c['redB']) if (type == 1) else (c['green'])
    print('\n{0}{1} {2} {1}{3}\n'.format(color, sep, msg, c['white']))


def Apt(args):
    for arg in args.split():
        Log('APT: ' + arg, 2)
        system('sudo apt-get -q ' + arg + ' -y')


def UpdateScripts():
    Log('Scripts')
    scripts = _['scripts']
    for script in scripts:
        Log(script + '.sh', 2)
        system('bash install/scripts/' + script + '.sh')


def UpdateNpm():
    Log('Nodejs')
    system('sudo npm update -g')


def UpdateRuby():
    Log('Rvm & Gems')
    system('rvm get stable && gem update')


def UpdatePip():
    Log('Pip')
    pips = _['pip']
    for p in pips:
        Log('Pip: ' + p, 2)
        system('sudo -H pip3 install --upgrade ' + p)

def UpdateGitScripts():
    Log('Git repositories')
    system('bash update_scripts.sh')

##############
# Main process
##############

print(c['redB'] + "  _    _ _____  _____       _______ ______               ")
print(c['green'] + " | |  | |  __ \|  __ \   /\|__   __|  ____|              ")
print(c['yellow'] + " | |  | | |__) | |  | | /  \  | |  | |__     _ __  _   _ ")
print(c['redB'] + " | |  | |  ___/| |  | |/ /\ \ | |  |  __|   | '_ \| | | |")
print(c['green'] + " | |__| | |    | |__| / ____ \| |  | |____ _| |_) | |_| |")
print(c['yellow'] + "  \____/|_|    |_____/_/    \_\_|  |______(_) .__/ \__, |")
print("                                            | |     __/ |")
print("                                            |_|    |___/ ")
print(c['white'] + '                                    ')

Apt('update upgrade')

UpdateScripts()
UpdateNpm()
UpdatePip()
UpdateRuby()
UpdateGitScripts()

Apt('autoremove autoclean')
