#!/bin/bash

# download the munkitools pkg and run pkgutil --expand munkitools.pkg
# delete unwanted components and update Distribution file

# Name of the package.
NAME="munkitools"

# Package version number.
VERSION="1.0"

# Build package.
pkgutil --flatten files "$NAME.pkg"
