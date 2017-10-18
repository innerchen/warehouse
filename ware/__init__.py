
from ware.func import *
from ware.ware import *

home = os.path.expanduser("~")
path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

temp_path = mkdir(os.path.join(tempfile(), "warehouse"))
log = func.touch(os.path.join(temp_path, "ware.log"))

func.echo("", log)
os_type, os_version = func.uname()


if os_type != "macOS" and os_type != "Ubuntu":
    print("not supported system: ", os_type)
    exit(-1)

if os_type == "macOS" and func.which("brew") is None:
    print("command not found: brew")
    print("please install homebrew first")
    exit(-1)

password = func.passwd()

