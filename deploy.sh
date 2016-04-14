#!/bin/sh

rsync -avr --delete-after --delete-excluded _site/ jongbin@jongbin.com:/home/jongbin/www/blog
