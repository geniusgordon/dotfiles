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

## Background work

Use `bg_run` for any command longer than about 30 seconds.

## Delegation

Set `maxTurns` on each `bg_delegate` call. The default is 24, and the child aborts
mid-call at that limit. The abort loses the whole report.

- Set `maxTurns: 40` for a survey with more than 3 questions.
- Split a survey with more than 6 questions into two delegates.
- Raise `maxToolCalls` to 200 together with `maxTurns: 40`, because each search
  costs one turn and one tool call.

Read the terminal reason from `child-terminal.json` in the artifact directory. The
`.output` file holds the abort line only, so it does not name the cause.
