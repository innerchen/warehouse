#!/usr/bin/env bash

source $(dirname $0)/../core/ware.sh

vim_version() {
    if  has vim ; then
        ver=($(vim --version | grep "VIM - Vi IMproved"))
        echo ${ver[4]}
    else
        echo 0.0
    fi
}

vim_install() {

    if [[ $(os) == Ubuntu* ]]; then
        if ! ls /etc/apt/sources.list.d/ | grep jonathonf-ubuntu-vim > /dev/null; then
            sudo add-apt-repository ppa:jonathonf/vim -y
        fi
    fi
    ware update
    [[ $(os) == Ubuntu* ]] && ware install vim-nox
    [[ $(os) == "macOS" ]] && ware install vim --with-python3

}

vim_config() {

    ! [[ -d ~/.vim ]] && mkdir ~/.vim
    ! [[ -d ~/.vim/colors ]] && mkdir ~/.vim/colors
    ! [[ -d ~/.vim/bundle ]] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    ln -sf "$(path)"/config/vim/.vimrc ~/
    ln -sf "$(path)"/config/vim/.vimrc.basic ~/
    ln -sf "$(path)"/config/vim/.vimrc.plugins ~/
    ln -sf "$(path)"/config/vim/colors/monokai.vim ~/.vim/colors/

    for plugin in $(cat ~/.vimrc | grep "Plugin '" | sed "s/^Plugin//" | tr -d "'"); do
        dir=($(echo ${plugin} | tr '/' ' '))
        if ! [[ -d ~/.vim/bundle/${dir[1]} ]]; then
            git clone https://github.com/${plugin} --recursive ~/.vim/bundle/${dir[1]}
        fi
    done
    vim +PluginInstall +qall >/dev/null 2>&1

    ln -sf "$(path)"/config/vim/plugins/airline/powerline.vim ~/.vim/bundle/vim-airline/autoload/airline/themes/
    ln -sf "$(path)"/config/vim/plugins/youcompleteme/.ycm_extra_conf.py ~/
}

build_ycm() {

    if [[ -e ~/.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so ]]; then
        echo "build ycm"
    fi

}

main() {

    ver=$(vim_version)

    if [[ $(numcmp ${ver} 8.0) -lt 0 ]]; then
        vim_install
    fi
    vim_config
    if [[ $1 == "--with-ycm" ]]; then
        build_ycm
    fi
}

main "$@"