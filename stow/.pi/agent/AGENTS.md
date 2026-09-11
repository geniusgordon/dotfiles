# Pi rules

Shared rules live in ~/AGENTS.md. Pi concatenates both files, so do not repeat a topic.

## Search

Use the `grep`, `find`, and `ls` tools to explore. Do not use `bash` for discovery.
Bound each search with `path`, `glob`, and `limit`.
Find the file first. Then `read` it with `offset` and `limit`.
Use `bash grep` only for a path that `.gitignore` excludes, such as `dist` or `node_modules`.
Pipe such a command through `head -c 2000`, because a minified file holds one very long line.

## Reports

Report an exact path and an exact line number for each finding.
Report the command you ran and the result you saw. Do not report a guess as a fact.

## Delegation

Use the active tool descriptions as the source of truth.

1. Use `subagent` for delegated investigation, implementation, and review.
2. Use `bg_delegate` for one read-only question that needs the current conversation.
3. Use `fusion_reason` for a judgment call that the repository cannot answer.
4. Use `/skill:orchestrate` for a bounded multi-review fan-out.

Use public subagent tools only when the harness exposes them.
`subagent` requires `HERDR_ENV=1`.

### Delegate without being asked

Launch a subagent on these triggers:

1. An external contract decides the work. Launch a `scout` first.
2. A non-trivial task touches unread code. Launch a `scout` first.
3. An implementation is complete. Launch a fresh `reviewer`.
4. The task has independent parallel work. Launch one child per bounded outcome.

Do not delegate a single file read, a one-line edit, or a short command.

### Subagent contract

- Give each child one bounded outcome.
- Include the goal, allowed files, verification, and commit policy.
- Use an ordinary pane for read-only work.
- Restrict report-only children to safe inspection tools and commands.
- Do not run artifact-producing checks in a report-only checkout.
- Keep one sequential writer in the parent checkout.
- Give each parallel independent writer a unique managed worktree.
- Keep dependent or overlapping writers sequential.
- Treat children as leaves.
- Keep integration, verification, and cleanup in the parent.
- Let completion arrive automatically. Do not poll or collect results.

### Keep implementation in the main session

Write code in the main session when one writer is sufficient.
Use a `worker` only when delegation reduces risk or keeps the main context small.

For each worktree child:

- Set `cwd` to the source repository.
- Set a unique `worktree.branch`.
- Set `worktree.base` from that repository's required branch, tag, or commit.
- Omit `worktree.base` only when the committed `HEAD` is the correct base.
- Remember that uncommitted and untracked parent files are not copied.
- Ask the worker to commit and report its SHA.
- Keep these actions in the parent:
  - branch switching
  - push
  - PR creation
  - merge
  - cherry-pick
  - integration
  - worktree removal

### bg_delegate limits

Set `maxTurns` on each `bg_delegate` call. The default is 24, and the child aborts
mid-call at that limit. The abort loses the whole report.

- Set `maxTurns: 40` for a survey with more than 3 questions.
- Split a survey with more than 6 questions into two delegates.
- Raise `maxToolCalls` to 200 together with `maxTurns: 40`, because each search
  costs one turn and one tool call.

Read the terminal reason from `child-terminal.json` in the artifact directory. The
`.output` file holds the abort line only, so it does not name the cause.
