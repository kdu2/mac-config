#!/bin/bash

if [ ! -d /Volumes/share ]; then
	osascript -e "mount volume \"smb://server/share\""
	tempmount="yes"
fi

announcementfile="/Volumes/share/folder/file"

if [ -f $announcementfile ]; then
    open $announcementfile
fi

sleep 10

if [ $tempmount == "yes" ]; then
	umount /Volumes/share
fi

exit
