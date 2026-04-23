#!/usr/bin/env bash
# Encrypt the source HTML pages with StatiCrypt.
#
# Usage:
#   STATICRYPT_PASSWORD='your-password' ./scripts/encrypt.sh
#   or
#   ./scripts/encrypt.sh    (you will be prompted for the password)
#
# Output: encrypted index.html and cx-nexus-landing-v2.html at repo root.
# Source files in src/ are left untouched.

set -euo pipefail

cd "$(dirname "$0")/.."

PRIMARY="#0000FF"    # cx-blue
SECONDARY="#0A0A0A"  # near-black
BUTTON_LABEL="VIEW PREVIEW"
INSTRUCTIONS="This preview is password-protected. Enter the password you were given to continue."

if [ -z "${STATICRYPT_PASSWORD:-}" ]; then
  read -rsp "Password: " STATICRYPT_PASSWORD
  echo
  export STATICRYPT_PASSWORD
fi

run_staticrypt() {
  local src="$1"
  local out_name="$2"
  npx --yes staticrypt "$src" \
    -d . \
    --short \
    --template-color-primary "$PRIMARY" \
    --template-color-secondary "$SECONDARY" \
    --template-button "$BUTTON_LABEL" \
    --template-instructions "$INSTRUCTIONS" \
    --template-title "CX NEXUS · Preview"
  # staticrypt preserves the input filename, move if needed
  if [ "$(basename "$src")" != "$out_name" ]; then
    mv "$(basename "$src")" "$out_name"
  fi
}

run_staticrypt "src/index.html" "index.html"
run_staticrypt "src/cx-nexus-landing-v2.html" "cx-nexus-landing-v2.html"

# Copy assets/ to repo root (served unchanged by Pages)
mkdir -p assets
cp -rf src/assets/. assets/

echo
echo "Done. Encrypted output at repo root."
echo "Commit and push to update GitHub Pages."
