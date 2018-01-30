
import sys
import getpass
import subprocess


class Color(object):

    YELLOW = "\033[0;33m"
    RESET = "\033[0;0m"

    @staticmethod
    def print(color, string, end='\n'):
        sys.stdout.write(color)
        print(string, end=end)
        sys.stdout.write(Color.RESET)


def password():
    while True:
        pwd = getpass.getpass("[sudo] password for " + getpass.getuser() + ": ")
        status, output = subprocess.getstatusoutput("echo '%s' | sudo -kS true" % pwd)
        if status == 0:
            break
        print("Sorry, try again.")
    return pwd


def bash(argv):
    process = subprocess.Popen(['bash'] + argv, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    label = ' '
    for line in iter(process.stdout.readline, b''):
        if b'\r' in line:
            print("!!!!")
        print(' ' * len(label), end='\r')
        line = str(line, 'utf-8')
        if line.startswith('[warehouse]'):
            label = line[:-1]
        else:
            print(line, end='')
        Color.print(Color.YELLOW, label, end='\r')


def main():

    pwd = password()
    bash(['./component/ubuntu.sh', pwd])
    bash(['./component/zsh.sh', pwd])
    bash(['./component/vim.sh', pwd])


if __name__ == "__main__":
    main()
