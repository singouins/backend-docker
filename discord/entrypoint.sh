#!/bin/sh

echo "`date +"%F %X"` Loading Python scripts ..."
mkdir  /code
cd     /code
wget   https://github.com/lordslair/sep-backend/archive/master.zip -O /tmp/sep.zip &&
unzip  /tmp/sep.zip -d /tmp/ &&
cp -a  /tmp/sep-backend-master/discord/* /code/ &&
rm -rf /tmp/sep-backend-master &&
rm -rf /tmp/sep.zip
echo "`date +"%F %X"` Loading done ..."

exec python3 /code/discord-bot.py
