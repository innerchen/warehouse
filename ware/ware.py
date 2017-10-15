
import os

from ware import coreutils
from ware.coreutils import command


home = os.path.expanduser("~")
path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os_type, os_version = coreutils.uname()

if os_type != "macOS" and os_type != "Ubuntu":
    print("not supported system: ", os_type)

if os_type == "macOS" and coreutils.which("brew") is None:
    print("command not found: brew")
    print("please install homebrew")
    exit(-1)

temp_path = coreutils.mkdir(os.path.join(coreutils.tempfile(), "warehouse"))
log = coreutils.touch(os.path.join(temp_path, "ware.log"))
password = coreutils.passwd()


def install(program):
    if os_type == "Ubuntu":
        command("apt install %s -y" % program, True)
    if os_type == "macOS":
        command("brew install %s" % program)


def update():
    if os_type == "Ubuntu":
        command("apt update -y", True)
    if os_type == "macOS":
        command("brew update")


def upgrade(program=""):
    if os_type == "Ubuntu":
        command("apt upgrade %s -y" % program, True)
    if os_type == "macOS":
        command("brew upgrade %s" % program)
