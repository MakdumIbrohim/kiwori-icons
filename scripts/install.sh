#!/usr/bin/env bash
set -euo pipefail

THEME_NAME="Kiwori"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$ROOT_DIR/theme/$THEME_NAME"

SYSTEM_INSTALL=false

# Argumen parsing
while [[ $# -gt 0 ]]; do
    case "$1" in
        --system|-s)
            SYSTEM_INSTALL=true
            shift
            ;;
        -h|--help)
            echo "Usage: ./scripts/install.sh [OPTIONS]"
            echo "Options:"
            echo "  --system, -s    Pasang secara system-wide ke /usr/share/icons/ (memerlukan root)"
            echo "  --help, -h      Tampilkan bantuan ini"
            exit 0
            ;;
        *)
            echo "Opsi tidak dikenal: $1"
            exit 1
            ;;
    esac
done

if [[ "$SYSTEM_INSTALL" == true ]]; then
    if [[ $EUID -ne 0 ]]; then
        echo "Error: Instalasi system-wide memerlukan hak akses root (sudo)."
        exit 1
    fi
    TARGET_DIR="/usr/share/icons/$THEME_NAME"
    BASE_DIR="/usr/share/icons"
else
    TARGET_DIR="$HOME/.local/share/icons/$THEME_NAME"
    BASE_DIR="$HOME/.local/share/icons"
fi

echo "=== Memasang $THEME_NAME Icons ==="

if [[ ! -d "$SOURCE_DIR" || ! -f "$SOURCE_DIR/index.theme" ]]; then
    echo "Peringatan: Direktori theme/Kiwori belum dibangun. Menjalankan build..."
    "$ROOT_DIR/scripts/build.sh"
fi

mkdir -p "$BASE_DIR"

echo "Menghapus versi sebelumnya di $TARGET_DIR..."
rm -rf "$TARGET_DIR"

echo "Menyalin file tema ke $TARGET_DIR..."
cp -r "$SOURCE_DIR" "$TARGET_DIR"

echo "Memperbarui icon cache sistem..."
if command -v gtk-update-icon-cache >/dev/null 2>&1; then
    gtk-update-icon-cache -q -t -f "$TARGET_DIR" || true
fi

if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 --noincremental >/dev/null 2>&1 || true
elif command -v kbuildsycoca5 >/dev/null 2>&1; then
    kbuildsycoca5 --noincremental >/dev/null 2>&1 || true
fi

echo
echo "Kiwori Icons berhasil dipasang!"
echo "Lokasi: $TARGET_DIR"
echo
echo "Untuk mengaktifkan di KDE Plasma:"
echo "  System Settings -> Colors & Themes -> Icons -> Pilih 'Kiwori'"
