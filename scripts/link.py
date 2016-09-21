#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#################################
# Creation         : 2016-07-02
# Last modification: 2016-09-21
#################################

# Import variables
# from do import config, dot

from json import loads
import configparser
import os


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

# Links
dotfiles = loads(open(config['INSTALL']['dotfiles']).read())

###########
# Helpers
###########


def Echo(msg, type=1):
    ''' 1 is success, 2 is error and 3 is warning '''

    if type == 1:
        print(c['green'] + msg + c['white'])
    elif type == 2:
        print(c['red'] + msg + c['white'])
    else:
        print(c['yellow'] + msg + c['white'])


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


def CheckFile(file):
    file = dot + os.path.expanduser(file)
    if not os.path.isfile(file):
        Echo(file + ' does not exist', 2)
        return False
    return True


def GetProps(file, to, hidden=False):
    name = os.path.split(file)[1]
    path = os.path.split(file)[0] + '/'
    to = os.path.expanduser(to) + '/'
    return {
        'name': file,
        'from_file': dot + path + name,
        'to': to + ('.' if hidden else '') + name,
    }


def MakeDirs(file):
    path = os.path.split(file)[0]
    path = os.path.expanduser(path)
    if not os.path.isdir(path):
        os.makedirs(path)


def Create(file, to, hidden=False, link=True):

    if not CheckFile(file):
        return 0

    props = GetProps(file, to, hidden)

    name = props['name']
    from_file = props['from_file']
    to = props['to']

    MakeDirs(to)

    if link:
        if not os.path.islink(props['to']):
            os.system('ln -s "{}" "{}"'.format(from_file, to))
            Echo(to + ' was successfully created')
        else:
            os.system('ln -fs "{}" "{}"'.format(from_file, to))
            Echo(to + ' was replaced', 3)
    else:
        if not os.path.isfile(props['to']):
            os.system('cp "{}" "{}"'.format(from_file, to))
            Echo(name + ' was successfully copied to ' + to)
        else:
            Echo(to + ' already exists', 2)


def Link():
    Log('Link files')
    to_link = dotfiles['toLink']
    if len(to_link) != 0:
        for c in to_link:
            def doubleQuote(e): return '"{}"'.format(e)
            # Surround each element by double quotes to ...
            params = list(map(doubleQuote, c.split(' ')))
            # ... allow using it as a function parameter
            eval("Create(" + ', '.join(params) + ")")


def Copy():
    Log('Copy files')
    to_copy = dotfiles['toCopy']
    if len(to_copy) != 0:
        for c in to_copy:
            def doubleQuote(e): return '"{}"'.format(e)
            # Surround each element by double quotes to ...
            params = list(map(doubleQuote, c.split(' ')))
            # ... allow using it as a function parameter
            eval("Create(" + ', '.join(params) + ", link=False)")


def Main():
    answer = True
    while answer:

        print(c['redb'] + '''
######################
#
#       LINK
#
######################
        ''' + c['white'])

        print('- {}[*]{} Everything'.format(c['green'], c['white']))

        print('\n- {}[0]{} Go back'.format(c['green'], c['white']))
        print('- {}[q]{} quit'.format(c['green'], c['white']))

        inp = input(c['yellow'] + '\n> ' + c['white'])
        print()

        if inp == '*':
            for f in ['Link', 'Copy']:
                globals()[f]()
            print()
        elif inp == '0':
            os.system('python3 ' + main_scripts + 'do.py')
            answer = False
        else:
            print('See ya')
            answer = False

#########
# Proceed
#########

Main()
