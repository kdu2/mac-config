#!/bin/sh

# config
computer=$(scutil --get ComputerName)
domain="DOMAIN"
user="username"
password="password"
OU="CN=Computers,DC=DOMAIN"
groups="group"

# bind
dsconfigad -add $domain \
           -username $user \
           -password $password \
           -computer $computer \
           -ou $OU \
           -force \
           -mobile enable \
           -mobileconfirm disable \
           -localhome enable \
           -useuncpath disable \
           -groups $groups \
           -alldomains enable

exit 0
