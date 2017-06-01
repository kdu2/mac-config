#!/bin/bash

# Loop through users with a home folder in /Users
# Exclude any accounts you don't want removed (e.g. local admin and current user if policy runs while someone is logged in)

for username in `ls /Users | grep -v 'admin\|Shared'`
do
    if [[ $username == `ls -l /dev/console | awk '{print $3}'` ]]; then
        echo "Skipping user: $username (current user)"
    else
        echo "Removing user: $username"

   	    # Optional, removes the account
       	#dscl . delete /Users/$username

        # Removes the user directory
   	    rm -rf /Users/$username
    fi
done
