#!/bin/bash
# Clean up stale worktrees and merged branches
# Usage: cleanup.sh [--dry-run]
#
# Operations:
#   - Prune stale worktree references
#   - Remove branches that have been deleted on remote (gone)
#   - Optionally remove merged branches

set -e

DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "DRY RUN - no changes will be made"
    echo ""
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

echo "=== Pruning stale worktree references ==="
if [[ "$DRY_RUN" == true ]]; then
    git -C "$BARE" worktree prune --dry-run
else
    git -C "$BARE" worktree prune -v
fi
echo ""

echo "=== Fetching and pruning remote ==="
if [[ "$DRY_RUN" == false ]]; then
    git -C "$BARE" fetch --all --prune
fi
echo ""

echo "=== Branches with deleted remotes (gone) ==="
# Find branches whose upstream is gone
GONE_BRANCHES=$(git -C "$BARE" for-each-ref --format='%(refname:short) %(upstream:track)' refs/heads | grep '\[gone\]' | awk '{print $1}' || true)

if [[ -z "$GONE_BRANCHES" ]]; then
    echo "No gone branches found."
else
    echo "Found gone branches:"
    for branch in $GONE_BRANCHES; do
        echo "  - $branch"

        # Check if branch has a worktree
        WORKTREE_PATH="$ROOT/$branch"
        if [[ -d "$WORKTREE_PATH" ]]; then
            echo "    Warning: Has worktree at $WORKTREE_PATH"
            if [[ "$DRY_RUN" == false ]]; then
                read -p "    Remove worktree and delete branch? [y/N] " -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    git -C "$BARE" worktree remove "$WORKTREE_PATH"
                    git -C "$BARE" branch -D "$branch"
                    echo "    Removed."
                fi
            fi
        else
            if [[ "$DRY_RUN" == false ]]; then
                git -C "$BARE" branch -D "$branch"
                echo "    Deleted."
            fi
        fi
    done
fi
echo ""

echo "=== Summary ==="
echo "Worktrees:"
git -C "$BARE" worktree list
