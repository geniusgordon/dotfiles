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

Pick the tool by the work:

1. Use `bg_run` for a shell command longer than about 30 seconds.
2. Use `bg_delegate` for one read-only question that needs this conversation as context.
3. Use a `subagent` worker for any child that edits a file.
4. Use a `subagent` workflow for many children, a review loop, or a gate.
5. Use `fusion_reason` for a judgment call that the repository cannot answer.

### Delegate without being asked

Start a subagent on these triggers. Do not wait for the word "subagent".

1. An external fact, an API contract, or a library version decides the work.
   Run `researcher` first.
2. The task touches code you have not read in this session.
   Run `scout` first, then plan from its report.
3. You finished an implementation.
   Run `reviewer` with fresh context before you summarize.
4. The decision is hard to reverse, such as a schema change or a public API.
   Run `oracle` before you edit.
5. Three or more independent read-only questions exist.
   Run one `subagent` workflow with parallel children.

Do not delegate a single file read, a one-line edit, or a command you can run now.
A subagent costs about 30 seconds of setup, so direct work wins below that.
Name the trigger in one line when you start a subagent.

### Keep implementation in the main session

Write the code in the main session. The user sees each edit and corrects it at once.
A `worker` child forks the conversation, so it never sees a later message.

Use `worker` only for these cases:

1. A written plan exists, the user approved it, and no decision is open. The plan
   is a file, an issue, a PRD, or an approved message in this session. Pass its
   path or its text to the child, because the child cannot see this session.
2. Three or more lanes are independent. Give each lane its own git worktree.
3. The task must read many files, and the main thread must stay clean.

Run one writer per directory. Two writers in one directory destroy each other's edits.

### bg_delegate limits

Set `maxTurns` on each `bg_delegate` call. The default is 24, and the child aborts
mid-call at that limit. The abort loses the whole report.

- Set `maxTurns: 40` for a survey with more than 3 questions.
- Split a survey with more than 6 questions into two delegates.
- Raise `maxToolCalls` to 200 together with `maxTurns: 40`, because each search
  costs one turn and one tool call.

Read the terminal reason from `child-terminal.json` in the artifact directory. The
`.output` file holds the abort line only, so it does not name the cause.
