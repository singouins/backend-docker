#!/bin/sh

echo "`date +"%F %X"` Loading Python scripts ..."
mkdir  /code
cd     /code
wget   https://github.com/lordslair/sep-backend/archive/master.zip -O /tmp/sep.zip &&
unzip  /tmp/sep.zip -d /tmp/ &&
cp -a  /tmp/sep-backend-master/api/* /code/ &&
rm -rf /tmp/sep-backend-master &&
rm -rf /tmp/sep.zip
echo "`date +"%F %X"` Loading done ..."

exec flask run --host=$FLASK_HOST \
               --port=$FLASK_PORT \
               $FLASK_DEBUG \
               $FLASK_THREAD
