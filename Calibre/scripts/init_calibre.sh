#!/bin/bash

ln -s /var/log/calibre /home/calibre/log
calibredb list --library-path=/home/calibre/library
calibre-server --userdb /srv/calibre/users.sqlite \
               --manage-users -- add calibre calibre calibre
