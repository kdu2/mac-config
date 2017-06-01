#!/bin/bash

# hide sleep and shutdown at login window
defaults write /Library/Preferences/com.apple.loginwindow SleepDisabled -bool True
defaults write /Library/Preferences/com.apple.loginwindow ShutDownDisabled -bool True
