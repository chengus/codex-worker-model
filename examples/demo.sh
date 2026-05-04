#!/usr/bin/env bash
# Quick demo — run after setup.sh

echo "=== ask-kimi: Bulk Reading ==="
echo "Reading this repo's own tools and summarizing..."
ask-kimi \
  --paths tools/ask-kimi tools/kimi-write tools/extract-chat \
  --question "What does each tool do? List with one-sentence descriptions."

echo ""
echo "=== kimi-write: Boilerplate Generation ==="
echo "Generating a test file based on ask-kimi's style..."
kimi-write \
  --spec "Write a simple pytest test that verifies ask-kimi can be imported and has a main function" \
  --context tools/ask-kimi \
  --target /tmp/test_ask_kimi.py

echo ""
cat /tmp/test_ask_kimi.py
