
import os
import urllib.request

import ware

zsh_path = os.path.dirname(os.path.abspath(__file__))
zsh_dot_path = os.path.join(ware.path, ".dot", "zsh")
zsh_temp_path = ware.mkdir(os.path.join(ware.temp_path, "zsh"))


def setup(conf=None):

    zsh_url = "https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
    zsh_install = os.path.join(zsh_temp_path, "zsh_install.sh")
    urllib.request.urlretrieve(zsh_url, zsh_install)

    ware.sed(zsh_install, "(chsh -s.*)", r"sudo -kS \1 $(whoami)")
    ware.command("echo '%s' | bash %s" % (ware.password, zsh_install))

    zsh_rc = os.path.join(ware.home, ".zshrc")
    ware.sed(zsh_rc, "^(plugins=\().*(\))", r"\1\2")
    ware.sed(zsh_rc, "^(ZSH_THEME=\").*(\")", r"\1mine\2")

    ware.ln(os.path.join(zsh_dot_path, "theme", "mine.zsh-theme"), os.path.join(ware.home, ".oh-my-zsh", "themes"))
    ware.ln(os.path.join(zsh_dot_path, ".zshrc_user"), ware.home)
    ware.ln(os.path.join(zsh_dot_path, ".dircolors"), ware.home)

    ware.touch(os.path.join(ware.home, ".zshrc_personal"))

    if not ware.grep(os.path.join(ware.home, ".zshrc"), r"source \$HOME/.zshrc_user"):
        ware.echo(["", "# User configuration", "source $HOME/.zshrc_user"], zsh_rc, mode='a')
