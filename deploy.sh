#!/bin/sh
rsync -rlpdoDz --force --delete --progress -e "ssh -p22" public/ jongbin@jongbin.com:/home/jongbin/www/blog
