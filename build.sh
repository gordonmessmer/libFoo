#!/bin/bash
# Minimal build script for CMake

set -e

# Create build directory
mkdir -p build
cd build

# Configure
cmake ..

# Build
make

echo ""
echo "Build complete. Library built as:"
find . -name "libFoo.so*" -type f | head -1
