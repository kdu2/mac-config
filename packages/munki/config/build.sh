#!/bin/bash

# Name of the package.
NAME="munkiconfig"

# Once installed the identifier is used as the filename for a receipt files in /var/db/receipts/.
IDENTIFIER="com.github.kdu2.$NAME"

# Package version number.
VERSION="1.0"

# The location to copy the contents of files.
INSTALL_LOCATION="/usr/local/munki"

# assumes the munki server's cert is in files folder

# Build package.
pkgbuild --root files --scripts scripts --install-location "$INSTALL_LOCATION" --identifier "$IDENTIFIER" --version "$VERSION" "$NAME.pkg"
