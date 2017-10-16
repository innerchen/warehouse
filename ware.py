
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
        conf_json = {k: {} for k in dir(component) if not k.startswith("_")}

    conf = {}
    for k, v in conf_json.items():
        if not hasattr(component, k):
            continue
        if len(v) == 0:
            v = None
        conf[getattr(component, k)] = v

    for comp, c in conf.items():
        comp.setup(c)

