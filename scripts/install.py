#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#################################
# Creation         : 2016-06-13
# Last modification: 2016-07-05
#################################

from json import loads
from os import system, path
import configparser

######################
# Global variables
######################

config = configparser.ConfigParser()
config.read('../config.ini')

dot = config['PATHS']['dot']
main_scripts = config['PATHS']['scripts']

release = config['OS']['release']

# Colors
c = {}
for k in config['COLORS']:
    c[k] = config.get('COLORS', k)

# Get datas from json files
apt = loads(open(config['INSTALL']['apt']).read())
packages = loads(open(config['INSTALL']['packages']).read())
scripts = loads(open(config['INSTALL']['scripts']).read())

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
    'snap': packages['snap'],
    'scripts': scripts,
}

#########
# Helpers
#########


def Log(msg, type=1):
    msg = '#  ' + msg
    if type == 1:
        msg = '{0}{2}\n{3}\n{2}{1}'.format(
            c['green'], c['white'], ('#' * 20), msg
        )
    elif type == 2:
        msg = '{0}{3}\n{2}{1}'.format(
            c['yellow'], c['white'], ('#' * 20), msg
        )
    else:
        msg = '{0}{2}{1}'.format(c['blue'], c['white'], msg)
    print('\n' + msg + '\n')


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
        system('bash ' + dot + 'install/scripts/' + script + '.sh')


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
    if len(packages) != 0:
        for p in packages:
            Log('Npm: ' + p, 2)
            system('sudo npm i --silent -g ' + p)


def InstallGems():
    Log('Ruby')
    gems = _['ruby']
    if len(gems) != 0:
        for g in gems:
            Log('Ruby: ' + g, 2)
            system('gem install ' + g)


def InstallPip():
    Log('Pip')
    pips = _['pip']
    if len(pips) != 0:
        for p in pips:
            Log('Pip: ' + p, 2)
            system('sudo -H pip3 install --upgrade ' + p)


def InstallSnap():
    Log('Snap')
    snaps = _['snap']
    if len(snaps) != 0:
        for s in snaps:
            Log('Snap: ' + s, 2)
            system('sudo snap install ' + s)


def Main():
    answer = True
    while answer:

        print(c['redb'] + '''
######################
#
#       INSTALL
#
######################
        ''' + c['white'])

        print('- {}[*]{} Everything'.format(c['green'], c['white']))

        print('\n- {}[a]{} Apt applications'.format(c['green'], c['white']))
        print("- {}[p]{} Ppa's".format(c['green'], c['white']))
        print('- {}[s]{} Scripts'.format(c['green'], c['white']))
        print('- {}[n]{} Npm packages'.format(c['green'], c['white']))
        print('- {}[g]{} Gems with rvm'.format(c['green'], c['white']))
        print('- {}[pi]{} Pip packages'.format(c['green'], c['white']))
        print('- {}[sn]{} Snap packages'.format(c['green'], c['white']))

        print('\n- {}[0]{} Go back'.format(c['green'], c['white']))
        print('- {}[q]{} quit'.format(c['green'], c['white']))

        inp = input(c['yellow'] + '\n> ' + c['white'])
        print()

        if inp == '*':
            RemoveApt()
            Apt('update upgrade')
            for f in ['PPA', 'Apt', 'Scripts', 'Npm', 'Gems', 'Pip', 'Snap']:
                globals()['Install' + f]()
            Apt('update upgrade')
            Apt('autoremove autoclean')
            print()
        elif inp == 'a':
            RemoveApt()
            InstallApt()
            Apt('update upgrade')
            Apt('autoremove autoclean')
            print()
        elif inp == 'p':
            InstallPPA()
            Apt('update upgrade')
            Apt('autoremove autoclean')
            print()
        elif inp == 's':
            InstallScripts()
            print()
        elif inp == 'n':
            InstallNpm()
            print()
        elif inp == 'g':
            InstallGems()
            print()
        elif inp == 'pi':
            InstallPip()
            print()
        elif inp == 'sn':
            InstallSnap()
            print()
        elif inp == '0':
            system('python3 ' + main_scripts + 'do.py')
            answer = False
        else:
            print('See ya')
            answer = False


##############
# Main process
##############

Main()
