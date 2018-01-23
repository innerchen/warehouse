#!/usr/bin/env bash

source $(dirname $0)/../core/ware.sh

ubuntu() {

    timedatectl set-local-rtc 1

    cp /etc/default/grub "$(tmp)"/grub
    cp /etc/grub.d/30_os-prober "$(tmp)"/30_os-prober
    sed 's/^GRUB_TIMEOUT=10/GRUB_TIMEOUT=0/' "$(tmp)"/grub
    sed 's/^quick_boot="1"/quick_boot="0"/' "$(tmp)"/30_os-prober
    sudo cp "$(tmp)"/grub /etc/default/grub
    sudo cp "$(tmp)"/30_os-prober /etc/grub.d/30_os-prober

    [[ -d ~/.fonts ]] && git clone https://github.com/innerchen/fonts ~/.fonts && cp ~/.fonts/.fonts.conf ~/

    ware install trash-cli

    ware install proxychains
    cp /etc/proxychains.conf "$(tmp)"/proxychains.conf
    sed "s/^socks4.*/socks5  127.0.0.1 1080/" "$(tmp)"/proxychains.conf
    sudo cp "$(tmp)"/proxychains.conf /etc/proxychains.conf

}

macOS() {

    echo 1

}

main() {

    ! [[ -d ~/.ssh ]] && mkdir ~/.ssh
    if has openssl; then
        echo ${password} | openssl aes-256-cbc -d -in "$(path)"/config/personal/ssh-key/id_rsa.enc -out ~/.ssh/id_rsa -pass stdin
        echo ${password} | openssl aes-256-cbc -d -in "$(path)"/config/personal/ssh-key/id_rsa.pub.enc -out ~/.ssh/id_rsa.pub -pass stdin
    fi

    ! [[ -d ~/.local ]] && mkdir ~/.local

    ! [[ -d ~/.ptpython ]] && mkdir ~/.ptpython
    ln -sf "$(path)"/config/personal/ptpython/config.py ~/.ptpython/

}

main
