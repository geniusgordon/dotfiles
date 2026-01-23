#!/bin/bash
# Initialize a bare git repository with worktree layout
# Usage: init-bare-repo.sh <name> [remote-url]
#
# Creates:
#   <name>/
#     .bare/     - The bare git repository
#     main/      - Worktree for main branch

set -e

NAME="${1:?Usage: init-bare-repo.sh <name> [remote-url]}"
REMOTE="$2"

if [[ -e "$NAME" ]]; then
    echo "Error: '$NAME' already exists" >&2
    exit 1
fi

mkdir -p "$NAME"
cd "$NAME"

if [[ -n "$REMOTE" ]]; then
    # Clone as bare repo
    git clone --bare "$REMOTE" .bare

    # Configure remote fetch refs for proper tracking
    git -C .bare config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
    git -C .bare fetch origin
else
    # Initialize new bare repo
    git init --bare .bare
fi

# Set up gitdir file for worktrees to find the bare repo
echo "gitdir: $(pwd)/.bare" > .bare/gitdir

# Determine main branch name
if git -C .bare rev-parse --verify main &>/dev/null; then
    MAIN_BRANCH="main"
elif git -C .bare rev-parse --verify master &>/dev/null; then
    MAIN_BRANCH="master"
elif [[ -n "$REMOTE" ]]; then
    # Get default branch from remote
    MAIN_BRANCH=$(git -C .bare symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@refs/remotes/origin/@@' || echo "main")
else
    MAIN_BRANCH="main"
fi

# Create worktree for main branch
if [[ -n "$REMOTE" ]]; then
    git -C .bare worktree add ../main "$MAIN_BRANCH"
    # Set up tracking for main branch
    git -C main branch --set-upstream-to="origin/$MAIN_BRANCH"
else
    # For new repos, create initial branch
    git -C .bare worktree add --orphan -b "$MAIN_BRANCH" ../main
fi

echo "Created bare repo layout at '$NAME/'"
echo "  .bare/  - Bare repository"
echo "  main/   - Worktree for '$MAIN_BRANCH' branch"
echo ""
echo "To add more worktrees: cd $NAME && add-worktree.sh <branch-name>"
