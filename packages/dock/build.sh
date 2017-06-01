#!/bin/bash

# Name of the package.
NAME="dock"

# Once installed the identifier is used as the filename for a receipt files in /var/db/receipts/.
IDENTIFIER="com.github.kdu2.$NAME"

# Package version number.
VERSION="1.0"

# Path to install files
INSTALL_LOCATION="/System/Library/User Template/English.lproj/Library/Preferences"

# files should contain com.apple.dock.plist and com.apple.finder.plist (optional)

# Build package.
pkgbuild --root files --install-location "$INSTALL_LOCATION" --scripts scripts --identifier "$IDENTIFIER" --version "$VERSION" "$NAME-$VERSION.pkg"
