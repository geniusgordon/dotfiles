---
name: clickup-prd
description: >
  Syncs ClickUp tasks to local PRD files. Use this skill whenever the user wants to:
  pull tasks from ClickUp, check which tasks need PRDs, create PRD documents from ClickUp tasks,
  sync ClickUp to PRDs, generate PRDs for assigned tasks, or check task status from ClickUp.
  Trigger on phrases like "get my tasks", "create PRDs", "sync clickup", "what tasks need PRDs",
  "pull from clickup", or any mention of ClickUp + PRD together.
---

# ClickUp PRD Sync

Fetch tasks from a ClickUp list assigned to the current user and create local PRD files for tasks
that don't have one yet and aren't already in a terminal state.

## Configuration

| Setting | Value |
|---|---|
| Auth | `CLICKUP_API_TOKEN` env var — personal token starting with `pk_`, generate at ClickUp Settings → Apps |
| List ID | `CLICKUP_LIST_ID` env var |
| PRD directory | `CLICKUP_PRD_DIR` env var |

**If any required env var is not set**, stop immediately and tell the user which ones are missing:
```
export CLICKUP_API_TOKEN=pk_xxxxxxxx
export CLICKUP_LIST_ID=900xxxxxxxxx
export CLICKUP_PRD_DIR=~/path/to/prd
```
Then re-run once they've set them.

## Steps

Run the sync script — it handles all API calls, pagination, deduplication, and file creation:

```bash
python3 ~/.claude/skills/clickup-prd/clickup_prd.py
```

Options:
- `--dry-run` — preview what would be created without writing files
- `--list-id <id>` — override the default list ID
- `--prd-dir <path>` — override the PRD output directory

The script outputs a summary report when done. Show it to the user as-is.

## After the script runs

For any **newly created** PRD files, open each one and:
- Read the ClickUp task description carefully
- Synthesize **TL;DR**, **Problem Statement**, and **Proposed Solution** from the description —
  don't paste verbatim, rewrite so a new Claude session can immediately understand the task
- Guess affected Firstory repos from context (firstory-backend, firstory-web, firstory-app,
  firstory-studio, firstory-rocket, firstory-falcon) and remove irrelevant rows from the table
- Leave sections as `_TODO_` only when there's genuinely no source material

## Troubleshooting

- **CLICKUP_API_TOKEN not set**: tell the user `export CLICKUP_API_TOKEN=pk_xxxxxxxx`
- **Script not found**: it lives at `~/.claude/skills/clickup-prd/clickup_prd.py`
- **JSON errors from raw curl**: always use the script — it uses `strict=False` to handle
  ClickUp's invalid control characters in description fields
