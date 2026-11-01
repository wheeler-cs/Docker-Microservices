#!/bin/bash

CALIBRE_DIRS="/srv/calibre /var/log/calibre /etc/calibre /home/calibre/library"

mkdir $CALIBRE_DIRS
chown calibre:calibre $CALIBRE_DIRS
