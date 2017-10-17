#!/usr/bin/env bash

! [ -e ~/.warehouse ] && git clone https://github.com/innerchen/warehouse.git ~/.warehouse
python3 ~/.warehouse/ware.py ~/.warehouse/ware.json

echo Please compile YouCompleteMe manually.

