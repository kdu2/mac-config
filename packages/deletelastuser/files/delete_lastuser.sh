#!/bin/bash

lastuser=$(defaults read /Library/Preferences/com.apple.loginwindow lastUserName)

if [[ $lastuser != "admin" ]]; then
	rm -rf /Users/$lastuser
fi
