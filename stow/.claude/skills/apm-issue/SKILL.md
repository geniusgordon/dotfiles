---
name: apm-issue
description: Read error logs from Elastic APM/Kibana, triage by priority, and create GitHub issues. Use when the user wants to check APM errors, identify what's breaking in production, review recent error logs, triage incidents, or create GitHub issues from APM errors. Trigger on phrases like "check errors", "what's breaking", "APM errors", "Kibana errors", "create issue from errors", "triage prod errors", "check last 24h errors".
---

# APM Error Triage → GitHub Issue

You have access to a local Kibana/APM instance (port-forwarded from k8s) and `gh` CLI for GitHub.

## Setup

- **Kibana**: `http://localhost:5601` — no auth needed via port-forward
- **Header required**: `-H "kbn-xsrf: true"` on all Kibana API calls
- **GitHub**: `gh issue create` — already configured

## Step 1: Determine scope

Ask (or infer from context):
- **Services**: which APM service(s) to check, or all of them?
- **Time window**: default `now-24h` to `now`; user may say "last week", "last hour", etc.
- **Environment**: default `prod`; could be `staging`

If the user says "check errors" with no further detail, default to **all services, last 24h, prod**.

To list available services:
```
GET http://localhost:5601/internal/apm/services?environment=ENVIRONMENT_ALL&kuery=&start=START&end=END
```
Use ISO8601 timestamps (e.g. `2026-03-14T00:00:00.000Z`). On macOS: `date -u -v-24H '+%Y-%m-%dT%H:%M:%S.000Z'`.

## Step 2: Fetch error groups

For each relevant service:
```
GET http://localhost:5601/internal/apm/services/{serviceName}/errors?environment=prod&kuery=&start=START&end=END
```

Response shape:
```json
{
  "errorGroups": [
    {
      "message": "ER_DUP_ENTRY: Duplicate entry ...",
      "occurrenceCount": 185,
      "culprit": "Query.<anonymous> (node_modules/.../MysqlQueryRunner.ts)",
      "groupId": "c17431d1e5c1f8bd10fc3edda27fc7cf",
      "latestOccurrenceAt": "2026-03-14T18:25:09.786Z",
      "handled": true,
      "type": "QueryFailedError"
    }
  ]
}
```

## Step 3: Assign priority

| Priority | Condition |
|----------|-----------|
| **P1 — Critical** | `handled: false` (unhandled exception, any count) |
| **P2 — High** | `occurrenceCount >= 50` |
| **P3 — Medium** | `10 ≤ occurrenceCount < 50` |
| **P4 — Low** | `occurrenceCount < 10` |

When both conditions match (unhandled + high frequency), use P1.

## Step 4: Filter noise

Skip errors that are clearly expected business logic and not worth filing:
- Spam detection errors: messages containing `contains spam`
- User-not-found type errors that are clearly user-triggered: `ShowNotFound`, `EpisodeNotFound`, etc. with very low count
- Auth errors caused by users: `invalid_grant`, OAuth token expiry

**Always include** TypeErrors, unhandled exceptions, database errors (`QueryFailedError`, `ER_*`), connection errors (`ECONNREFUSED`), and anything unhandled.

Use judgment — if in doubt, include it and let the user decide.

## Step 5: Present summary to user

Before creating any GitHub issue, display a triage table:

```
Service: firstory-hosting-server (last 24h, prod)

P1 — Critical (unhandled)
  None

P2 — High (≥50 occurrences)
  [1] QueryFailedError: ER_DUP_ENTRY: Duplicate entry '...' for key ...
      185 occurrences | culprit: MysqlQueryRunner.ts | last: 18:25 UTC

P3 — Medium (10–49 occurrences)
  [2] Error: invalid_grant
      82 occurrences | culprit: google.strategy.ts | last: 18:33 UTC
  ...

P4 — Low (<10 occurrences)
  ...

Skipped (noise): 3 errors (spam detection, user-not-found)
```

Then ask: **"Which errors should I create GitHub issues for? (e.g. 1,2 or 'all P1+P2' or 'all')"**

## Step 6: Get error details (optional, for issue body)

If the user wants richer issues, fetch details for the selected error groups:
```
GET http://localhost:5601/internal/apm/services/{serviceName}/errors/{groupId}?environment=prod&kuery=&start=START&end=END
```

This returns transaction context including HTTP method, URL path, service node name, and stack info embedded in the transaction.

## Service → GitHub Repo Mapping

Read the mapping from `~/.claude/skills/apm-issue/config.json` using the Read tool:

```json
{
  "service_repo_map": {
    "<service-name>": "<GitHub OWNER/REPO>"
  }
}
```

If the file doesn't exist, tell the user:
```
cp ~/.claude/skills/apm-issue/config.example.json ~/.claude/skills/apm-issue/config.json
# then fill in your service → repo mapping
```

If a service isn't in the mapping, ask the user.

## Step 7: Create GitHub issue(s)

For each selected error, look up the repo from the mapping above. Then:

```bash
gh issue create \
  --repo OWNER/REPO \
  --title "[APM] {serviceName}: {errorType} — {short message}" \
  --label "bug" \
  --body "$(cat <<'EOF'
## Error Details

| Field | Value |
|-------|-------|
| **Service** | {serviceName} |
| **Priority** | P{N} — {label} |
| **Error Type** | {type} |
| **Occurrences** | {count} (last 24h, prod) |
| **Latest** | {latestOccurrenceAt} |
| **Culprit** | {culprit} |

## Message

```
{message}
```

## APM Link

http://localhost:5601/kibana/app/apm/services/{serviceName}/errors/{groupId}

## Steps to Investigate

- [ ] Check APM error group for stack trace and transaction context
- [ ] Review culprit file: `{culprit}`
- [ ] Check if related to recent deploys
- [ ] Determine user impact
EOF
)"
```

Shorten titles if the message is very long — aim for under 80 characters for the title.

## Tips

- When checking multiple services, fetch all of them before presenting to avoid back-and-forth
- If Kibana is unreachable, tell the user to run: `kubectl port-forward svc/kibana-kibana -n logging 5601:5601`
- Unhandled errors in Node.js (`handled: false`) usually mean uncaught exceptions that may have crashed a worker — always treat as P1
- For workers (hosting-worker, audio-worker), even P3 errors can be significant since they represent failed background jobs
