#!/usr/bin/env bash
set -e

# Get list, choose one
entry=$(pass ls | fzf --prompt="Select password: ") || exit 1

# Copy to clipboard
pass -c "$entry"
echo "Copied: $entry"
