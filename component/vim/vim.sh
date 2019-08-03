#!/usr/bin/env bash

source $(dirname $0)/../../common/util.sh

vim_config() {

    ! [[ -d ~/.vim ]] && mkdir ~/.vim
    ! [[ -d ~/.vim/colors ]] && mkdir ~/.vim/colors
    ! [[ -e ~/.vim/autoload/plug.vim ]] && curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    cp "$(path)"/dot/vimrc ~/.vimrc
    cp "$(path)"/dot/vimrc.basic ~/.vimrc.basic
    cp "$(path)"/dot/vimrc.advance ~/.vimrc.advance
    cp "$(path)"/dot/colors/monokai.vim ~/.vim/colors/monokai.vim

   vim +PlugInstall +qall

    cp "$(path)"/dot/plug/airline/powerline.vim ~/.vim/plugged/vim-airline/autoload/airline/themes/
    cp "$(path)"/dot/plug/youcompleteme/.ycm_extra_conf.py ~/
}

main() {

    vim_config

}

main
