#!/usr/bin/env bash
set -euo pipefail

THEME_NAME="Kiwori"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$ROOT_DIR/theme/$THEME_NAME"

SYSTEM_INSTALL=false

# Argument parsing
while [[ $# -gt 0 ]]; do
    case "$1" in
        --system|-s)
            SYSTEM_INSTALL=true
            shift
            ;;
        -h|--help)
            echo "Usage: ./scripts/install.sh [OPTIONS]"
            echo "Options:"
            echo "  --system, -s    Install system-wide into /usr/share/icons/ (requires root)"
            echo "  --help, -h      Display this help dialog"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

if [[ "$SYSTEM_INSTALL" == true ]]; then
    if [[ $EUID -ne 0 ]]; then
        echo "Error: System-wide installation requires root privileges (sudo)."
        exit 1
    fi
    TARGET_DIR="/usr/share/icons/$THEME_NAME"
    TARGET_DARK_DIR="/usr/share/icons/${THEME_NAME}-Dark"
    BASE_DIR="/usr/share/icons"
else
    TARGET_DIR="$HOME/.local/share/icons/$THEME_NAME"
    TARGET_DARK_DIR="$HOME/.local/share/icons/${THEME_NAME}-Dark"
    BASE_DIR="$HOME/.local/share/icons"
fi

echo "=== Installing $THEME_NAME & ${THEME_NAME}-Dark Icons ==="

if [[ ! -d "$SOURCE_DIR" || ! -f "$SOURCE_DIR/index.theme" ]]; then
    echo "Notice: theme/Kiwori is not built yet. Executing build..."
    "$ROOT_DIR/scripts/build.sh"
fi

mkdir -p "$BASE_DIR"

echo "Removing previous versions..."
rm -rf "$TARGET_DIR" "$TARGET_DARK_DIR"

echo "Copying theme files to $BASE_DIR..."
cp -dr "$ROOT_DIR/theme/Kiwori" "$BASE_DIR/"
if [[ -d "$ROOT_DIR/theme/Kiwori-Dark" ]]; then
    cp -dr "$ROOT_DIR/theme/Kiwori-Dark" "$BASE_DIR/"
fi

echo "Updating desktop icon cache..."
for dir in "$TARGET_DIR" "$TARGET_DARK_DIR"; do
    if [[ -d "$dir" ]]; then
        if command -v gtk-update-icon-cache >/dev/null 2>&1; then
            gtk-update-icon-cache -q -t -f "$dir" || true
        fi
    fi
done

if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 --noincremental >/dev/null 2>&1 || true
elif command -v kbuildsycoca5 >/dev/null 2>&1; then
    kbuildsycoca5 --noincremental >/dev/null 2>&1 || true
fi

echo
echo "Kiwori & Kiwori Dark icons installed successfully!"
echo "Locations:"
echo "  Standard:  $TARGET_DIR"
echo "  Dark Mode: $TARGET_DARK_DIR"
echo
echo "To activate on KDE Plasma:"
echo "  Light theme: System Settings -> Colors & Themes -> Icons -> Select 'Kiwori'"
echo "  Dark theme:  System Settings -> Colors & Themes -> Icons -> Select 'Kiwori Dark'"
