#!/bin/bash
# Minimal build script for Meson

set -e

# Setup build directory
meson setup builddir

# Build
meson compile -C builddir

echo ""
echo "Build complete. Library built as:"
find builddir -name "libFoo.so*" -type f | head -1
