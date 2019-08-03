#!/usr/bin/env bash

source $(dirname $0)/../../common/util.sh

zsh_config() {

    if ! [[ -d ~/.oh-my-zsh ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi

    sed "s/^ZSH_THEME=.*/ZSH_THEME=\"mine\"/" ~/.zshrc
    if ! cat ~/.zshrc | grep "source \$HOME/.zshrc_user" >/dev/null; then
        echo "#User configuration" | tee -a ~/.zshrc
        echo "source \$HOME/.zshrc_user" | tee -a ~/.zshrc
    fi

    cp "$(path)"/dot/theme/mine.zsh-theme ~/.oh-my-zsh/themes/
    cp "$(path)"/dot/zshrc_user ~/.zshrc_user
    cp "$(path)"/dot/dircolors ~/.dircolors
    ! [[ -e ~/.zshrc_personal ]] && touch ~/.zshrc_personal

}

main() {

    zsh_config

}

main
