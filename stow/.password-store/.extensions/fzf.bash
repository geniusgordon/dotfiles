#!/usr/bin/env bash
set -euo pipefail

PASSWORD_STORE_DIR="${PASSWORD_STORE_DIR:-$HOME/.password-store}"

# Get list of entries (no color, no tree)
entry=$(
  find "$PASSWORD_STORE_DIR" -type f -name "*.gpg" |
    sed "s|$PASSWORD_STORE_DIR/||; s|\.gpg$||" |
    fzf --prompt="Select password: " --height=40% --reverse
) || exit 1

# Copy selected password to clipboard
pass -c "$entry"
echo "Copied: $entry"
