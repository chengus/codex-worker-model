## Worker Delegation Tools for Codex

Use worker tools to save context on large, repetitive, or exploratory tasks. Worker output is supporting context only; Codex remains responsible for final reasoning, edits, and verification.

### Use ask-worker for reading
Use `ask-worker` when the task needs a broad or long-context read, including:
- Files over ~400 lines
- 3+ files that need summarizing or comparison
- Documentation, logs, transcripts, generated files, or unfamiliar repo mapping
- "Get the complete picture" tasks before planning changes

Ask focused questions and include all relevant paths. Prefer worker summaries before reading large files directly, then read exact files/lines yourself before editing.

### Use worker-write for boilerplate
Use `worker-write` for low-risk repetitive output, including:
- Test scaffolds
- Config examples
- Documentation drafts
- Simple wrappers, adapters, fixtures, or generated patterns

Always review and edit the result before treating it as final.

### Network access
The worker tools call the configured model API over the network. In Codex, run them with network approval/escalated permissions when the sandbox blocks outbound access. If a worker command reports that it cannot reach the API, rerun the same command with network approval before falling back.

### ask-worker command
For reading files >400 lines, or when you'd otherwise read 3+ files:

```bash
ask-worker --paths <file1> <file2>... --question "<specific question>"
```

Returns a structured summary. Use that instead of reading files yourself.
Only read files directly when you need to make edits to specific lines.

### worker-write command
For generating tests, config files, docstrings, or repetitive code patterns:

```bash
worker-write --spec "<what to write>" --context <existing-similar-file> --target <output-path>
```

Then review the output and edit only what needs fixing.

### extract-chat - chat transcript extraction
Extracts human-readable text from Codex JSONL transcripts:

```bash
extract-chat <session.jsonl> -o /tmp/chat.txt
```

### Documentation workflow
Delegate repetitive documentation work when the source context is large:

1. Extract chat: `extract-chat <latest-session.jsonl> -o /tmp/chat.txt`
2. Ask worker to read chat and existing docs:
   `ask-worker --paths /tmp/chat.txt <doc-files> --question "read chat, give exact changes for docs"`
3. Review the worker output, then apply only the correct changes.

### Do not delegate
Do not use worker tools for:
- Architecture decisions
- Debugging complex behavior
- Security-sensitive or destructive changes
- Exact line-level edits
- Final validation or test interpretation
