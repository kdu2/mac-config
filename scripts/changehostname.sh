#!/bin/bash

# assumes pattern is name-01md (last 4 characters are [digit][digit][alpha][alpha])
mac=$(echo -n $(hostname) | tail -c 4)
name="pattern$mac"

scutil --set HostName $name # friendly name
scutil --set ComputerName $name # system name in settings
scutil --set LocalHostName $name # bonjour name
