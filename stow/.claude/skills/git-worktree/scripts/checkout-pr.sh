#!/bin/bash
# Fetch and checkout a GitHub PR into a worktree
# Usage: checkout-pr.sh <pr-number> [--merged|-m]
#
# Options:
#   --merged, -m  Checkout the merge commit (what the code looks like after merging)
#                 This is what CI tests against. Fails if PR has merge conflicts.
#
# Requires: gh CLI (GitHub CLI)

set -e

# Parse arguments
MERGED_MODE=false
PR=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -m|--merged)
            MERGED_MODE=true
            shift
            ;;
        -*)
            echo "Unknown option: $1" >&2
            echo "Usage: checkout-pr.sh <pr-number> [--merged|-m]" >&2
            exit 1
            ;;
        *)
            if [[ -z "$PR" ]]; then
                PR="$1"
            else
                echo "Error: Multiple PR numbers specified" >&2
                exit 1
            fi
            shift
            ;;
    esac
done

if [[ -z "$PR" ]]; then
    echo "Usage: checkout-pr.sh <pr-number> [--merged|-m]" >&2
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

# Check if gh CLI is available
if ! command -v gh &>/dev/null; then
    echo "Error: GitHub CLI (gh) is required but not installed" >&2
    echo "Install it: brew install gh" >&2
    exit 1
fi

# Get PR details
echo "Fetching PR #$PR details..."
PR_INFO=$(gh pr view "$PR" --json headRefName,headRepository,headRepositoryOwner,state 2>/dev/null) || {
    echo "Error: Could not fetch PR #$PR. Make sure you're in a GitHub repo and the PR exists." >&2
    exit 1
}

BRANCH=$(echo "$PR_INFO" | jq -r '.headRefName')
STATE=$(echo "$PR_INFO" | jq -r '.state')
HEAD_OWNER=$(echo "$PR_INFO" | jq -r '.headRepositoryOwner.login')

if [[ "$STATE" != "OPEN" ]]; then
    echo "Warning: PR #$PR is $STATE (not OPEN)"
fi

# Set worktree name and ref based on mode
if [[ "$MERGED_MODE" == true ]]; then
    WORKTREE_NAME="pr-$PR-merged"
    FETCH_REF="pull/$PR/merge"
    MODE_DESC="merged state"
else
    WORKTREE_NAME="pr-$PR"
    FETCH_REF="pull/$PR/head"
    MODE_DESC="branch"
fi

WORKTREE_PATH="$ROOT/$WORKTREE_NAME"

if [[ -e "$WORKTREE_PATH" ]]; then
    echo "Worktree for PR #$PR ($MODE_DESC) already exists at $WORKTREE_PATH"
    echo "To update: cd $WORKTREE_PATH && git pull"
    exit 0
fi

# Fetch the PR ref
if [[ "$MERGED_MODE" == true ]]; then
    echo "Fetching PR #$PR merge commit (what it looks like after merging)..."
    if ! git -C "$BARE" fetch origin "$FETCH_REF:$WORKTREE_NAME" 2>/dev/null; then
        echo "" >&2
        echo "Error: Could not fetch merge ref for PR #$PR" >&2
        echo "" >&2
        echo "This usually means the PR has merge conflicts with the base branch." >&2
        echo "The merge ref only exists when GitHub can auto-merge the PR." >&2
        echo "" >&2
        echo "Options:" >&2
        echo "  1. Resolve conflicts in the PR first" >&2
        echo "  2. Use 'checkout-pr.sh $PR' without --merged to get the PR branch" >&2
        exit 1
    fi
else
    echo "Fetching PR #$PR branch '$BRANCH'..."
    git -C "$BARE" fetch origin "$FETCH_REF:$WORKTREE_NAME"
fi

# Create worktree
echo "Creating worktree..."
git -C "$BARE" worktree add "$WORKTREE_PATH" "$WORKTREE_NAME"

echo ""
echo "PR #$PR ($MODE_DESC) checked out at: $WORKTREE_PATH"
if [[ "$MERGED_MODE" == true ]]; then
    echo "This is the merge commit - what the code looks like after merging to base"
else
    echo "Branch: $BRANCH (local: $WORKTREE_NAME)"
fi
echo ""
echo "To start reviewing: cd $WORKTREE_PATH"
