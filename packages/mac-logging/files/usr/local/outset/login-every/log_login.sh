#!/bin/bash

# Records basic user and computer data to a log file. 
# This script is focussed on collecting data for tracking login/logouts but can 
# be used generically with the activity argument being the name of any event you wish to track.
# $1 - output direction: if argument is 'test', will write to standard output and local home folder 
#      if anything else (including blank), will write to log file

# 7/11/17
# kdu2

# Build attributes ----------------------------------
activity='logon'
activity_datetime=$(date +%D" "%r)
# get output from command, get relevant line, and get the second field (and extras just in case)
mac_address=$(ifconfig en0 | grep -i ether | grep -v autoselect | awk '{print $2}')
ip_address=$(ifconfig en0 | grep -iw inet | awk '{print $2}')
# computer name
computer_name=$(hostname -s)
# os version
#os=$(sw_vers -productName)
os_version=$(sw_vers -productVersion)
case $os_version in
    "10.12"* )
        os="macOS"
        ;;
    "10.8"* | "10.9"* | "10.10"* | "10.11"* )
        os="OS X"
        ;;
    *)
        os="Mac OS X"
        ;;
esac
# model name; processor; number @ speed; RAM
computer_model=$(system_profiler SPHardwareDataType | grep -i 'Model Name' | awk '{print $3, $4, $5, $6, $7, $8}' | sed 's/[[:space:]]*$//')
cpu_type=$(system_profiler SPHardwareDataType | grep -i 'Processor Name' | awk '{print $3, $4, $5, $6, $7, $8}' | sed 's/[[:space:]]*$//')
cpu_count=$(system_profiler SPHardwareDataType | egrep -i 'Number of CPUs|Number of Processors' | awk '{print $4, $5, $6}' | sed 's/[[:space:]]*$//')
core_count=$(system_profiler SPHardwareDataType | grep -i 'Total Number Of Cores' | awk '{print $5, $6, $7}' | sed 's/[[:space:]]*$//')
cpu_speed=$(system_profiler SPHardwareDataType | grep -i 'Processor speed' | awk '{print $3, $4, $5, $6, $7, $8}' | sed 's/[[:space:]]*$//')
memory=$(system_profiler SPHardwareDataType | grep -i 'Memory' | awk '{print $2, $3, $4}' | sed 's/[[:space:]]*$//')
computer=$computer_model";"$cpu_type";"$cpu_count" processor(s)~"$core_count" core(s)~"$cpu_speed";"$memory
# username
username=$(whoami)
# add as many local admin or other accounts to ignore as needed
case $username in
    "admin" | "admin2" ) exit 0
esac

# area
case $computer_name in
    "prefix1"* )
        area="area1"
        member="true"
        ;;
    "prefix2"* | "prefix3"* )
        area="area2"
        ismember=$(groups | grep group1)
        if [[ $ismember != "" ]]; then 
            member="true"
        fi
        ;;
    *)
        area="UNKNOWN"
        member="true"
        ;;
esac

# hard-coded for debug
if [[ $member == "" ]]; then 
    member="member"
fi
share="[no share info]"

# build line to write to log file
LOGLINE="\"$area\",\"$username\",\"$member\",\"$activity\",\"$activity_datetime\",\"$computer_name\",\"$os\",\"$os_version\",\"$computer\",\"$share\",\"$ip_address\",\"$mac_address\""

# Output Data ---------------------------------

share_connect_str="//DOMAIN;user:password@server/share/folder"
if [ "$1" != "test" ]; then
    local_mount="/Users/$username/.logs_dir"
else
    local_mount="/Users/$username/Library/Logs"
fi

# log file name
# [area] - [YYYYMMDD].log
log_filename="$area - $(date +%Y%m%d).log"

# mount share if not already mounted
mounted=$(mount | grep share)
if [ ! -d $local_mount ]; then
    mkdir $local_mount
    if [ "$1" != 'test' ] && [[ $mounted == "" ]]; then
        mount -t smbfs $share_connect_str $local_mount
    fi
fi

# if the file does not already exist, create it by writing the file header
if [ ! -f "$local_mount/$log_filename" ]; then
    log_header="\"area\",\"username\",\"member\",\"activity\",\"activity_datetime\",\"computer_name\",\"os\",\"os_version\",\"processor_info\",\"drive_share\",\"ip_address\",\"mac_address\""
    echo -ne "$log_header\r\n" > "$local_mount/$log_filename"
fi

# write to file
echo -ne "$LOGLINE\n" >> "$local_mount/$log_filename"

# unmount drive
mounted=$(mount | grep share)
if [ "$mounted" != "" ]; then
    umount $local_mount
fi

exit 0