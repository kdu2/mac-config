#!/bin/bash

# Name of the package.
NAME="mountshare"

# Once installed the identifier is used as the filename for a receipt files in /var/db/receipts/.
IDENTIFIER="com.github.kdu2.$NAME"

# Package version number.
VERSION="1.0"

# The location to copy the contents of files.
INSTALL_LOCATION="/usr/local/outset/login-every"

# Set full read, write, execute permissions for owner and just read and execute permissions for group and other.
chmod -R 755 files

# Build package.
pkgbuild --root files --install-location "$INSTALL_LOCATION" --identifier "$IDENTIFIER" --version "$VERSION" "$NAME.pkg"
