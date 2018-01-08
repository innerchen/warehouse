#!/usr/bin/env bash

source $(dirname $0)/../core/ware.sh

set_source() {

    source_url="https://mirrors.tuna.tsinghua.edu.cn/ubuntu/"
    source_end="main restricted universe multiverse"

    [ "$(os)" = "Ubuntu 16.04" ] && code="xenial"

    touch $(tmp)/sources.list
    echo deb ${source_url} ${code} ${source_end}            | tee -a $(tmp)/sources.list
    echo deb ${source_url} ${code}-updates ${source_end}    | tee -a $(tmp)/sources.list
    echo deb ${source_url} ${code}-security ${source_end}   | tee -a $(tmp)/sources.list
    echo deb ${source_url} ${code}-backports ${source_end}  | tee -a $(tmp)/sources.list

    sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo mv $(tmp)/sources.list /etc/apt/sources.list

    output "apt-get update"  && sudo apt-get update
    output "apt-get upgrade" && sudo apt-get upgrade -y

}

main() {

    if [ "$(os)" != "Ubuntu 16.04" ]; then
        echo $(os) is not supported!
        return -1
    fi

    set_source
    bash $(path)/.dot/ubuntu/setup-theme.sh

}

main
