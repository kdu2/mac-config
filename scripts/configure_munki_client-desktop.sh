#!/bin/bash

# munki client configuration script

# set repo url and client id
MUNKI_REPO="https://macsrv.gwc.cccd.edu/munki_repo"

defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL $MUNKI_REPO

# install munkireport client
/bin/bash -c "$(curl -s https://macsrv.gwc.cccd.edu/munkireport/index.php?/install)"

# create munki bootstrap file
touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup
