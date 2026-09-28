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
            echo "  --system, -s    Hapus instalasi system-wide di /usr/share/icons/ (memerlukan root)"
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
        echo "Error: Pencopotan system-wide memerlukan hak akses root (sudo)."
        exit 1
    fi
    TARGET_DIR="/usr/share/icons/$THEME_NAME"
else
    TARGET_DIR="$HOME/.local/share/icons/$THEME_NAME"
fi

echo "=== Mencopot $THEME_NAME Icons ==="

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Tema $THEME_NAME tidak ditemukan di: $TARGET_DIR"
    exit 0
fi

echo "Menghapus $TARGET_DIR..."
rm -rf "$TARGET_DIR"

echo "Memperbarui icon cache sistem..."
if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 --noincremental >/dev/null 2>&1 || true
elif command -v kbuildsycoca5 >/dev/null 2>&1; then
    kbuildsycoca5 --noincremental >/dev/null 2>&1 || true
fi

echo
echo "Kiwori Icons berhasil dicopot dari sistem."
