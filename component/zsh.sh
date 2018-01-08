#!/usr/bin/env bash

source $(dirname $0)/../core/ware.sh

oh_my_zsh() {

    if ! [ -d ~/.oh-my-zsh ]; then
        curl -O "https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
        mv install.sh $(tmp)/oh_my_zsh.sh
        sed "s/chsh -s/echo/" $(tmp)/oh_my_zsh.sh
        sed "s/env zsh//" $(tmp)/oh_my_zsh.sh

        bash $(tmp)/oh_my_zsh.sh
        sudo chsh -s $(grep /zsh$ /etc/shells | tail -1) $(whoami)
    fi

    sed "s/^plugins=.*/plugins=()/" ~/.zshrc
    sed "s/^ZSH_THEME=.*/ZSH_THEME=\"mine\"/" ~/.zshrc
    if ! cat ~/.zshrc | grep "User configuration" >/dev/null; then
        echo "#User configuration" | tee -a ~/.zshrc >/dev/null
        echo "source \$HOME/.zshrc_user" | tee -a ~/.zshrc >/dev/null
    fi

    ln -sf $(path)/.dot/zsh/theme/mine.zsh-theme ~/.oh-my-zsh/themes/
    ln -sf $(path)/.dot/zsh/.zshrc_user ~/
    ln -sf $(path)/.dot/zsh/.dircolors ~/
    ! [ -e ~/.zshrc_personal ] && touch ~/.zshrc_personal

}


main() {
    if ! has zsh; then
        sudo apt-get install zsh
    fi
    if ! has curl; then
        sudo apt-get install curl
    fi
    oh_my_zsh
}

main
