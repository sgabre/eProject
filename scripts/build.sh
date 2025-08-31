#!/bin/bash
set -e

# ---------------------------
# Parameters
# ---------------------------
PRESET=${1:-Debug}                       # Default preset
SCRIPT_DIR=$(cd $(dirname "$0") && pwd)  # scripts/ folder
ROOT_DIR="$SCRIPT_DIR/.."                # project root
BUILD_DIR="$ROOT_DIR/build/$PRESET"
INSTALL_DIR="$ROOT_DIR/libraries/$PRESET"
# ---------------------------
# Clean-up
# ---------------------------
echo "--Clean-up--"
[ -d "$BUILD_DIR" ] && rm -rf "$BUILD_DIR"
[ -d "$INSTALL_DIR" ] && rm -rf "$INSTALL_DIR"

# ---------------------------
# Configure & Build
# ---------------------------
echo "--Configuration & Build--"
cd "$ROOT_DIR"   # Important! CMakePresets.json must be in current folder
cmake --preset $PRESET
cmake --build --preset $PRESET

# ---------------------------
# Unit Testing
# ---------------------------
echo "--Unit Testing--"
#cd "$BUILD_DIR"  # ctest needs the binary directory
#ctest --verbose

# ---------------------------
# Install
# ---------------------------
echo "--Install--"
cmake --install "$ROOT_DIR/build/host/$PRESET" --prefix $INSTALL_DIR
