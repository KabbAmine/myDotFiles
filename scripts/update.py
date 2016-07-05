#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#################################
# Creation         : 2016-06-27
# Last modification: 2016-07-06
#################################

from json import loads
from os import system, getcwd
import configparser

######################
# Global variables
######################

config = configparser.ConfigParser()
config.read('../config.ini')

dot = config['PATHS']['dot']
main_scripts = config['PATHS']['scripts']

# Colors
c = {}
for k in config['COLORS']:
    c[k] = config.get('COLORS', k)

# Get datas from json files
packages = loads(open(config['INSTALL']['packages']).read())
scripts = loads(open(config['INSTALL']['scripts']).read())

######################
# Configuration
######################

_ = {
    'pip': packages['pip'],
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
    else:
        msg = '{0}\n{3}\n{2}{1}'.format(
            c['yellow'], c['white'], ('#' * 20), msg
        )
    print('\n' + msg + '\n')


def Apt(args):
    for arg in args.split():
        Log('APT: ' + arg, 2)
        system('sudo apt-get -q ' + arg + ' -y')


def UpdateScripts():
    Log('Scripts')
    scripts = _['scripts']
    for script in scripts:
        Log(script + '.sh', 2)
        system('bash ' + dot + 'install/scripts/' + script + '.sh')


def UpdateNpm():
    Log('Nodejs')
    system('sudo npm update --silent -g')


def UpdateRuby():
    Log('Rvm & Gems')
    system('rvm get stable && gem update')


def UpdatePip():
    Log('Pip')
    pips = _['pip']
    for p in pips:
        Log('Pip: ' + p, 2)
        system('sudo -H pip3 install --upgrade ' + p)


def UpdateSnap():
    Log('Snap')
    snaps = _['snap']
    if len(snaps) != 0:
        for s in snaps:
            Log('Snap: ' + s, 2)
            system('sudo snap refresh ' + s)


def UpdateGitScripts():
    Log('Git repositories')
    system('bash ' + main_scripts + 'update_github_scripts.sh')


def Main():
    print(getcwd())
    answer = True
    while answer:

        print(c['redb'] + '''
######################
#
#       UPDATE
#
######################
        ''' + c['white'])

        print('- {}[*]{} Everything'.format(c['green'], c['white']))

        print('\n- {}[a]{} Apt applications'.format(c['green'], c['white']))
        print('- {}[s]{} Scripts'.format(c['green'], c['white']))
        print('- {}[n]{} Npm packages'.format(c['green'], c['white']))
        print('- {}[g]{} Gems packages'.format(c['green'], c['white']))
        print('- {}[pi]{} Pip packages'.format(c['green'], c['white']))
        print('- {}[sn]{} Snap packages'.format(c['green'], c['white']))
        print('- {}[gi]{} Git scripts'.format(c['green'], c['white']))

        print('\n- {}[0]{} Go back'.format(c['green'], c['white']))
        print('- {}[q]{} quit'.format(c['green'], c['white']))

        inp = input(c['yellow'] + '\n> ' + c['white'])
        print()

        if inp == '*':
            Apt('update upgrade')
            for f in ['Scripts', 'Npm', 'Pip', 'Ruby', 'GitScripts']:
                globals()['Update' + f]()
            Apt('autoremove autoclean')
            print()
        elif inp == 'a':
            Apt('update upgrade')
            Apt('autoremove autoclean')
            print()
        elif inp == 's':
            UpdateScripts()
            print()
        elif inp == 'n':
            UpdateNpm()
            print()
        elif inp == 'g':
            UpdateRuby()
            print()
        elif inp == 'pi':
            UpdatePip()
            print()
        elif inp == 'sn':
            UpdateSnap()
            print()
        elif inp == 'gi':
            UpdateGitScripts()
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
