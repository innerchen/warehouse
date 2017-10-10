
import os
import subprocess

from ware import coreutils

home = os.path.expanduser("~")
path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


temp_path = coreutils.mkdir(os.path.join(coreutils.tempfile(), "warehouse"))
log = coreutils.touch(os.path.join(temp_path, "ware.log"))
password = coreutils.passwd()


def command(cmd, sudo=False):
    if sudo:
        cmd = "echo '%s' | sudo -kS %s" % (password, cmd)
    status, output = subprocess.getstatusoutput(cmd)
    return status, output
