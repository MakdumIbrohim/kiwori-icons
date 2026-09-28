#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
THEME_DIR="$ROOT_DIR/theme/Kiwori"
INDEX_THEME="$THEME_DIR/index.theme"
SRC_DIR="$ROOT_DIR/src"

ERRORS=0
WARNINGS=0

log_info() {
    printf "\033[1;34m[INFO]\033[0m %s\n" "$1"
}

log_pass() {
    printf "\033[1;32m[PASS]\033[0m %s\n" "$1"
}

log_warn() {
    printf "\033[1;33m[WARN]\033[0m %s\n" "$1"
    WARNINGS=$((WARNINGS + 1))
}

log_fail() {
    printf "\033[1;31m[FAIL]\033[0m %s\n" "$1"
    ERRORS=$((ERRORS + 1))
}

echo "=== Kiwori Icons Validation ==="

# 1. Check index.theme
log_info "Memeriksa index.theme..."
if [[ ! -f "$INDEX_THEME" ]]; then
    log_fail "File index.theme tidak ditemukan di: $INDEX_THEME"
else
    # Check essential keys
    if grep -q "^Name=Kiwori" "$INDEX_THEME" && \
       grep -q "^Inherits=hicolor" "$INDEX_THEME" && \
       grep -q "^Directories=" "$INDEX_THEME"; then
        log_pass "index.theme valid dan memiliki konfigurasi utama."
    else
        log_fail "index.theme tidak memiliki konfigurasi wajib (Name, Inherits, atau Directories)."
    fi
fi

# 2. Check category directories
CATEGORIES=("apps" "actions" "devices" "places" "mimetypes" "categories" "status" "emblems")
log_info "Memeriksa direktori kategori..."

for cat in "${CATEGORIES[@]}"; do
    if [[ ! -d "$SRC_DIR/$cat" ]]; then
        log_fail "Direktori src/$cat tidak ditemukan."
    fi
    if [[ ! -d "$THEME_DIR/scalable/$cat" ]]; then
        log_fail "Direktori theme/Kiwori/scalable/$cat tidak ditemukan."
    fi
done

# 3. Check for broken symlinks in src/ and theme/
log_info "Memeriksa broken symlink..."
BROKEN_LINKS=$(find "$SRC_DIR" "$THEME_DIR" -xtype l 2>/dev/null || true)
if [[ -n "$BROKEN_LINKS" ]]; then
    while IFS= read -r link; do
        log_fail "Broken symlink ditemukan: $link"
    done <<< "$BROKEN_LINKS"
else
    log_pass "Tidak ada broken symlink."
fi

# 4. Check SVG files
log_info "Memeriksa integritas file SVG..."
TOTAL_SVGS=0

while IFS= read -r -d '' svg_file; do
    TOTAL_SVGS=$((TOTAL_SVGS + 1))
    filename=$(basename "$svg_file")

    # Check empty file
    if [[ ! -s "$svg_file" ]]; then
        log_fail "File kosong (0 byte): $svg_file"
        continue
    fi

    # Check filename convention: lowercase, numbers, hyphens, periods (e.g. org.kde.dolphin.svg)
    if [[ ! "$filename" =~ ^[a-z0-9]+([.-][a-z0-9]+)*\.svg$ ]]; then
        log_fail "Nama file tidak sesuai standar (gunakan huruf kecil, angka, tanda hubung/titik): $filename"
    fi

    # Check basic SVG validity
    if ! grep -q "<svg" "$svg_file"; then
        log_fail "File bukan format SVG yang valid: $svg_file"
        continue
    fi

    # Check viewBox
    if ! grep -q 'viewBox="0 0 256 256"' "$svg_file"; then
        log_warn "viewBox bukan 0 0 256 256 pada: $filename"
    fi

    # Check for embedded raster images (base64 png/jpeg bloat)
    if grep -q "data:image/" "$svg_file"; then
        log_fail "Terdapat embedded raster image di: $filename"
    fi
done < <(find "$SRC_DIR" -type f -name "*.svg" -print0 2>/dev/null || true)

if [[ $TOTAL_SVGS -eq 0 ]]; then
    log_info "Belum ada icon SVG di src/ (tahap Milestone 0: scaffolding)."
else
    log_pass "Selesai memeriksa $TOTAL_SVGS file SVG."
fi

echo "==============================="
printf "Hasil: %d Gagal, %d Peringatan\n" "$ERRORS" "$WARNINGS"

if [[ $ERRORS -gt 0 ]]; then
    exit 1
fi

log_pass "Validasi Kiwori Icons berhasil!"
exit 0
