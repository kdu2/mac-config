#!/bin/sh

# sync time
systemsetup -setnetworktimeserver time.apple.com

# config
computer=$(scutil --get ComputerName)
domain="DOMAIN"
user="username"
password="password"
OU="CN=Computers,DC=DOMAIN"
groups="group"

# bind
dsconfigad -add "$domain" \
           -username "$user" \
           -password "$password" \
           -computer "$computer" \
           -ou "$OU" \
           -force

# configure
dsconfigad -mobile enable \
           -mobileconfirm disable \
           -localhome enable \
           -useuncpath disable \
           -groups "$groups" \
           -alldomains enable

exit 0
