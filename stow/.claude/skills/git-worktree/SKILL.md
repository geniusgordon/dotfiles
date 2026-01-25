---
name: git-worktree
description: Manage git bare repos with worktrees for parallel feature development and code review. Use when user mentions git worktrees, bare repos, parallel branch development, reviewing PRs in separate directories, or wants to work on multiple branches simultaneously without stashing.
---

# Git Worktree Management

Manage bare git repositories with multiple worktrees for parallel development.

## Directory Layout

```
project/
├── .bare/           # Bare git repository
├── main/            # Worktree for main branch
├── feature-x/       # Worktree for feature-x branch
└── pr-123/          # Worktree for PR review
```

## Quick Reference

| Task | Command |
|------|---------|
| Clone repo (auto-named) | `init-bare-repo.sh git@github.com:org/repo.git` |
| Clone with custom name | `init-bare-repo.sh git@github.com:org/repo.git myproject` |
| Clone (explicit name) | `init-bare-repo.sh myproject git@github.com:org/repo.git` |
| Create empty repo | `init-bare-repo.sh myproject` |
| Convert existing bare clone | `convert-bare-repo.sh /path/to/repo.git` |
| Add worktree | `add-worktree.sh feature-name` |
| Add worktree from base | `add-worktree.sh feature-name main` |
| List worktrees | `list-worktrees.sh` |
| Remove worktree | `remove-worktree.sh feature-name` |
| Remove + delete branch | `remove-worktree.sh feature-name -d` |
| Checkout PR for review | `checkout-pr.sh 123` |
| Checkout PR merged state | `checkout-pr.sh 123 --merged` |
| Sync all remotes | `sync.sh` |
| Cleanup stale refs | `cleanup.sh` |

## Scripts

All scripts auto-detect the bare repo from any location within the project.

### init-bare-repo.sh

Initialize or clone a repository into worktree-friendly structure. Automatically detects whether you're cloning from a URL or creating a new repo.

```bash
# Clone with auto-derived name (creates 'repo/' directory)
init-bare-repo.sh git@github.com:org/repo.git

# Clone with custom name (URL detected automatically)
init-bare-repo.sh git@github.com:org/repo.git myproject

# Clone with explicit name (traditional syntax)
init-bare-repo.sh myproject git@github.com:org/repo.git

# Create new empty repo
init-bare-repo.sh myproject
```

### convert-bare-repo.sh

Convert an existing `git clone --bare` repository to worktree layout.

```bash
# Convert from inside the bare repo
cd /path/to/repo.git
convert-bare-repo.sh

# Or specify the path
convert-bare-repo.sh /path/to/repo.git
```

This is useful when you've already cloned with `git clone --bare` and want to adopt the worktree workflow.

### add-worktree.sh

Add worktree for new or existing branch. Automatically sets up remote tracking.

```bash
# Create new branch from main (tracks origin/feature-auth)
add-worktree.sh feature-auth

# Create from specific base
add-worktree.sh hotfix-login main

# Checkout existing remote branch (tracks origin/existing-feature)
add-worktree.sh existing-feature
```

### remove-worktree.sh

Remove worktree, optionally deleting the branch.

```bash
# Remove worktree only (keeps branch)
remove-worktree.sh feature-auth

# Remove worktree and delete branch
remove-worktree.sh feature-auth -d
```

### checkout-pr.sh

Fetch GitHub PR into worktree for review. Requires `gh` CLI.

```bash
# Checkout PR branch
checkout-pr.sh 456
# Creates pr-456/ worktree

# Checkout merged state (what happens after merge)
checkout-pr.sh 456 --merged
# Creates pr-456-merged/ worktree
# This is what CI tests against - catches conflicts with recent base changes
# Fails with helpful error if PR has merge conflicts
```

### cleanup.sh

Prune stale references and remove gone branches.

```bash
# Preview changes
cleanup.sh --dry-run

# Execute cleanup
cleanup.sh
```

## Workflows

### Feature Development

```bash
# Start new feature (tracking auto-configured)
add-worktree.sh feature-auth
cd ../feature-auth
# ... work on feature ...
git push  # tracking already set up

# Switch to another task without stashing
cd ../main
add-worktree.sh hotfix-urgent
```

### Code Review

```bash
# Review a PR
checkout-pr.sh 123
cd ../pr-123
# ... review, test, comment ...

# Clean up after merge
remove-worktree.sh pr-123 -d
```
