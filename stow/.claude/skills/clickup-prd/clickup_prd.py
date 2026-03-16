#!/usr/bin/env python3
"""
ClickUp PRD Sync — fetch tasks assigned to me and create local PRD files.

Usage:
    python3 scripts/clickup_prd.py
    python3 scripts/clickup_prd.py --dry-run
    python3 scripts/clickup_prd.py --list-id 900901180015
    python3 scripts/clickup_prd.py --prd-dir ~/path/to/prd

Requires env vars:
    CLICKUP_API_TOKEN  — personal token starting with pk_
    CLICKUP_LIST_ID    — ClickUp list ID to fetch tasks from
    CLICKUP_PRD_DIR    — local directory to write PRD files into
"""

import argparse
import json
import os
import re
import sys
import urllib.request
from datetime import date
from pathlib import Path


LIST_ID = os.environ.get("CLICKUP_LIST_ID", "")
PRD_DIR = Path(os.environ.get("CLICKUP_PRD_DIR", "~/prd")).expanduser()
ACTIVE_STATUSES = ["open", "ready for dev"]


# ---------------------------------------------------------------------------
# API helpers
# ---------------------------------------------------------------------------

def api_get(path: str, token: str) -> dict:
    url = f"https://api.clickup.com/api/v2{path}"
    req = urllib.request.Request(url, headers={"Authorization": token})
    with urllib.request.urlopen(req) as resp:
        raw = resp.read().decode("utf-8")
    # strict=False: ClickUp descriptions often contain raw control characters
    return json.loads(raw, strict=False)


def get_current_user(token: str) -> tuple[int, str]:
    data = api_get("/user", token)
    user = data["user"]
    return user["id"], user["username"]


def fetch_assigned_tasks(token: str, list_id: str, user_id: int) -> list[dict]:
    """Paginate through tasks assigned to user_id with active statuses in list_id."""
    status_params = "".join(f"&statuses[]={s.replace(' ', '%20')}" for s in ACTIVE_STATUSES)
    tasks = []
    page = 0
    while True:
        path = (
            f"/list/{list_id}/task"
            f"?page={page}&subtasks=true"
            f"&assignees[]={user_id}"
            f"{status_params}"
        )
        data = api_get(path, token)
        batch = data.get("tasks", [])
        tasks.extend(batch)
        if data.get("last_page", False) or len(batch) < 100:
            break
        page += 1
    return tasks


# ---------------------------------------------------------------------------
# Slug + file helpers
# ---------------------------------------------------------------------------

def slugify(name: str) -> str:
    """Lowercase, replace non-alphanumeric with hyphens, collapse, strip."""
    slug = name.lower()
    slug = re.sub(r"[^a-z0-9]+", "-", slug)
    slug = slug.strip("-")
    return slug or "task"


def find_existing_prd(prd_dir: Path, task_id: str) -> Path | None:
    """Return the first .md file in prd_dir whose name contains the task ID."""
    for f in prd_dir.glob("*.md"):
        if task_id in f.name:
            return f
    return None


# ---------------------------------------------------------------------------
# PRD template
# ---------------------------------------------------------------------------

def render_prd(task: dict, today: str) -> str:
    name = task["name"]
    task_id = task["id"]
    url = task["url"]
    status = task["status"]["status"]
    desc = (task.get("description") or "").strip()

    # Guess affected systems from name/description keywords
    text = f"{name} {desc}".lower()
    systems = []
    if any(k in text for k in ["backend", "api", "後端", "apple subscription", "ezpay", "invoice", "發票", "出帳", "download", "下載"]):
        systems.append(("firstory-backend", "後端 API 邏輯"))
    if any(k in text for k in ["studio", "前端", "web", "frontend"]):
        systems.append(("firstory-web / firstory-studio", "前端介面"))
    if any(k in text for k in ["ios", "app", "react native", "mobile"]):
        systems.append(("firstory-app", "行動 App"))
    if any(k in text for k in ["rocket", "membership", "payment", "訂閱", "會員", "付款"]):
        systems.append(("firstory-rocket", "訂閱制 / 付款"))
    if not systems:
        systems = [("firstory-backend", "_TODO_"), ("firstory-web", "_TODO_")]

    systems_table = "\n".join(f"| `{s}` | {r} |" for s, r in systems)

    # Synthesise sections from description when available
    if desc:
        background = f"從 ClickUp 描述整理：\n\n{desc[:800]}"
        problem = "_TODO: 根據背景補充具體問題描述。_"
        solution = "_TODO: 根據描述定義解決方案。_"
    else:
        background = "_TODO: Add background context._"
        problem = "_TODO: Describe the specific problem._"
        solution = "_TODO: Define approach._"

    return f"""# PRD: {name}

> **Status**: {status} | **ClickUp**: [{task_id}]({url}) | **Created**: {today}

---

## TL;DR

_TODO: One paragraph — what this is, why it matters, what "done" looks like._

## Background & Context

{background}

## Problem Statement

{problem}

## Goals

- _TODO: Concrete, testable goal_

## Non-Goals

- _TODO: What this explicitly does NOT cover_

## Affected Systems

| System | Role |
|---|---|
{systems_table}

## Proposed Solution

{solution}

### Key Design Decisions

- **Decision**: _TODO_
  - Rationale: _TODO_

## Acceptance Criteria

- [ ] _TODO: Specific, testable condition_

## Open Questions

- [ ] _TODO: Question that needs answering before or during implementation_

## References

- [ClickUp Task]({url})
"""


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description="Sync ClickUp tasks to local PRD files.")
    parser.add_argument("--list-id", default=LIST_ID, help="ClickUp list ID")
    parser.add_argument("--prd-dir", default=str(PRD_DIR), help="Local PRD directory")
    parser.add_argument("--dry-run", action="store_true", help="Print actions without writing files")
    args = parser.parse_args()

    missing = []
    if not os.environ.get("CLICKUP_API_TOKEN"):
        missing.append("CLICKUP_API_TOKEN=pk_xxxxxxxx")
    if not args.list_id:
        missing.append("CLICKUP_LIST_ID=900xxxxxxxxx")
    if not os.environ.get("CLICKUP_PRD_DIR") and args.prd_dir == str(PRD_DIR):
        missing.append("CLICKUP_PRD_DIR=~/path/to/prd")
    if missing:
        print("Error: required env vars are not set:")
        for m in missing:
            print(f"  export {m}")
        sys.exit(1)

    token = os.environ.get("CLICKUP_API_TOKEN", "")

    prd_dir = Path(args.prd_dir).expanduser()
    prd_dir.mkdir(parents=True, exist_ok=True)
    today = date.today().strftime("%Y%m%d")

    # Step 1: identify user
    user_id, username = get_current_user(token)
    print(f"Logged in as: {username} (id={user_id})")

    # Step 2: fetch tasks (API-filtered to active statuses)
    statuses_label = " / ".join(ACTIVE_STATUSES)
    print(f"Fetching tasks ({statuses_label}) from list {args.list_id}...", end=" ", flush=True)
    active = fetch_assigned_tasks(token, args.list_id, user_id)
    print(f"{len(active)} found")

    print(f"\n✓ Found {len(active)} active tasks")

    # Step 4 & 5: check existing PRDs, create new ones
    already_exists = []
    created = []
    errors = []

    for task in active:
        slug = slugify(task["name"])  # noqa: F841 (used in filename)
        existing = find_existing_prd(prd_dir, task["id"])

        if existing:
            already_exists.append((task, existing))
            continue

        filename = f"{today}-{slug}-{task['id']}.md"
        filepath = prd_dir / filename
        content = render_prd(task, date.today().strftime("%Y-%m-%d"))

        if args.dry_run:
            print(f"  [dry-run] Would create: {filepath.name}")
            created.append((task, filepath))
        else:
            try:
                filepath.write_text(content, encoding="utf-8")
                created.append((task, filepath))
            except OSError as e:
                errors.append((task, str(e)))

    # Step 6: report
    print()
    if already_exists:
        print(f"✓ {len(already_exists)} tasks already have PRDs (skipped):")
        for task, path in already_exists:
            print(f"  - {path.name}  \"{task['name']}\"")

    if created:
        label = "[dry-run] Would create" if args.dry_run else "Created"
        print(f"\n✓ {label} {len(created)} new PRDs:")
        for task, path in created:
            print(f"  - {path}  \"{task['name']}\"  (status: {task['status']['status']})")

    if errors:
        print(f"\n✗ {len(errors)} errors:")
        for task, msg in errors:
            print(f"  - \"{task['name']}\": {msg}")

    if not created and not already_exists:
        print("Nothing to do — no active tasks found.")


if __name__ == "__main__":
    main()
