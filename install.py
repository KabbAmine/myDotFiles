#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#################################
# Creation         : 2016-06-13
# Last modification: 2016-06-27
#################################

from json import loads
from os import system, path
from subprocess import Popen, PIPE

######################
# Global variables
######################

# Release
p = Popen(['lsb_release', '-c', '-s'], stdout=PIPE)
release = str(p.stdout.read())[2:-3]

# Colors
c = {
    'redB': '\033[01;31m',
    'white': '\033[0m',
    'green': '\033[32m',
    'red':  '\033[31m',
    'yellow': '\033[33m',
}

# Get datas from json files
apt = loads(open('install/apt.json').read())
packages = loads(open('install/packages.json').read())
scripts = loads(open('install/scripts.json').read())

######################
# Configuration
######################

_ = {
    'apt': apt['packages'],
    'ppa': apt['ppa'],
    'remove': apt['toRemove'],
    'npm': packages['npm'],
    'pip': packages['pip'],
    'ruby': packages['ruby'],
    'scripts': scripts,
}

#########
# Helpers
#########


def Log(msg, type=1):
    sep = ('#' * 10) if (type == 1) else ('-' * 10)
    color = (c['redB']) if (type == 1) else (c['green'])
    print('\n{0}{1} {2} {1}{3}\n'.format(color, sep, msg, c['white']))


def RemoveApt():
    Log('Remove default applications')
    apt = _['remove']
    packages = ''
    for cat in apt:
        packages += ' '.join(apt) + ' '
    system('sudo apt-get -q remove --purge -y ' + packages)


def Apt(args):
    for arg in args.split():
        Log('APT: ' + arg, 2)
        system('sudo apt-get -q ' + arg + ' -y')


def InstallScripts():
    Log('Scripts')
    scripts = _['scripts']
    for script in scripts:
        Log(script + '.sh', 2)
        system('bash install/scripts/' + script + '.sh')


def InstallPPA():
    Log("PPA's")
    ppas = _['ppa']
    packages = ''
    for ppa in ppas:
        Log("PPA: " + ppa, 2)

        l = ppa.split('/')

        file = l[0].replace('.', '_')
        file += '-ubuntu-' + l[1] + '-' + release + '.list'
        packages += ' '.join(ppas[ppa]) + ' '

        if not path.isfile('/etc/apt/sources.list.d/' + file):
            system('sudo add-apt-repository -y ppa:' + ppa)
        else:
            print(ppa + ' exists already')

    Apt('update')
    system('sudo apt-get -q install -y ' + packages)


def InstallApt():
    Log('Default repos')
    apt = _['apt']
    packages = ''
    for cat in apt:
        packages += ' '.join(apt[cat]) + ' '
    system('sudo apt-get -q install -y ' + packages)


def InstallNpm():
    Log('Nodejs')
    packages = _['npm']
    for p in packages:
        Log('Npm: ' + p, 2)
        system('sudo npm i -g ' + p)


def InstallGems():
    Log('Ruby')
    gems = _['ruby']
    for g in gems:
        Log('Ruby: ' + g, 2)
        system('gem install ' + g)


def InstallPip():
    Log('Pip')
    pips = _['pip']
    for p in pips:
        Log('Pip: ' + p, 2)
        system('sudo -H pip3 install --upgrade ' + p)

##############
# Main process
##############

print(c['redB'] + '  _____ _   _  _____ _______       _      _                    ')
print(c['green'] + " |_   _| \ | |/ ____|__   __|/\   | |    | |                   ")
print(c['yellow'] + "   | | |  \| | (___    | |  /  \  | |    | |       _ __  _   _ ")
print(c['redB'] + "   | | | . ` |\___ \   | | / /\ \ | |    | |      | '_ \| | | |")
print(c['green'] + "  _| |_| |\  |____) |  | |/ ____ \| |____| |____ _| |_) | |_| |")
print(c['yellow'] + " |_____|_| \_|_____/   |_/_/    \_\______|______(_) .__/ \__, |")
print("                                                  | |     __/ |")
print("                                                  |_|    |___/ ")
print("                           ")
print(c['white'] + '                                    ')

RemoveApt()
Apt('update upgrade')

InstallPPA()
InstallApt()
InstallScripts()
InstallNpm()
InstallGems()
InstallPip()

Apt('update upgrade')
Apt('autoremove autoclean')
