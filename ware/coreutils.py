
import os
import re
import time
import tempfile as _tempfile
import getpass
import shutil
import subprocess


def cat(files, stdout=None, mode='w'):
    lines = []
    for file in files:
        with open(file, 'r') as f:
            lines.extend(i for i in f)
    if stdout is None:
        return lines
    else:
        with open(stdout, mode) as f:
            f.writelines(i for i in lines)


def date():
    localtime = time.localtime()
    return time.strftime("%Y-%m-%d %H:%M:%S", localtime)


def echo(strings, stdout=None, mode='w'):
    if stdout is None:
        return strings
    else:
        with open(stdout, mode) as f:
            f.writelines(s + "\n" for s in strings)


def grep(file, pattern):
    with open(file, 'r') as f:
        lines = [i for i in f]
    for i in lines:
        if re.search(pattern, i):
            return True
    return False


def mkdir(path):
    if not os.path.exists(path):
        os.mkdir(path)
    return path


def passwd():
    while True:
        pwd = getpass.getpass("[sudo] password for " + getpass.getuser() + ": ")
        status, output = subprocess.getstatusoutput("echo '%s' | sudo -kS true" % pwd)
        if status == 0:
            break
        print("Sorry, try again.")
    return pwd


def sed(file, pattern, replace):
    with open(file, 'r') as f:
        lines = [i for i in f]
    lines = [re.sub(pattern, replace, i) for i in lines]
    with open(file, 'w') as out:
        out.writelines(lines)


def tempfile():
    if os.path.exists("/tmp"):
        path = "/tmp"
    else:
        path = _tempfile.gettempdir()
    return path


def touch(file):
    if not os.path.exists(file):
        f = open(file, 'w')
        f.close()
    return file


def which(program):
    return shutil.which(program)
