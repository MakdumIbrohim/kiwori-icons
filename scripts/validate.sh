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
log_info "Verifying index.theme configuration..."
if [[ ! -f "$INDEX_THEME" ]]; then
    log_fail "File index.theme not found at: $INDEX_THEME"
else
    # Check essential keys
    if grep -q "^Name=Kiwori" "$INDEX_THEME" && \
       grep -E -q "^Inherits=.*hicolor" "$INDEX_THEME" && \
       grep -q "^Directories=" "$INDEX_THEME"; then
        log_pass "index.theme is valid with required keys."
    else
        log_fail "index.theme is missing mandatory keys (Name, Inherits, or Directories)."
    fi
fi

# 2. Check category directories
CATEGORIES=("apps" "actions" "devices" "places" "mimetypes" "categories" "status" "emblems")
log_info "Verifying category directory structures..."

for cat in "${CATEGORIES[@]}"; do
    if [[ ! -d "$SRC_DIR/$cat" ]]; then
        log_fail "Source directory src/$cat not found."
    fi
    if [[ ! -d "$THEME_DIR/scalable/$cat" ]]; then
        log_fail "Theme directory theme/Kiwori/scalable/$cat not found."
    fi
done

# 3. Check for broken symlinks in src/ and theme/
log_info "Checking for broken symlinks..."
BROKEN_LINKS=$(find "$SRC_DIR" "$THEME_DIR" -xtype l 2>/dev/null || true)
if [[ -n "$BROKEN_LINKS" ]]; then
    while IFS= read -r link; do
        log_fail "Broken symlink detected: $link"
    done <<< "$BROKEN_LINKS"
else
    log_pass "No broken symlinks found."
fi

# 4. Check SVG files
log_info "Validating SVG file integrity..."
TOTAL_SVGS=0

while IFS= read -r -d '' svg_file; do
    TOTAL_SVGS=$((TOTAL_SVGS + 1))
    filename=$(basename "$svg_file")

    # Check empty file
    if [[ ! -s "$svg_file" ]]; then
        log_fail "Zero-byte empty file: $svg_file"
        continue
    fi

    # Check filename convention: allow FreeDesktop reverse-DNS names
    # (e.g. org.mozilla.firefox.svg, com.obsproject.Studio.svg, Zoom.svg).
    # Desktop entry Icon= keys are case-sensitive and must match exactly.
    if [[ ! "$filename" =~ ^[A-Za-z0-9]+([._-][A-Za-z0-9]+)*\.svg$ ]]; then
        log_fail "Filename does not adhere to naming standard (use alphanumerics with dots, hyphens, underscores): $filename"
    fi

    # Check basic SVG validity
    if ! grep -q "<svg" "$svg_file"; then
        log_fail "File is not valid SVG format: $svg_file"
        continue
    fi

    # Check viewBox
    if ! grep -q 'viewBox="0 0 256 256"' "$svg_file"; then
        log_warn "viewBox is not '0 0 256 256' in: $filename"
    fi

    # Check for embedded raster images (base64 bloat)
    if grep -q "data:image/" "$svg_file"; then
        log_fail "Embedded raster image detected in: $filename"
    fi
done < <(find "$SRC_DIR" -type f -name "*.svg" -print0 2>/dev/null || true)

if [[ $TOTAL_SVGS -eq 0 ]]; then
    log_info "No SVG icons found in src/ yet."
else
    log_pass "Checked $TOTAL_SVGS SVG icon files."
fi

echo "==============================="
printf "Summary: %d Failed, %d Warnings\n" "$ERRORS" "$WARNINGS"

if [[ $ERRORS -gt 0 ]]; then
    exit 1
fi

log_pass "Kiwori Icons validation successful!"
exit 0
