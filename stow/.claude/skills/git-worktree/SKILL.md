---
name: git-worktree
description: Manage git bare repos with worktrees for parallel feature development and code review. Use when user mentions git worktrees, bare repos, parallel branch development, reviewing PRs in separate directories, or wants to work on multiple branches simultaneously without stashing.
---

# Git Worktree Management

Manage bare git repositories with multiple worktrees for parallel development.

## Script Location

**IMPORTANT:** All scripts are located in the `scripts/` subdirectory of this skill:
```
<skill-directory>/scripts/
```

When invoking scripts, use the full path from the skill directory. For example:
```bash
/path/to/skill/scripts/init-bare-repo.sh <args>
```

Or if you're in the skill directory:
```bash
./scripts/init-bare-repo.sh <args>
```

## Directory Layout

```
project/
├── .git/            # Bare git repository (core.bare=true)
├── main/            # Worktree for main branch
├── feature-x/       # Worktree for feature-x branch
└── pr-123/          # Worktree for PR review
```

Git natively finds `.git/` so `git log`, `git branch`, `git fetch`, `git worktree list` etc. work directly from the project root. Working tree operations (`git status`, `git add`) are done inside worktree directories.

## Quick Reference

All commands assume `$SKILL` is the path to this skill directory.

| Task | Command |
|------|---------|
| Clone repo (auto-named) | `$SKILL/scripts/init-bare-repo.sh git@github.com:org/repo.git` |
| Clone with custom name | `$SKILL/scripts/init-bare-repo.sh git@github.com:org/repo.git myproject` |
| Clone (explicit name) | `$SKILL/scripts/init-bare-repo.sh myproject git@github.com:org/repo.git` |
| Create empty repo | `$SKILL/scripts/init-bare-repo.sh myproject` |
| Convert existing bare clone | `$SKILL/scripts/convert-bare-repo.sh /path/to/repo.git` |
| Migrate old .bare/ layout | `$SKILL/scripts/migrate-to-git.sh` |
| Add worktree | `$SKILL/scripts/add-worktree.sh feature-name` |
| Add worktree from base | `$SKILL/scripts/add-worktree.sh feature-name main` |
| List worktrees | `$SKILL/scripts/list-worktrees.sh` |
| Remove worktree | `$SKILL/scripts/remove-worktree.sh feature-name` |
| Remove + delete branch | `$SKILL/scripts/remove-worktree.sh feature-name -d` |
| Checkout PR for review | `$SKILL/scripts/checkout-pr.sh 123` |
| Checkout PR merged state | `$SKILL/scripts/checkout-pr.sh 123 --merged` |
| Sync all remotes | `$SKILL/scripts/sync.sh` |
| Cleanup stale refs | `$SKILL/scripts/cleanup.sh` |

## Scripts

All scripts are in `scripts/` subdirectory and auto-detect the bare repo from any location within the project.

### scripts/init-bare-repo.sh

Initialize or clone a repository into worktree-friendly structure. Automatically detects whether you're cloning from a URL or creating a new repo.

```bash
# Clone with auto-derived name (creates 'repo/' directory)
$SKILL/scripts/init-bare-repo.sh git@github.com:org/repo.git

# Clone with custom name (URL detected automatically)
$SKILL/scripts/init-bare-repo.sh git@github.com:org/repo.git myproject

# Clone with explicit name (traditional syntax)
$SKILL/scripts/init-bare-repo.sh myproject git@github.com:org/repo.git

# Create new empty repo
$SKILL/scripts/init-bare-repo.sh myproject
```

### scripts/convert-bare-repo.sh

Convert an existing `git clone --bare` repository to worktree layout.

```bash
# Convert from inside the bare repo
cd /path/to/repo.git
$SKILL/scripts/convert-bare-repo.sh

# Or specify the path
$SKILL/scripts/convert-bare-repo.sh /path/to/repo.git
```

This is useful when you've already cloned with `git clone --bare` and want to adopt the worktree workflow.

### scripts/migrate-to-git.sh

Migrate an existing project from the old `.bare/` layout to the current `.git/` layout. Renames `.bare/` to `.git/` and updates all worktree references.

```bash
# From the project root
$SKILL/scripts/migrate-to-git.sh

# Or specify the path
$SKILL/scripts/migrate-to-git.sh /path/to/project
```

### scripts/add-worktree.sh

Add worktree for new or existing branch. Automatically sets up remote tracking.

```bash
# Create new branch from main (tracks origin/feature-auth)
$SKILL/scripts/add-worktree.sh feature-auth

# Create from specific base
$SKILL/scripts/add-worktree.sh hotfix-login main

# Checkout existing remote branch (tracks origin/existing-feature)
$SKILL/scripts/add-worktree.sh existing-feature
```

### scripts/remove-worktree.sh

Remove worktree, optionally deleting the branch.

```bash
# Remove worktree only (keeps branch)
$SKILL/scripts/remove-worktree.sh feature-auth

# Remove worktree and delete branch
$SKILL/scripts/remove-worktree.sh feature-auth -d
```

### scripts/checkout-pr.sh

Fetch GitHub PR into worktree for review. Requires `gh` CLI.

```bash
# Checkout PR branch
$SKILL/scripts/checkout-pr.sh 456
# Creates pr-456/ worktree

# Checkout merged state (what happens after merge)
$SKILL/scripts/checkout-pr.sh 456 --merged
# Creates pr-456-merged/ worktree
# This is what CI tests against - catches conflicts with recent base changes
# Fails with helpful error if PR has merge conflicts
```

### scripts/cleanup.sh

Prune stale references and remove gone branches.

```bash
# Preview changes
$SKILL/scripts/cleanup.sh --dry-run

# Execute cleanup
$SKILL/scripts/cleanup.sh
```

## Workflows

### Feature Development

```bash
# Start new feature (tracking auto-configured)
$SKILL/scripts/add-worktree.sh feature-auth
cd ../feature-auth
# ... work on feature ...
git push  # tracking already set up

# Switch to another task without stashing
cd ../main
$SKILL/scripts/add-worktree.sh hotfix-urgent
```

### Code Review

```bash
# Review a PR
$SKILL/scripts/checkout-pr.sh 123
cd ../pr-123
# ... review, test, comment ...

# Clean up after merge
$SKILL/scripts/remove-worktree.sh pr-123 -d
```
