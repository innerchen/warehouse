
import os

from ware import func
from ware.func import command
from lib.termcolor import colored as _colored

home = os.path.expanduser("~")
path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os_type, os_version = func.uname()


def colored(text, color=None, on_color=None, attrs=None):
    _colored(text, color, on_color, attrs)

if os_type != "macOS" and os_type != "Ubuntu":
    print("not supported system: ", os_type)

if os_type == "macOS" and func.which("brew") is None:
    print("command not found: brew")
    print("please install homebrew")
    exit(-1)


temp_path = func.mkdir(os.path.join(func.tempfile(), "warehouse"))
log = func.touch(os.path.join(temp_path, "ware.log"))
password = func.passwd()


def install(program):
    print(colored("==>", color="blue"), colored("ware install", attrs="bold"), program)
    if os_type == "Ubuntu":
        command("apt install %s -y" % program, sudo=True)
    if os_type == "macOS":
        command("HOMEBREW_NO_AUTO_UPDATE=1 brew install %s" % program, output=True)


def update():
    print(colored("==>", color="blue"), colored("ware update", attrs="bold"))
    if os_type == "Ubuntu":
        command("apt update", sudo=True)
    if os_type == "macOS":
        command("brew update", output=True)


def upgrade(program=""):
    print(colored("==>", color="blue"), colored("ware upgrade", attrs="bold"), program)
    if os_type == "Ubuntu":
        command("apt upgrade %s -y" % program, sudo=True)
    if os_type == "macOS":
        command("brew upgrade %s" % program, output=True)
