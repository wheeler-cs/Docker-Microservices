#!/bin/bash

wget https://download.calibre-ebook.com/linux-installer.sh -O ./linux-installer.sh
chmod 700 ./linux-installer.sh
export CALIBRE_CONFIG_DIRECTORY="/etc/calibre" && ./linux-installer.sh
