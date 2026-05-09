## Worker Delegation Tools for Codex

Three CLI tools delegate bulk I/O to a worker model. Use them to save tokens.

### Complete context
Use these tools whenever they help build a complete picture. Ask the worker to inspect as many relevant files, transcripts, docs, or logs as needed before making changes, then use the worker's summary as supporting context for your own judgment.

### ask-worker - bulk reading
For reading files >400 lines, or when you'd otherwise read 3+ files:

```bash
ask-worker --paths <file1> <file2>... --question "<specific question>"
```

Returns a structured summary. Use that instead of reading files yourself.
Only read files directly when you need to make edits to specific lines.

### worker-write - boilerplate generation
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

### When not to delegate
- Tasks under ~2000 tokens of work
- Architecture decisions, debugging, or safety-critical code
- Anything requiring careful reasoning
- Cases where exact line-level edits are needed immediately
