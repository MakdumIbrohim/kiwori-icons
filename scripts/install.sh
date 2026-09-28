#!/usr/bin/env bash
set -euo pipefail

THEME_NAME="Kiwori"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$ROOT_DIR/theme/$THEME_NAME"

SYSTEM_INSTALL=false
INSTALL_MODE="copy" # options: "copy", "link", "git-update"
PROMPTED=false

# Argument parsing
while [[ $# -gt 0 ]]; do
    case "$1" in
        --system|-s)
            SYSTEM_INSTALL=true
            shift
            ;;
        --local|-l)
            INSTALL_MODE="copy"
            PROMPTED=true
            shift
            ;;
        --link)
            INSTALL_MODE="link"
            PROMPTED=true
            shift
            ;;
        --git-update|-u)
            INSTALL_MODE="git-update"
            PROMPTED=true
            shift
            ;;
        -h|--help)
            echo "Usage: ./scripts/install.sh [OPTIONS]"
            echo
            echo "Options:"
            echo "  --local, -l       Install as local copy from this folder (static, offline)"
            echo "  --link            Install as live symlink (auto-reflects updates on git pull)"
            echo "  --git-update, -u  Pull latest commits from GitHub before installing"
            echo "  --system, -s      Install system-wide into /usr/share/icons/ (requires root)"
            echo "  --help, -h        Display this help dialog"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Run './scripts/install.sh --help' for usage."
            exit 1
            ;;
    esac
done

# If no mode flag was passed and running interactively in terminal, ask the user
if [[ "$PROMPTED" == false && -t 0 ]]; then
    echo "=============================================="
    echo "         Kiwori Icons Installation"
    echo "=============================================="
    echo "Choose installation method:"
    echo
    echo "  1) Local Folder Copy (Default)"
    echo "     Copy theme files from this folder directly into your system."
    echo "     (Static offline installation)"
    echo
    echo "  2) Live Git Symlink"
    echo "     Link the installed theme directly to this repository via symlink."
    echo "     (Theme automatically updates whenever you run 'git pull')"
    echo
    echo "  3) Pull Latest from GitHub & Install"
    echo "     Fetch and pull the latest commits from GitHub before installing."
    echo "     (Always installs the newest upstream version)"
    echo
    read -r -p "Enter your choice [1-3] (default: 1): " USER_CHOICE
    case "$USER_CHOICE" in
        2)
            INSTALL_MODE="link"
            ;;
        3)
            INSTALL_MODE="git-update"
            ;;
        *)
            INSTALL_MODE="copy"
            ;;
    esac
    echo
fi

# If git-update mode is selected, pull latest changes from GitHub first
if [[ "$INSTALL_MODE" == "git-update" ]]; then
    if [[ -d "$ROOT_DIR/.git" ]]; then
        echo "Pulling latest updates from GitHub..."
        BRANCH="$(cd "$ROOT_DIR" && git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "main")"
        (cd "$ROOT_DIR" && git pull origin "$BRANCH") || echo "Warning: git pull failed, continuing with current files."
    else
        echo "Warning: Not a git repository, skipping git pull."
    fi
fi

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
echo "Mode: $INSTALL_MODE"

if [[ ! -d "$SOURCE_DIR" || ! -f "$SOURCE_DIR/index.theme" ]]; then
    echo "Notice: theme/Kiwori is not built yet. Executing build..."
    "$ROOT_DIR/scripts/build.sh"
fi

mkdir -p "$BASE_DIR"

echo "Removing previous installations..."
rm -rf "$TARGET_DIR" "$TARGET_DARK_DIR"

if [[ "$INSTALL_MODE" == "link" ]]; then
    echo "Creating live symlinks to repository..."
    ln -sf "$ROOT_DIR/theme/Kiwori" "$TARGET_DIR"
    if [[ -d "$ROOT_DIR/theme/Kiwori-Dark" ]]; then
        ln -sf "$ROOT_DIR/theme/Kiwori-Dark" "$TARGET_DARK_DIR"
    fi
else
    echo "Copying theme files to $BASE_DIR..."
    cp -dr "$ROOT_DIR/theme/Kiwori" "$BASE_DIR/"
    if [[ -d "$ROOT_DIR/theme/Kiwori-Dark" ]]; then
        cp -dr "$ROOT_DIR/theme/Kiwori-Dark" "$BASE_DIR/"
    fi
fi

echo "Updating desktop icon cache..."
for dir in "$TARGET_DIR" "$TARGET_DARK_DIR"; do
    if [[ -e "$dir" ]]; then
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
