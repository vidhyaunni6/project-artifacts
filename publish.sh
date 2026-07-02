#!/usr/bin/env bash
# Publish the latest project-artifact page to GitHub Pages.
# Usage: ./publish.sh ["optional commit message"]
set -euo pipefail

SITE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SITE_DIR/../Upskill Projects/project-artifact.html"
MSG="${1:-Update artifact page}"

if [[ ! -f "$SRC" ]]; then
  echo "✗ Source not found: $SRC" >&2
  exit 1
fi

cp "$SRC" "$SITE_DIR/index.html"
cd "$SITE_DIR"

if git diff --quiet -- index.html; then
  echo "✓ No changes — index.html already matches the source. Nothing to publish."
  exit 0
fi

git add index.html
git commit -qm "$MSG"
git push -q origin main
echo "✓ Published. Live in ~1 min at: https://vidhyaunni6.github.io/project-artifacts/"
