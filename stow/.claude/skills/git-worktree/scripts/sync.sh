#!/bin/bash
# Sync all remotes and show worktree status
# Usage: sync.sh
#
# Operations:
#   - Fetch all remotes with pruning
#   - Show which worktrees are behind their remote

set -e

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

echo "=== Fetching all remotes ==="
git -C "$BARE" fetch --all --prune
echo ""

echo "=== Worktree Status ==="
echo ""

printf "%-20s %-25s %-10s %s\n" "WORKTREE" "BRANCH" "STATUS" "REMOTE"
printf "%-20s %-25s %-10s %s\n" "--------" "------" "------" "------"

git -C "$BARE" worktree list --porcelain | while read -r line; do
    case "$line" in
        worktree\ *)
            WORKTREE_PATH="${line#worktree }"
            ;;
        branch\ *)
            BRANCH="${line#branch refs/heads/}"
            ;;
        detached)
            BRANCH="(detached)"
            ;;
        bare)
            BRANCH="(bare)"
            ;;
        "")
            # End of worktree entry
            if [[ "$BRANCH" != "(bare)" && -d "$WORKTREE_PATH" ]]; then
                NAME=$(basename "$WORKTREE_PATH")

                # Check tracking info
                TRACKING=$(git -C "$WORKTREE_PATH" rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || true)

                if [[ -n "$TRACKING" ]]; then
                    AHEAD=$(git -C "$WORKTREE_PATH" rev-list --count @{u}..HEAD 2>/dev/null || echo 0)
                    BEHIND=$(git -C "$WORKTREE_PATH" rev-list --count HEAD..@{u} 2>/dev/null || echo 0)

                    if [[ "$BEHIND" -gt 0 ]] && [[ "$AHEAD" -gt 0 ]]; then
                        STATUS="diverged"
                    elif [[ "$BEHIND" -gt 0 ]]; then
                        STATUS="behind $BEHIND"
                    elif [[ "$AHEAD" -gt 0 ]]; then
                        STATUS="ahead $AHEAD"
                    else
                        STATUS="up-to-date"
                    fi
                    REMOTE_INFO="$TRACKING"
                else
                    STATUS="no remote"
                    REMOTE_INFO="-"
                fi

                printf "%-20s %-25s %-10s %s\n" "$NAME" "$BRANCH" "$STATUS" "$REMOTE_INFO"
            fi

            # Reset
            BRANCH=""
            WORKTREE_PATH=""
            ;;
    esac
done

echo ""
echo "Tip: To update a worktree, cd into it and run 'git pull' or 'git rebase origin/<branch>'"
