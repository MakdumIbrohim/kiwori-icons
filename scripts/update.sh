#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== Updating Kiwori Icons from GitHub ==="

if [[ ! -d "$ROOT_DIR/.git" ]]; then
    echo "Error: $ROOT_DIR is not a git repository. Cannot pull from GitHub."
    exit 1
fi

cd "$ROOT_DIR"

BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "main")"
echo "Pulling latest updates on branch '$BRANCH'..."
git pull origin "$BRANCH"

echo "Building updated icons..."
"$ROOT_DIR/scripts/build.sh"

echo "Re-installing to system..."
"$ROOT_DIR/scripts/install.sh" --local

echo
echo "Kiwori Icons successfully updated to latest version!"
