
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


def setup(conf=None):

    if vim_version() < "8.0":
        print("please install vim 8.0")
        return

    vundle_url = "https://github.com/VundleVim/Vundle.vim.git"
    vundle_path = os.path.join(ware.home, ".vim", "bundle", "Vundle.vim")
    if not os.path.exists(vundle_path):
        ware.command("git clone %s %s" % (vundle_url, vundle_path), output=True)

    ware.ln(os.path.join(vim_dot_path, ".vimrc"), ware.home)
    ware.ln(os.path.join(vim_dot_path, ".vimrc.basic"), ware.home)
    ware.ln(os.path.join(vim_dot_path, ".vimrc.plugins"), ware.home)

    ware.mkdir(os.path.join(ware.home, ".vim"))
    ware.mkdir(os.path.join(ware.home, ".vim", "colors"))
    ware.ln(os.path.join(vim_dot_path, "colors", "monokai.vim"), os.path.join(ware.home, ".vim", "colors"))

    ware.command("vim +PluginInstall +qall")
    ware.ln(os.path.join(vim_dot_path, "plugins", "airline", "powerline.vim"),
            os.path.join(ware.home, ".vim", "bundle", "vim-airline", "autoload", "airline", "themes"))
    ware.ln(os.path.join(vim_dot_path, "plugins", "youcompleteme", ".ycm_extra_conf.py"), ware.home)


