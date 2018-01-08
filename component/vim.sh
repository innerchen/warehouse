#!/usr/bin/env bash

source $(dirname $0)/../core/ware.sh

vim_version() {
    if  hash vim ; then
        ver=($(vim --version | grep "VIM - Vi IMproved"))
        echo ${ver[4]}
    else
        echo 0.0
    fi
}

vim_install() {
    if ! ls /etc/apt/sources.list.d/ | grep jonathonf-ubuntu-vim > /dev/null; then
        sudo $1 add-apt-repository ppa:jonathonf/vim -y
    fi
    sudo $1 apt-get update
    sudo $1 apt-get install vim-nox
}

vim_plugin() {

    ! [ -d ~/.vim ] && mkdir ~/.vim
    ! [ -d ~/.vim/colors ] && mkdir ~/.vim/colors
    ! [ -d ~/.vim/bundle ] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle

    ln -sf $(path)/.dot/vim/.vimrc ~/
    ln -sf $(path)/.dot/vim/.vimrc.basic ~/
    ln -sf $(path)/.dot/vim/.vimrc.plugins ~/
    ln -sf $(path)/.dot/vim/colors/monokai.vim ~/.vim/colors/

    vim +PluginInstall +qall
    ln -sf $(path)/.dot/vim/plugins/airline/powerline.vim ~/.vim/bundle/vim-airline/autoload/airline/themes/
    ln -sf $(path)/plugins/youcompleteme/.ycm_extra_conf.py ~/

}


main() {

    ver=$(vim_version)

    if [ $(numcmp ${ver} 8.0) -lt 0 ]; then
        vim_install $1
    fi
    vim_plugin

}

main $1