#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="$ROOT_DIR/src"
THEME_DIR="$ROOT_DIR/theme/Kiwori"
SCALABLE_DIR="$THEME_DIR/scalable"

log_info() {
    printf "\033[1;34m[INFO]\033[0m %s\n" "$1"
}

log_pass() {
    printf "\033[1;32m[PASS]\033[0m %s\n" "$1"
}

echo "=== Kiwori Icons Build System ==="

# 1. Ensure target category directories exist
log_info "Preparing build directories..."
CATEGORIES=("apps" "actions" "devices" "places" "mimetypes" "categories" "status" "emblems")

for cat in "${CATEGORIES[@]}"; do
    mkdir -p "$SCALABLE_DIR/$cat"
done

# 2. Clean old SVG files in theme/Kiwori/scalable/
log_info "Cleaning legacy build artifacts..."
find "$SCALABLE_DIR" -type f -name "*.svg" -delete 2>/dev/null || true
find "$SCALABLE_DIR" -type l -name "*.svg" -delete 2>/dev/null || true

# 3. Synchronize SVG icons from src/ to theme/Kiwori/scalable/
log_info "Synchronizing icons from src/ to theme/Kiwori/scalable/..."
COPIED_COUNT=0

for cat in "${CATEGORIES[@]}"; do
    if [[ -d "$SRC_DIR/$cat" ]]; then
        # Copy regular svg files and preserve symlinks
        while IFS= read -r -d '' file; do
            cp -P "$file" "$SCALABLE_DIR/$cat/"
            COPIED_COUNT=$((COPIED_COUNT + 1))
        done < <(find "$SRC_DIR/$cat" -maxdepth 1 \( -type f -o -type l \) -name "*.svg" -print0 2>/dev/null || true)
    fi
done

log_info "Total icons synchronized: $COPIED_COUNT"

# 4. Validate build output
log_info "Executing build validation suite..."
"$ROOT_DIR/scripts/validate.sh"

log_pass "Kiwori Icons build completed successfully."
echo "Output: $THEME_DIR"
