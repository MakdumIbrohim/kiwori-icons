#!/usr/bin/env bash
set -euo pipefail

THEME_NAME="Kiwori"
SYSTEM_INSTALL=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --system|-s)
            SYSTEM_INSTALL=true
            shift
            ;;
        -h|--help)
            echo "Usage: ./scripts/uninstall.sh [OPTIONS]"
            echo "Options:"
            echo "  --system, -s    Uninstall system-wide installation from /usr/share/icons/ (requires root)"
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
        echo "Error: System-wide uninstallation requires root privileges (sudo)."
        exit 1
    fi
    TARGET_DIR="/usr/share/icons/$THEME_NAME"
    TARGET_DARK_DIR="/usr/share/icons/${THEME_NAME}-Dark"
else
    TARGET_DIR="$HOME/.local/share/icons/$THEME_NAME"
    TARGET_DARK_DIR="$HOME/.local/share/icons/${THEME_NAME}-Dark"
fi

echo "=== Uninstalling $THEME_NAME & ${THEME_NAME}-Dark Icons ==="

if [[ ! -d "$TARGET_DIR" && ! -d "$TARGET_DARK_DIR" ]]; then
    echo "Theme $THEME_NAME was not found at: $TARGET_DIR"
    exit 0
fi

echo "Removing $TARGET_DIR and $TARGET_DARK_DIR..."
rm -rf "$TARGET_DIR" "$TARGET_DARK_DIR"

echo "Updating desktop icon cache..."
if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 --noincremental >/dev/null 2>&1 || true
elif command -v kbuildsycoca5 >/dev/null 2>&1; then
    kbuildsycoca5 --noincremental >/dev/null 2>&1 || true
fi

echo
echo "Kiwori Icons successfully removed from your system."
