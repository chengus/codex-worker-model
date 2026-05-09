# Codex Worker Model

Offload bulk I/O from Codex to an inexpensive worker model. The worker reads large files, drafts repetitive code, and extracts transcript context while Codex stays focused on planning, review, and final edits.

This local setup defaults to DeepSeek V4 Flash through DeepSeek's OpenAI-compatible API.

## Quick Start

```bash
git clone https://github.com/imkunal007219/claude-coworker-model.git
cd claude-coworker-model
./setup.sh

export WORKER_API_KEY="$DEEPSEEK_API_KEY"
export WORKER_BASE_URL="https://api.deepseek.com"
export WORKER_MODEL="deepseek-v4-flash"

ask-worker --paths src/*.py --question "Find all SQL injection risks"
```

## Configuration

Three environment variables configure the worker model:

| Variable | Purpose | DeepSeek V4 Flash value |
|----------|---------|-------------------------|
| `WORKER_API_KEY` | API authentication | `$DEEPSEEK_API_KEY` |
| `WORKER_BASE_URL` | Provider endpoint | `https://api.deepseek.com` |
| `WORKER_MODEL` | Model identifier | `deepseek-v4-flash` |

You can source the included example:

```bash
source .env.example
```

Set `DEEPSEEK_API_KEY` or replace `WORKER_API_KEY` with your DeepSeek API key first.

## Codex Setup

This repo includes `AGENTS.md` and `AGENTS.md.template`.

For another Codex project, copy `AGENTS.md.template` into that project as `AGENTS.md`. Codex reads `AGENTS.md` automatically and can use the worker-routing rules there.

## Tools

### ask-worker

Delegate bulk reading to the worker model. It returns structured bullets rather than long prose.

```bash
ask-worker \
  --paths auth.py database.py utils.py \
  --question "Identify all unvalidated inputs" \
  --max-tokens 8192
```

Flags:

- `--paths`: files to ingest
- `--question`: extraction query
- `--max-tokens`: output budget
- `--model`: override `WORKER_MODEL`

### worker-write

Generate boilerplate code or documentation using an optional reference file for style.

```bash
worker-write \
  --spec "Write pytest tests for auth.py covering OAuth2 flow" \
  --context tests/test_main.py \
  --target tests/test_auth.py
```

Flags:

- `--spec`: what to write
- `--context`: optional reference file to mimic
- `--target`: output file path
- `--max-tokens`: output budget

### extract-chat

Convert Codex JSONL session logs to readable text.

```bash
extract-chat session.jsonl -o /tmp/chat.txt
ask-worker --paths /tmp/chat.txt docs/README.md --question "What doc updates are needed?"
```

## Provider Notes

The worker scripts use the OpenAI Python SDK and should work with any OpenAI-compatible provider by changing `WORKER_BASE_URL` and `WORKER_MODEL`.

DeepSeek's current pricing docs list `deepseek-v4-flash` and `deepseek-v4-pro`, with `deepseek-chat` and `deepseek-reasoner` retained only as compatibility names.

## Original Project

This setup is adapted from `imkunal007219/claude-coworker-model`, renamed locally for generic Codex worker usage.
