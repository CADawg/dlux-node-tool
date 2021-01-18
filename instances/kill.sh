#!/bin/sh
# dLux End Manager Shell Script
# CADawg 2021

DIRX=$(dirname $(readlink -f $0))
cd $DIRX

for d in dlux*/ ; do
	v=${d%/}
	echo "Cleaning up ${v}"
	pm2 delete $v
	pm2 save
done
