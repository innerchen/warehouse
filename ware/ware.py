
import ware
from lib.termcolor import colored as _colored


def colored(text, color=None, on_color=None, attrs=None):
    if isinstance(attrs, str):
        attrs = [attrs]
    return _colored(text, color, on_color, attrs)


def install(program):
    print(colored("==>", color="blue"), colored("ware install", attrs="bold"), program)
    if ware.os_type == "Ubuntu":
        ware.command("apt install %s -y" % program, sudo=True)
    if ware.os_type == "macOS":
        ware.command("HOMEBREW_NO_AUTO_UPDATE=1 brew install %s" % program, output=True)


def update():
    print(colored("==>", color="blue"), colored("ware update", attrs="bold"))
    if ware.os_type == "Ubuntu":
        ware.command("apt update", sudo=True)
    if ware.os_type == "macOS":
        ware.command("brew update", output=True)


def upgrade(program=""):
    print(colored("==>", color="blue"), colored("ware upgrade", attrs="bold"), program)
    if ware.os_type == "Ubuntu":
        ware.command("apt upgrade %s -y" % program, sudo=True)
    if ware.os_type == "macOS":
        ware.command("brew upgrade %s" % program, output=True)
