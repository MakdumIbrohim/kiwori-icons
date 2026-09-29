#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LAUNCHERS_DIR="$ROOT_DIR/launchers"

if [[ $# -eq 0 ]]; then
    echo "Usage: ./scripts/set-launcher.sh <variant>"
    echo "Available variants in launchers/:"
    for f in "$LAUNCHERS_DIR"/*.svg; do
        basename "$f" .svg
    done
    exit 1
fi

CHOICE="$1"
TARGET_SVG="$LAUNCHERS_DIR/$CHOICE.svg"

if [[ ! -f "$TARGET_SVG" ]]; then
    echo "Error: Launcher '$CHOICE' not found in $LAUNCHERS_DIR."
    echo "Available: $(cd "$LAUNCHERS_DIR" && ls *.svg | sed 's/\.svg//' | tr '\n' ' ')"
    exit 1
fi

echo "Setting active application launcher to '$CHOICE'..."

# Copy to places/start-here.svg and apps/distributor-logo.svg
cp "$TARGET_SVG" "$ROOT_DIR/src/places/start-here.svg"
cp "$TARGET_SVG" "$ROOT_DIR/src/apps/distributor-logo.svg"

cd "$ROOT_DIR"
echo "Rebuilding and updating installed theme..."
make build
make install

echo
echo "Launcher icon updated to '$CHOICE' successfully!"
