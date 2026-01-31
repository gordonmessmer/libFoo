#!/bin/bash
# Minimal build script

set -e

# Build
make

branch=$(git branch --show-current)
mkdir $branch
cp -r Bar Bar-versioned lib-unversioned lib-versioned $branch
