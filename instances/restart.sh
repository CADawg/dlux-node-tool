#!/bin/sh
# dLux Restart Manager Shell Script
# CADawg 2021

DIRX=$(dirname $(readlink -f $0))
cd $DIRX

for d in dlux*/ ; do
        v=${d%/}
        echo "Updating ${d}"
        cd $d
        git pull # update from git
	npm i # update packages
        pm2 restart $v # restart node
        cd ..
done
