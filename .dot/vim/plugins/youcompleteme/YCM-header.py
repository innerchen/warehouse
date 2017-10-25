#!/usr/bin/env python3

import os
import json
import subprocess


def header_source(command):

    directory = command["directory"]
    arguments = command["arguments"]

    if "-o" not in arguments or "-c" not in arguments:
        return []

    arguments = arguments[:arguments.index("-o")] + [arguments[-1]]
    arguments[arguments.index("-c")] = "-MM"

    s, o = subprocess.getstatusoutput(" ".join(arguments))
    if s != 0:
        return []

    o = o.replace("\\", "").split()
    if len(o) <= 2:
        return []

    headers = [os.path.join(directory, h) for h in o[2:]]
    source = os.path.join(directory, o[1])

    return [(h, source) for h in headers]


def main():

    compile_commands = "compile_commands.json"
    if not os.path.exists(compile_commands):
        return
    with open(compile_commands) as f:
        commands = json.load(f)

    headers_json = {}
    for command in commands:
        for h, s in header_source(command):
            if h in headers_json:
                continue
            headers_json[h] = s
    with open("header.json", 'w') as out:
        json.dump(headers_json, out, indent=4, separators=(',', ': '))


if __name__ == "__main__":
    main()

