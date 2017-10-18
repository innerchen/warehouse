
import os

import ware

ubuntu_path = os.path.dirname(os.path.abspath(__file__))
ubuntu_dot_path = os.path.join(ware.path, ".dot", "ubuntu")
ubuntu_temp_path = ware.mkdir(os.path.join(ware.temp_path, "ubuntu"))


def set_source(code):

    print(ware.colored("==>", color="green"), ware.colored("setting sources list", attrs="bold"))

    source_url = "https://mirrors.ustc.edu.cn/ubuntu/"
    source_end = "main restricted universe multiverse"

    sources_list = ware.touch(os.path.join(ware.temp_path, "ubuntu", "sources.list"))
    ware.echo("deb %s %s %s" % (source_url, code, source_end), sources_list, mode='w')
    ware.echo("deb %s %s-updates %s" % (source_url, code, source_end), sources_list, mode='a')
    ware.echo("deb %s %s-backports %s" % (source_url, code, source_end), sources_list, mode='a')
    ware.echo("deb %s %s-security %s" % (source_url, code, source_end), sources_list, mode='a')

    ware.command("cp %s %s" % (os.path.join("/etc", "apt", "sources.list"),
                               os.path.join("/etc", "apt", "sources.list.bak")), sudo=True)
    ware.command("cp %s %s" % (os.path.join(ubuntu_temp_path, "sources.list"),
                               os.path.join("/etc", "apt", "sources.list")), sudo=True)


def install_vim():

    sources_list_d = os.path.join("/etc", "apt", "sources.list.d")
    if os.path.exists(sources_list_d):
        sources_list = os.listdir(sources_list_d)
        for source in sources_list:
            if "vim" in source:
                return

    vim_source = "ppa:jonathonf/vim"
    ware.command("add-apt-repository %s -y" % vim_source, sudo=True)
    ware.update()
    ware.install("vim-nox")


def setup(conf=None):

    os_code = {"16.04": "xenial", "14.04": "trusty"}
    if ware.os_type != "Ubuntu" and ware.os_version not in os_code:
        return

    print(ware.colored("Ubuntu", attrs="bold"))

    ware.command("bash %s" % os.path.join(ubuntu_dot_path, "setup-theme.sh"))

    set_source(os_code[ware.os_version])
    ware.update()
    ware.upgrade()

    s, o = ware.command("dpkg -l python-dev")
    if s != 0:
        ware.install("python-dev")

    s, o = ware.command("dpkg -l python3-dev")
    if s != 0:
        ware.install("python3-dev")

    programs = ["ack-grep", "cmake", "curl", "git", "zsh"]
    for program in programs:
        if ware.which(program) is not None:
            continue
        ware.install(program)

    if conf is None or ("trash" in conf and conf["trash"]):
        if ware.which("trash") is None:
            ware.install("trash-cli")

    install_vim()

    print("")

