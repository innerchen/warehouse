
import os

import ware

vim_path = os.path.dirname(os.path.abspath(__file__))
vim_dot_path = os.path.join(ware.path, ".dot", "vim")
vim_temp_path = ware.mkdir(os.path.join(ware.temp_path, "vim"))


def setup():
    pass
