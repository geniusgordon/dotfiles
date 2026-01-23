#!/bin/bash
# Remove a worktree and optionally delete its branch
# Usage: remove-worktree.sh <name> [-d|--delete-branch]
#
# Options:
#   -d, --delete-branch  Also delete the branch after removing worktree

set -e

DELETE_BRANCH=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -d|--delete-branch)
            DELETE_BRANCH=true
            shift
            ;;
        -*)
            echo "Unknown option: $1" >&2
            exit 1
            ;;
        *)
            NAME="$1"
            shift
            ;;
    esac
done

if [[ -z "$NAME" ]]; then
    echo "Usage: remove-worktree.sh <name> [-d|--delete-branch]" >&2
    exit 1
fi

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
    exit 1
}

BARE="$ROOT/.bare"
WORKTREE_PATH="$ROOT/$NAME"

# Check if worktree exists
if [[ ! -d "$WORKTREE_PATH" ]]; then
    echo "Error: Worktree '$NAME' does not exist at $WORKTREE_PATH" >&2
    exit 1
fi

# Get branch name before removing worktree
BRANCH=$(git -C "$WORKTREE_PATH" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "$NAME")

# Prevent removing main worktree
if [[ "$NAME" == "main" || "$BRANCH" == "main" || "$BRANCH" == "master" ]]; then
    echo "Warning: Refusing to remove main/master worktree" >&2
    exit 1
fi

# Remove the worktree
echo "Removing worktree '$NAME'..."
git -C "$BARE" worktree remove "$WORKTREE_PATH"

# Optionally delete the branch
if [[ "$DELETE_BRANCH" == true ]]; then
    echo "Deleting branch '$BRANCH'..."
    git -C "$BARE" branch -D "$BRANCH" 2>/dev/null || {
        echo "Warning: Could not delete branch '$BRANCH' (may not exist or is checked out elsewhere)" >&2
    }
fi

echo "Done."
