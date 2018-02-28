#!/bin/bash

# munki client configuration script

# set repo url and client id
MUNKI_REPO="https://server/munki_repo"

defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL $MUNKI_REPO

# install munkireport client
/bin/bash -c "$(curl -s https://server/munkireport/index.php?/install)"

# create munki bootstrap file
touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup
