#!/usr/bin/env python3

import os
import sys
import getpass
import argparse
import subprocess


class Color(object):

    YELLOW = "\033[0;33m"
    RESET = "\033[0;0m"

    @staticmethod
    def print(color, string, end='\n'):
        sys.stdout.write(color)
        sys.stdout.write(string + end)
        sys.stdout.write(Color.RESET)
        sys.stdout.flush()


def password():
    while True:
        pwd = getpass.getpass("[sudo] password for " + getpass.getuser() + ": ")
        status, output = subprocess.getstatusoutput("echo '%s' | sudo -kS true" % pwd)
        if status == 0:
            break
        print("Sorry, try again.")
    return pwd


def bash(argv):
    process = subprocess.Popen(['bash'] + argv, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    label = ' '
    for line in iter(process.stdout.readline, b''):
        line = str(line, 'utf-8')
        if "[warehouse]" in line:
            label = line[line.index("[warehouse]"): -1]
        else:
            print('\r' + ' ' * len(label), end='\r')
            print(line, end='')
            Color.print(Color.YELLOW, label, end='')
    print('\r' + ' ' * len(label), end='\r')


def main():

    parser = argparse.ArgumentParser()
    parser.add_argument("--all", help="install all components", action="store_true")
    args = parser.parse_args()

    pwd = password()
    component = {"ubuntu": True, "zsh": True, "vim": True, "ycm": False}

    if args.all:
        component["ycm"] = True
    else:
        if input("set up ubuntu [Y/n]") in ['N' or 'n']:
            component["ubuntu"] = False
        if input("set up zsh [Y/n]") in ['N' or 'n']:
            component["zsh"] = False
        if input("set up vim [Y/n]") in ['N' or 'n']:
            component["vim"] = False
        if input("build YouCompleteMe [y/N]") in ['Y' or 'y']:
            component["ycm"] = True

    path = os.path.dirname(os.path.abspath(__file__))
    if component["ubuntu"]:
        bash([path + '/component/ubuntu.sh', pwd])
    if component["zsh"]:
        bash([path + '/component/zsh.sh', pwd])
    if component["vim"]:
        if component["ycm"]:
            bash([path + '/component/vim.sh', pwd, "--with-ycm"])
        else:
            bash([path + '/component/vim.sh', pwd])


if __name__ == "__main__":
    main()
