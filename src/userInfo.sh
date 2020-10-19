#!/bin/bash
if [ -z $1 ]; then
    echo "Usage: userInfo.sh [USERNAME]"
    exit 1
fi

user=$1

function read_home {
    echo "Reading $hdir"
    echo $hdir currently takes up $(du -hs $hdir | grep -oE "^[0-9\.A-Z]*") on disk
    echo "Listing first 10 files"
    ls -1 $hdir | head
}


if [ $user = "root" ]; then
    if [ $UID != 0 ]; then
        echo "Error: user 'root' exists but you cannot access their home directory"
        exit 1
    else
        hdir="/root"
        read_home
    fi
elif [ -d "/home/$user" ]; then
    hdir="/home/$user"
    read_home
elif [ -n "$(cat /etc/passwd | grep -E ^$user)" ]; then
    echo "Error: User exists, but no home directory was found."
    exit 1
else
    echo "Error: User not found"
    exit 1
fi
