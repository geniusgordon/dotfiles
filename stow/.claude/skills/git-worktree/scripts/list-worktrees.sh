#!/bin/bash
# List all worktrees with their status
# Usage: list-worktrees.sh

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

echo "Worktrees in $ROOT:"
echo ""

# Get worktree list with porcelain format for parsing
git -C "$BARE" worktree list --porcelain | while read -r line; do
    case "$line" in
        worktree\ *)
            WORKTREE_PATH="${line#worktree }"
            ;;
        HEAD\ *)
            HEAD="${line#HEAD }"
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
            # End of worktree entry - print info
            if [[ "$BRANCH" != "(bare)" ]]; then
                NAME=$(basename "$WORKTREE_PATH")

                # Get status
                if [[ -d "$WORKTREE_PATH" ]]; then
                    CHANGES=$(git -C "$WORKTREE_PATH" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
                    if [[ "$CHANGES" -gt 0 ]]; then
                        STATUS="[$CHANGES changes]"
                    else
                        STATUS="[clean]"
                    fi

                    # Check if behind/ahead of remote
                    TRACKING=$(git -C "$WORKTREE_PATH" rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || true)
                    if [[ -n "$TRACKING" ]]; then
                        AHEAD=$(git -C "$WORKTREE_PATH" rev-list --count @{u}..HEAD 2>/dev/null || echo 0)
                        BEHIND=$(git -C "$WORKTREE_PATH" rev-list --count HEAD..@{u} 2>/dev/null || echo 0)
                        if [[ "$AHEAD" -gt 0 ]] || [[ "$BEHIND" -gt 0 ]]; then
                            STATUS="$STATUS [+$AHEAD/-$BEHIND]"
                        fi
                    fi
                else
                    STATUS="[missing]"
                fi

                printf "  %-20s %-30s %s\n" "$NAME" "$BRANCH" "$STATUS"
            fi

            # Reset for next entry
            BRANCH=""
            HEAD=""
            WORKTREE_PATH=""
            ;;
    esac
done
