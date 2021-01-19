#!/bin/sh
# dLux Start Manager Shell Script
# Copyright CADawg 2021

DIRX=$(dirname $(readlink -f $0))

if test -f "$DIRX/install/DONOTDELETE"; then
	echo "Welcome Back!"
else
	echo "Hello there. Let me get this setup for you!"

	# Crontab setup for restart script
	crontab -l > mycron
	echo "*/5 * * * * $DIRX/instances/restart.sh  > /dev/null 2>&1" >> mycron
	crontab mycron
	rm mycron

	touch "$DIRX/install/DONOTDELETE"

	# Install pm2
	npm i -g pm2
fi

echo "Enter Your DLUX NODE's Hive Username"
read username

echo "Enter The Active Key for the account"
read activekey

echo "Enter The Memo Key for the account"
read memokey

DLUXFOLDER="$DIRX/instances/dlux-$username"

PORTX=$(cat "$DIRX/install/NEXTPORT")

echo $(($PORTX + 1)) > "$DIRX/install/NEXTPORT"

git clone https://github.com/dluxio/dlux_open_token.git $DLUXFOLDER

cd $DLUXFOLDER

touch "$DLUXFOLDER/.env"

echo "account=$username" >> "$DLUXFOLDER/.env"
echo "active=$activekey" >> "$DLUXFOLDER/.env"
echo "memo=$memokey" >> "$DLUXFOLDER/.env"
echo "PORT=$PORTX" >> "$DLUXFOLDER/.env"

npm i

pm2 start index.js --name "dlux-$username"

pm2 save

echo "Done! Your new node is setup and will be automatically updated every hour."
