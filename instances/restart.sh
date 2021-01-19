#!/bin/sh
# dLux Restart Manager Shell Script
# CADawg 2021

DIRX=$(dirname $(readlink -f $0))
cd $DIRX

for d in dlux*/ ; do
        v=${d%/}
        echo "Updating ${d}"
        cd $d
	update=`git pull`
	if [ "$update" != "Already up to date." ]
	then
		npm i # update packages
        	pm2 restart $v # restart node
	fi
        cd ..
done
