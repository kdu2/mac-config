#!/bin/bash

# Name of the package.
NAME="netsupport"

# Once installed the identifier is used as the filename for a receipt files in /var/db/receipts/.
IDENTIFIER="com.github.kdu2.$NAME"

# Package version number.
VERSION="1.0"

# The location to copy the contents of files.
INSTALL_LOCATION="/Library/Application Support/NetSupport"

# Set full read, write, execute permissions for owner and just read and execute permissions for group and other.
chmod -R 755 files

# Build package.
pkgbuild --root files --install-location "$INSTALL_LOCATION" --scripts scripts --identifier "$IDENTIFIER" --version "$VERSION" "$NAME-$VERSION.pkg"
rmdir \(A\ Document\ Being\ Saved\ By\ pkgbuild\)
