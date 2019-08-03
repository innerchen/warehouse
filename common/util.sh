#!/usr/bin/env bash

has() {
    if [[ $# -eq 1 ]]; then
        hash $1 >/dev/null 2>&1
        return $?
    fi
}

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

path() {
    realpath $(dirname "$0")/
}

tmp() {
    ! [[ -d $(path)/.tmp ]] && mkdir "$(path)"/.tmp
    echo $(path)/.tmp
}

sed() {
    input="${@: -1}"
    if [[ $# -eq 2 ]] && [[ -e ${input} ]]; then
        env sed "$@" >"${input}".tmp && mv "${input}".tmp "${input}"
    else
        env sed "$@"
    fi
}

tee() {
    env tee "$@" >/dev/null
}
