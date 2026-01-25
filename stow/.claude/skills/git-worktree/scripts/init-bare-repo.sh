#!/bin/bash
# Initialize a bare git repository with worktree layout
# Usage:
#   init-bare-repo.sh <url>                    # Clone with auto-derived name
#   init-bare-repo.sh <url> <name>             # Clone with custom name
#   init-bare-repo.sh <name> <remote-url>      # Clone with explicit name
#   init-bare-repo.sh <name>                   # Create empty repo
#
# Creates:
#   <name>/
#     .bare/     - The bare git repository
#     main/      - Worktree for main branch

set -e

# Helper to detect if string looks like a git URL
is_git_url() {
    [[ "$1" =~ ^(https?://|git@|ssh://|[a-zA-Z0-9_-]+@) ]]
}

# Parse arguments based on patterns
ARG1="${1:?Usage: init-bare-repo.sh <url> [name] OR <name> [remote-url]}"
ARG2="$2"

if is_git_url "$ARG1"; then
    # Pattern: <url> [name]
    REMOTE="$ARG1"
    if [[ -n "$ARG2" ]]; then
        NAME="$ARG2"
    else
        # Auto-derive name from URL
        # git@github.com:org/repo.git -> repo
        # https://github.com/org/repo.git -> repo
        NAME=$(basename "$REMOTE" .git)
    fi
elif is_git_url "$ARG2"; then
    # Pattern: <name> <remote-url>
    NAME="$ARG1"
    REMOTE="$ARG2"
else
    # Pattern: <name> (empty repo)
    NAME="$ARG1"
    REMOTE=""
fi

if [[ -e "$NAME" ]]; then
    echo "Error: '$NAME' already exists" >&2
    exit 1
fi

echo "Creating bare repo layout at '$NAME/'..."
mkdir -p "$NAME"
cd "$NAME"

if [[ -n "$REMOTE" ]]; then
    # Clone as bare repo
    git clone --bare "$REMOTE" .bare

    # Configure remote fetch refs for proper tracking
    # By default, bare clones don't fetch remote tracking branches
    git -C .bare config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
    git -C .bare fetch origin
else
    # Initialize new bare repo
    git init --bare .bare
fi

# Set up gitdir file for worktrees to find the bare repo
echo "gitdir: $(pwd)/.bare" > .bare/gitdir

# Determine main branch name
if [[ -n "$REMOTE" ]]; then
    # For cloned repos, try to detect default branch from remote
    if git -C .bare symbolic-ref refs/remotes/origin/HEAD &>/dev/null; then
        MAIN_BRANCH=$(git -C .bare symbolic-ref refs/remotes/origin/HEAD | sed 's@refs/remotes/origin/@@')
    elif git -C .bare rev-parse --verify main &>/dev/null; then
        MAIN_BRANCH="main"
    elif git -C .bare rev-parse --verify master &>/dev/null; then
        MAIN_BRANCH="master"
    else
        MAIN_BRANCH="main"
    fi
else
    # For empty repos, default to main
    MAIN_BRANCH="main"
fi

# Create worktree for main branch
if [[ -n "$REMOTE" ]]; then
    git -C .bare worktree add "../$MAIN_BRANCH" "$MAIN_BRANCH"
    # Set up tracking for main branch
    git -C "$MAIN_BRANCH" branch --set-upstream-to="origin/$MAIN_BRANCH"
else
    # For new repos, create initial orphan branch
    git -C .bare worktree add --orphan -b "$MAIN_BRANCH" "../$MAIN_BRANCH"
fi

echo ""
echo "Created bare repo layout at '$NAME/'"
echo "  .bare/          - Bare repository"
echo "  $MAIN_BRANCH/            - Worktree for '$MAIN_BRANCH' branch"
echo ""
echo "To add more worktrees: cd $NAME && add-worktree.sh <branch-name>"
