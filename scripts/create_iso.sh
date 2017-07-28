#!/bin/bash

function createISO() {
    local installerapp=$1
    local isoname=$2
    
    hdiutil attach /Applications/"$installerapp"/Contents/SharedSupport/InstallESD.dmg -noverify -nobrowse -mountpoint /Volumes/install_app
    
    case "$installerapp" in
        "Install macOS Sierra.app") size="5120m";;
        "Install OS X El Capitan.app") size="6400m";;
        "Install OS X Yosemite.app") size="6144m";;
    esac
    hdiutil create -o /tmp/"$isoname".cdr -size "$size" -layout SPUD -fs HFS+J

    hdiutil attach /tmp/"$isoname".cdr.dmg -noverify -nobrowse -mountpoint /Volumes/install_build
    asr restore -source /Volumes/install_app/BaseSystem.dmg -target /Volumes/install_build -noprompt -noverify -erase
    rm /Volumes/OS\ X\ Base\ System/System/Installation/Packages
    cp -rp /Volumes/install_app/Packages /Volumes/OS\ X\ Base\ System/System/Installation/
    cp -rp /Volumes/install_app/BaseSystem.chunklist /Volumes/OS\ X\ Base\ System/BaseSystem.chunklist
    cp -rp /Volumes/install_app/BaseSystem.dmg /Volumes/OS\ X\ Base\ System/BaseSystem.dmg
    hdiutil detach /Volumes/install_app
    hdiutil detach /Volumes/OS\ X\ Base\ System
    hdiutil convert /tmp/"$isoname".cdr.dmg -format UDTO -o /tmp/"$isoname".iso
    mv /tmp/"$isoname".iso.cdr ~/Downloads/"$isoname".iso
    open ~/Downloads
}

echo ""
echo "OS versions available"
echo "    1. macOS 10.12 Sierra"
echo "    2. OS X 10.11 El Capitan"
echo "    3. OS X 10.10 Yosemite"
read -p "Choose OS version to create ISO (Enter number 1-3): " osversion

case $osversion in
    1)
        echo "Creating macOS Sierra iso"
        createISO "Install macOS Sierra.app" "macOS 10.12"
        ;;
    2)
        echo "Creating OS X El Capitan iso"
        createISO "Install OS X El Capitan.app" "OS X 10.11"
        ;;
    3)
        echo "Creating OS X Yosemite iso"
        createISO "Install OS X Yosemite.app" "OS X 10.10"
        ;;
    *)
        echo "Could not find installer for Yosemite (10.10), El Capitan (10.11) or Sierra (10.12)"
        ;;
esac
