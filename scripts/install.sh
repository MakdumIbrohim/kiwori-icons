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
    BASE_DIR="/usr/share/icons"
else
    TARGET_DIR="$HOME/.local/share/icons/$THEME_NAME"
    BASE_DIR="$HOME/.local/share/icons"
fi

echo "=== Installing $THEME_NAME Icons ==="

if [[ ! -d "$SOURCE_DIR" || ! -f "$SOURCE_DIR/index.theme" ]]; then
    echo "Notice: theme/Kiwori is not built yet. Executing build..."
    "$ROOT_DIR/scripts/build.sh"
fi

mkdir -p "$BASE_DIR"

echo "Removing previous version at $TARGET_DIR..."
rm -rf "$TARGET_DIR"

echo "Copying theme files to $TARGET_DIR..."
cp -r "$SOURCE_DIR" "$TARGET_DIR"

echo "Updating desktop icon cache..."
if command -v gtk-update-icon-cache >/dev/null 2>&1; then
    gtk-update-icon-cache -q -t -f "$TARGET_DIR" || true
fi

if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 --noincremental >/dev/null 2>&1 || true
elif command -v kbuildsycoca5 >/dev/null 2>&1; then
    kbuildsycoca5 --noincremental >/dev/null 2>&1 || true
fi

echo
echo "Kiwori Icons installed successfully!"
echo "Location: $TARGET_DIR"
echo
echo "To activate on KDE Plasma:"
echo "  System Settings -> Colors & Themes -> Icons -> Select 'Kiwori'"
