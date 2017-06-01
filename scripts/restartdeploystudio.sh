#!/bin/bash

launchctl unload /Library/LaunchDaemons/com.deploystudio.server.plist
launchctl load /Library/LaunchDaemons/com.deploystudio.server.plist
