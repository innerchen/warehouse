
import sys
import subprocess


class Color(object):

    YELLOW = "\033[0;33m"
    RESET  = "\033[0;0m"

    @staticmethod
    def print(color, string, end='\n'):
        sys.stdout.write(color)
        print(string, end=end)
        sys.stdout.write(Color.RESET)


def bash(argv):
    process = subprocess.Popen(['bash'] + argv, stdout=subprocess.PIPE)
    label = ' '
    for line in iter(process.stdout.readline, b''):
        print(' ' * len(label), end='\r')
        line = str(line, 'utf-8')
        if line.startswith('[warehouse]'):
            label = line[:-1]
        else:
            print(line, end='')
        Color.print(Color.YELLOW, label, end='\r')


def main():

    bash(['./component/ubuntu.sh', 'chen123123'])

    """
    if len(sys.argv) > 2:
        print("usage: python3 %s [json]" % sys.argv[0])

    if len(sys.argv) == 2:
        with open(sys.argv[1]) as f:
            conf_json = json.load(f)
    else:
        conf_json = {k: true for k in dir(component) if not k.startswith("_")}

    components = ["ubuntu", "zsh", "vim"]

    conf = []
    for comp in components:
        if not hasattr(component, comp) or comp not in conf_json:
            continue
        if conf_json is false:
            continue
        c = none if conf_json[comp] is true else conf_json[comp]
        conf.append((getattr(component, comp), c))

    for comp, c in conf:
        comp.setup(c)
    """


if __name__ == "__main__":
    main()
