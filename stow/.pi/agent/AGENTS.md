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
