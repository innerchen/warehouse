#!/usr/bin/env bash

if ! hash git 2>/dev/null; then
    echo "Please install git first!"
    exit
fi

! [ -e ~/.warehouse ] && git clone https://github.com/innerchen/warehouse.git ~/.warehouse
python3 ~/.warehouse/ware.py "$@"
