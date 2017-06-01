#!/bin/bash

# uninstall all Adobe products

# system folders
rm -rf "/Applications/Adobe*"
rm -rf "/Applications/Utilities/Adobe Application Manager"
rm -rf "/Applications/Utilities/Adobe Creative Cloud"
rm -rf "/Applications/Utilities/Adobe Installers"
rm -rf "/Library/Application Support/Adobe*"
rm -rf "/Library/Caches/com.adobe*"
rm -rf "/Library/Logs/Adobe"
rm -rf "/Library/Logs/Creative Cloud"
rm -rf "/Library/Preferences/com.adobe*"
rm -rf "/Library/Preferences/com.Adobe*"

# user folders
rm -rf "/Users/admin/Library/Application Support/Adobe*"
rm -rf "/Users/admin/Library/Logs/Adobe*"
rm -rf "/Users/admin/Library/Logs/adobe*"
rm -rf "/Users/admin/Library/Preferences/Adobe*"
rm -rf "/Users/admin/Library/Preferences/com.adobe*"
