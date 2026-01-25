#!/bin/bash
# Convert an existing bare clone to worktree-friendly structure
# Usage: convert-bare-repo.sh [path]
#
# This converts a repository created with 'git clone --bare' into
# the worktree layout used by this skill.
#
# Before:
#   repo.git/          # Bare clone (contains git objects directly)
#
# After:
#   repo/
#     .bare/           # Moved bare repository
#     main/            # Worktree for main branch

set -e

# Get path to convert (default: current directory)
BARE_PATH="${1:-.}"
BARE_PATH=$(cd "$BARE_PATH" && pwd)  # Resolve to absolute path

# Validate it's a bare repository
if ! git -C "$BARE_PATH" rev-parse --is-bare-repository &>/dev/null; then
    echo "Error: '$BARE_PATH' is not a git repository" >&2
    exit 1
fi

IS_BARE=$(git -C "$BARE_PATH" rev-parse --is-bare-repository)
if [[ "$IS_BARE" != "true" ]]; then
    echo "Error: '$BARE_PATH' is not a bare repository" >&2
    echo "This script is for converting 'git clone --bare' repos." >&2
    echo "For regular repos, use init-bare-repo.sh with a remote URL." >&2
    exit 1
fi

# Check if already converted (has .bare subdirectory)
if [[ -d "$BARE_PATH/.bare" ]]; then
    echo "Error: '$BARE_PATH' already has a .bare/ directory" >&2
    echo "It appears to already be in worktree layout." >&2
    exit 1
fi

# Determine parent directory and repo name
PARENT_DIR=$(dirname "$BARE_PATH")
REPO_NAME=$(basename "$BARE_PATH")

# Strip .git suffix if present (repo.git -> repo)
if [[ "$REPO_NAME" == *.git ]]; then
    NEW_NAME="${REPO_NAME%.git}"
else
    NEW_NAME="$REPO_NAME"
fi

NEW_PATH="$PARENT_DIR/$NEW_NAME"

# If the new path would be the same as current, we need a temp move
NEEDS_RENAME=false
if [[ "$BARE_PATH" == "$NEW_PATH" ]] || [[ "$REPO_NAME" != *.git ]]; then
    # Repo doesn't have .git suffix, we'll convert in place
    NEEDS_RENAME=false
    NEW_PATH="$BARE_PATH"
else
    NEEDS_RENAME=true
    if [[ -e "$NEW_PATH" ]]; then
        echo "Error: '$NEW_PATH' already exists" >&2
        exit 1
    fi
fi

echo "Converting bare repository to worktree layout..."
echo "  Source: $BARE_PATH"

# Create temporary directory for the move
TEMP_BARE=$(mktemp -d)
trap "rm -rf '$TEMP_BARE'" EXIT

# Move all git contents to temp
echo "  Moving git data..."
mv "$BARE_PATH"/* "$TEMP_BARE"/ 2>/dev/null || true
mv "$BARE_PATH"/.* "$TEMP_BARE"/ 2>/dev/null || true

# Set up new structure
if [[ "$NEEDS_RENAME" == true ]]; then
    rmdir "$BARE_PATH"
    mkdir -p "$NEW_PATH"
else
    # Reuse the now-empty directory
    true
fi

# Move bare repo into .bare/
mkdir -p "$NEW_PATH/.bare"
mv "$TEMP_BARE"/* "$NEW_PATH/.bare/" 2>/dev/null || true
mv "$TEMP_BARE"/.* "$NEW_PATH/.bare/" 2>/dev/null || true

# Configure remote fetch refs (bare clones often miss this)
if git -C "$NEW_PATH/.bare" remote get-url origin &>/dev/null; then
    git -C "$NEW_PATH/.bare" config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
    git -C "$NEW_PATH/.bare" fetch origin 2>/dev/null || echo "  Warning: Could not fetch from origin"
fi

# Set up gitdir file
echo "gitdir: $NEW_PATH/.bare" > "$NEW_PATH/.bare/gitdir"

# Determine main branch name
if git -C "$NEW_PATH/.bare" symbolic-ref refs/remotes/origin/HEAD &>/dev/null; then
    MAIN_BRANCH=$(git -C "$NEW_PATH/.bare" symbolic-ref refs/remotes/origin/HEAD | sed 's@refs/remotes/origin/@@')
elif git -C "$NEW_PATH/.bare" rev-parse --verify main &>/dev/null; then
    MAIN_BRANCH="main"
elif git -C "$NEW_PATH/.bare" rev-parse --verify master &>/dev/null; then
    MAIN_BRANCH="master"
else
    # Fallback: use the first branch found
    MAIN_BRANCH=$(git -C "$NEW_PATH/.bare" branch --list | head -1 | tr -d '* ')
    if [[ -z "$MAIN_BRANCH" ]]; then
        echo "Error: Could not determine main branch" >&2
        exit 1
    fi
fi

# Create worktree for main branch
echo "  Creating main worktree..."
git -C "$NEW_PATH/.bare" worktree add "$NEW_PATH/$MAIN_BRANCH" "$MAIN_BRANCH"

# Set up tracking for main branch if remote exists
if git -C "$NEW_PATH/.bare" rev-parse --verify "origin/$MAIN_BRANCH" &>/dev/null; then
    git -C "$NEW_PATH/$MAIN_BRANCH" branch --set-upstream-to="origin/$MAIN_BRANCH"
fi

# Clean up trap
trap - EXIT
rm -rf "$TEMP_BARE"

echo ""
echo "Conversion complete!"
echo "  New layout: $NEW_PATH/"
echo "    .bare/        - Bare repository"
echo "    $MAIN_BRANCH/          - Worktree for '$MAIN_BRANCH' branch"
echo ""
echo "To add more worktrees: cd $NEW_PATH && add-worktree.sh <branch-name>"
