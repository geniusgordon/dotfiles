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
3. Use `crew` for any child that edits a file, and for a parallel read-only survey.
4. Use `crew` for a review loop or a gate. Open one member per role.
5. Use `fusion_reason` for a judgment call that the repository cannot answer.

`crew` needs `HERDR_ENV=1` and the Herdr pi integration. Install it once per
machine with `herdr integration install pi`, and reinstall it when
`herdr integration status` reports `outdated`. Without that integration Herdr
reports no session path, so `open` fails and `status` reads `unknown`.

Without Herdr, use `bg_delegate` for a read-only question and do the edit in the
main session.

### Delegate without being asked

Open a crew member on these triggers. Do not wait for the word "crew".

1. An external fact, an API contract, or a library version decides the work.
   Open a `researcher` member first.
2. The task touches code you have not read in this session.
   Open a `scout` member first, then plan from its report.
3. You finished an implementation.
   Open a `reviewer` member with fresh context before you summarize.
4. The decision is hard to reverse, such as a schema change or a public API.
   Open an `oracle` member before you edit.
5. Three or more independent read-only questions exist.
   Open one member per question, then run them in parallel.

Do not delegate a single file read, a one-line edit, or a command you can run now.
A member costs about 30 seconds of setup, so direct work wins below that.
Name the trigger in one line when you open a member.

### How to run a member

A member starts with an empty conversation and never sees this session. Restate
every needed fact in the `task` text, and pass a path as an absolute path.

1. `crew action=open member=<name> task="..."` for a read-only member.
2. `crew action=open member=<name> worktree=true task="..."` for a member that edits a file.
3. `crew action=ask member=<name> task="..."` to send a follow-up task.
4. `crew action=result member=<name> section="..."` to pull one section.
5. `crew action=close member=<name>` when the work is complete.

Pass `task` to `open`. It starts the member and sends the first task in one call.
`open` accepts every `ask` field: `task`, `task_id`, `context`, `inline`, `wait`,
and `timeout_ms`.

Use `ask` for a second or later task on an open member. The member keeps one
conversation, so a follow-up can name what the first task found. Omit `task_id`
to stay in the same task directory, or pass a new one when the topic changes.

Let `open` and `ask` use the default file protocol, then pull one section with
`result`. The file keeps a long answer out of this context. Pass `inline=true`
for a one-line answer only.

Pass a `task_id` when one member runs several tasks, because each `task_id` gets
its own directory.

Run members in parallel with `wait=false` on every `open` or `ask`, then one
`collect` per member. Call `collect` again when a wait reports that it ran out of
budget, because the member keeps working.

Trust `idle` and `done` from `crew action=status`. `unknown` does not prove that a
member finished. Use `crew action=trace`, not the terminal, when a member answers
badly. Use `crew action=keys` to answer a dialog that blocks a member.

### Keep implementation in the main session

Write the code in the main session. The user sees each edit and corrects it at once.
A writing member forks the work, so it never sees a later message.

Use a writing member only for these cases:

1. A written plan exists, the user approved it, and no decision is open. The plan
   is a file, an issue, a PRD, or an approved message in this session. Pass its
   path or its text to the member, because the member cannot see this session.
2. Three or more lanes are independent. Give each lane its own git worktree.
3. The task must read many files, and the main thread must stay clean.

Run one writer per directory. Two writers in one directory destroy each other's
edits, so pass `worktree=true` to every writing member.

### bg_delegate limits

Set `maxTurns` on each `bg_delegate` call. The default is 24, and the child aborts
mid-call at that limit. The abort loses the whole report.

- Set `maxTurns: 40` for a survey with more than 3 questions.
- Split a survey with more than 6 questions into two delegates.
- Raise `maxToolCalls` to 200 together with `maxTurns: 40`, because each search
  costs one turn and one tool call.

Read the terminal reason from `child-terminal.json` in the artifact directory. The
`.output` file holds the abort line only, so it does not name the cause.
