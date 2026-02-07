#!/bin/bash
# Migrate from old .bare/ layout to .git/ layout
# Usage: migrate-to-git.sh [project-path]
#
# Run from the project root or pass the path as an argument.
# Updates all worktree references after renaming .bare/ to .git/

set -e

ROOT="${1:-.}"
ROOT=$(cd "$ROOT" && pwd)

if [[ ! -d "$ROOT/.bare" ]]; then
    echo "Error: No .bare/ directory found in $ROOT" >&2
    exit 1
fi

if [[ -e "$ROOT/.git" ]]; then
    echo "Error: .git already exists in $ROOT (remove it first if it's a gitdir file from the old layout)" >&2
    exit 1
fi

echo "Migrating $ROOT from .bare/ to .git/ layout..."

# Step 1: Rename .bare to .git
mv "$ROOT/.bare" "$ROOT/.git"
echo "  Renamed .bare/ → .git/"

# Step 2: Update each worktree's .git file to reference .git/ instead of .bare/
UPDATED=0
for wt_gitdir_file in "$ROOT/.git/worktrees"/*/gitdir; do
    [[ -f "$wt_gitdir_file" ]] || continue

    # Read the absolute path to the worktree's .git file
    wt_git_file=$(cat "$wt_gitdir_file")

    if [[ -f "$wt_git_file" ]]; then
        OLD_CONTENT=$(cat "$wt_git_file")
        NEW_CONTENT="${OLD_CONTENT/.bare\/worktrees/.git\/worktrees}"

        if [[ "$OLD_CONTENT" != "$NEW_CONTENT" ]]; then
            echo "$NEW_CONTENT" > "$wt_git_file"
            UPDATED=$((UPDATED + 1))
            echo "  Updated $(dirname "$wt_git_file")/.git"
        fi
    else
        echo "  Warning: worktree .git file not found at $wt_git_file"
    fi
done

# Step 3: Remove legacy gitdir file (old init script artifact)
if [[ -f "$ROOT/.git/gitdir" ]]; then
    rm "$ROOT/.git/gitdir"
    echo "  Removed legacy .git/gitdir"
fi

echo ""
echo "Migration complete! ($UPDATED worktree(s) updated)"
echo "Verify with: cd $ROOT && git worktree list"
