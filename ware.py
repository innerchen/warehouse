
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
        Color.print(Color.RESET, ' ' * len(label), end='\r')
        line = str(line, 'utf-8')
        if line.startswith('[warehouse]'):
            label = line[:-1]
        else:
            print(line, end='')
        Color.print(Color.YELLOW, label, end='\r')


def main():

    pwd = password()

    ubuntu = input("set up ubuntu [Y/n]")
    zsh = input("set up zsh [Y/n]")
    vim = input("set up vim [Y/n]")
    ycm = input("build YouCompleteMe [y/N]")

    if ubuntu != 'N' and ubuntu != 'n':
        bash(['./component/ubuntu.sh', pwd])
    if zsh != 'N' and zsh != 'n':
        bash(['./component/zsh.sh', pwd])
    if vim != 'N' and vim != 'n':
        bash(['./component/vim.sh', pwd])
    if ycm == 'Y' or ycm == 'y':
        pass


if __name__ == "__main__":
    main()
