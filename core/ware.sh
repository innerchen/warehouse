#!/usr/bin/env bash

if [ $# -lt 1 ]; then
    echo "usage: " bash $0 password [args]
    exit
fi

password=$1 && shift

if ! echo ${password} | env sudo -kS echo "password is right" >/dev/null 2>&1; then
    echo "incorrect password"
    exit
fi

has() {
    if [ $# -eq 1 ]; then
        hash $1 >/dev/null
        return $?
    fi
}

os() {
    if [ $(uname) = "Linux" ]; then
        dist=($(lsb_release -i))
        info=($(lsb_release -r))
        echo ${dist[-1]} ${info[-1]}
    fi
    if [ $(uname) = "Darwin" ]; then
        echo macOS
    fi
}

sudo() {
    echo ${password} | env sudo -S "$@"
}

ware() {
    if [[ $(os) == Ubuntu* ]]; then
        sudo apt-get "$@"
    fi
    if [ $(os) = "macOS" ]; then
        HOMEBREW_NO_AUTO_UPDATE=1 brew "$@"
    fi
}

path() {
    realpath $(dirname $0)/..
}

tmp() {
    ! [ -d $(path)/.tmp ] && mkdir $(path)/.tmp
    echo $(path)/.tmp
}

output() {
    echo "[warehouse]" "$@"
}

numcmp() {
    awk -v n1="$1" -v n2="$2" 'BEGIN {printf (n1<n2?-1:(n1==n2?0:1))}'
}

sed() {
    input="${@: -1}"
    if [ $# -eq 2 ] && [ -e ${input} ]; then
        env sed "$@" >${input}.tmp && mv ${input}.tmp ${input}
    else
        env sed "$@"
    fi
}

tee() {
    env tee "$@" >/dev/null
}
