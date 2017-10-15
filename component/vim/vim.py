
import re
import os

import ware

vim_path = os.path.dirname(os.path.abspath(__file__))
vim_dot_path = os.path.join(ware.path, ".dot", "vim")
vim_temp_path = ware.mkdir(os.path.join(ware.temp_path, "vim"))


def vim_version():
    vim = ware.which("vim")
    if vim is None:
        return None
    _, version = ware.command(vim + " --version")
    return re.findall("VIM.*(\d\.\d)", version)[0]


def setup():
    print(ware.os_type, ware.os_version)

    if vim_version() < "8.0":
        pass

    ware.command("ln -sf %s %s" % (os.path.join(vim_dot_path, ".vimrc"), ware.home))
    ware.command("ln -sf %s %s" % (os.path.join(vim_dot_path, ".vimrc.basic"), ware.home))
    ware.command("ln -sf %s %s" % (os.path.join(vim_dot_path, ".vimrc.plugins"), ware.home))

    ware.mkdir(os.path.join(ware.home, ".vim"))
    ware.mkdir(os.path.join(ware.home, ".vim", "colors"))




