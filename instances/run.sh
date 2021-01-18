#!/bin/sh
# dLux Start Manager Shell Script
# CADawg 2021

DIRX=$(dirname $(readlink -f $0))
cd $DIRX

for d in dlux*/ ; do
	v=${d%/}
	echo "Running ${d}"
	cd $d
	git pull
	pm2 start index.js --name $v
	cd ..
	pm2 save
done
