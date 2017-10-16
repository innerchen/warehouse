
import sys
import json

import component


def main():

    if len(sys.argv) > 2:
        print("usage: python3 %s [json]" % sys.argv[0])

    if len(sys.argv) == 2:
        with open(sys.argv[1]) as f:
            conf_json = json.load(f)
    else:
        conf_json = {k: True for k in dir(component) if not k.startswith("_")}

    components = ["ubuntu", "zsh", "vim"]

    conf = []
    for comp in components:
        if not hasattr(component, comp) or comp not in conf_json:
            continue
        if conf_json is False:
            continue
        c = None if conf_json[comp] is True else conf_json[comp]
        conf.append((getattr(component, comp), c))

    for comp, c in conf:
        comp.setup(c)

