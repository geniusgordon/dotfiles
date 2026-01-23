#!/bin/bash
# Add a new worktree for a branch
# Usage: add-worktree.sh <name> [base-branch]
#
# If the branch exists (locally or remote), checks it out with tracking.
# If the branch doesn't exist, creates it from base-branch (default: main).

set -e

NAME="${1:?Usage: add-worktree.sh <name> [base-branch]}"
BASE="$2"
TRACKING_INFO=""

# Find the bare repo
find_bare_repo() {
    local dir="$PWD"
    while [[ "$dir" != "/" ]]; do
        if [[ -d "$dir/.bare" ]]; then
            echo "$dir"
            return 0
        fi
        dir=$(dirname "$dir")
    done
    return 1
}

ROOT=$(find_bare_repo) || {
    echo "Error: Not inside a bare repo worktree structure" >&2
    echo "Run this from within a project that has a .bare/ directory" >&2
    exit 1
}

BARE="$ROOT/.bare"
WORKTREE_PATH="$ROOT/$NAME"

if [[ -e "$WORKTREE_PATH" ]]; then
    echo "Error: '$WORKTREE_PATH' already exists" >&2
    exit 1
fi

# Check if branch exists locally
if git -C "$BARE" rev-parse --verify "$NAME" &>/dev/null; then
    echo "Checking out existing local branch '$NAME'..."
    git -C "$BARE" worktree add "$WORKTREE_PATH" "$NAME"

    # Set up tracking if remote exists and not already tracking
    if git -C "$BARE" rev-parse --verify "origin/$NAME" &>/dev/null; then
        CURRENT_UPSTREAM=$(git -C "$WORKTREE_PATH" rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || true)
        if [[ -z "$CURRENT_UPSTREAM" ]]; then
            git -C "$WORKTREE_PATH" branch --set-upstream-to="origin/$NAME"
            TRACKING_INFO="Tracking: origin/$NAME"
        else
            TRACKING_INFO="Tracking: $CURRENT_UPSTREAM"
        fi
    fi

# Check if branch exists on remote
elif git -C "$BARE" rev-parse --verify "origin/$NAME" &>/dev/null; then
    echo "Checking out remote branch 'origin/$NAME'..."
    git -C "$BARE" worktree add --track -b "$NAME" "$WORKTREE_PATH" "origin/$NAME"
    TRACKING_INFO="Tracking: origin/$NAME"

else
    # Create new branch
    if [[ -z "$BASE" ]]; then
        # Default to main/master
        if git -C "$BARE" rev-parse --verify main &>/dev/null; then
            BASE="main"
        elif git -C "$BARE" rev-parse --verify master &>/dev/null; then
            BASE="master"
        else
            BASE="HEAD"
        fi
    fi
    echo "Creating new branch '$NAME' from '$BASE'..."
    git -C "$BARE" worktree add -b "$NAME" "$WORKTREE_PATH" "$BASE"

    # Set up tracking to origin/$NAME (will work after first push)
    git -C "$WORKTREE_PATH" config "branch.$NAME.remote" origin
    git -C "$WORKTREE_PATH" config "branch.$NAME.merge" "refs/heads/$NAME"
    TRACKING_INFO="Tracking: origin/$NAME (push to create)"
fi

echo ""
echo "Worktree created at: $WORKTREE_PATH"
[[ -n "$TRACKING_INFO" ]] && echo "$TRACKING_INFO"
echo "To start working: cd $WORKTREE_PATH"
