#!/usr/bin/env bash
set -euo pipefail

# Claude Coworker Model — Setup Script
# Creates venv, installs deps, symlinks tools to ~/bin/

INSTALL_DIR="${HOME}/.local/share/claude-coworker"
BIN_DIR="${HOME}/.local/bin"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Claude Coworker Model Setup ==="
echo ""

# 1. Create venv
echo "[1/4] Creating Python venv at ${INSTALL_DIR}..."
mkdir -p "${INSTALL_DIR}"
python3 -m venv "${INSTALL_DIR}/venv"
source "${INSTALL_DIR}/venv/bin/activate"

# 2. Install deps
echo "[2/4] Installing dependencies..."
pip install --quiet --upgrade pip
pip install --quiet -r "${SCRIPT_DIR}/requirements.txt"

# 3. Symlink tools
echo "[3/4] Linking tools to ${BIN_DIR}..."
mkdir -p "${BIN_DIR}"
for tool in ask-kimi kimi-write extract-chat; do
    chmod +x "${SCRIPT_DIR}/tools/${tool}"
    ln -sf "${SCRIPT_DIR}/tools/${tool}" "${BIN_DIR}/${tool}"
    echo "  ✓ ${tool}"
done

# 4. Check API key
echo "[4/4] Checking environment..."
if [ -z "${WORKER_API_KEY:-}" ] && [ -z "${MOONSHOT_API_KEY:-}" ]; then
    echo ""
    echo "⚠  No API key found. Set one of these in your shell profile:"
    echo ""
    echo "  # Kimi (Moonshot AI)"
    echo "  export WORKER_API_KEY=\"your-key-here\""
    echo "  export WORKER_BASE_URL=\"https://api.moonshot.ai/v1\""
    echo "  export WORKER_MODEL=\"kimi-k2.5\""
    echo ""
    echo "  # OR DeepSeek"
    echo "  export WORKER_API_KEY=\"your-key-here\""
    echo "  export WORKER_BASE_URL=\"https://api.deepseek.com/v1\""
    echo "  export WORKER_MODEL=\"deepseek-chat\""
    echo ""
    echo "  # OR Ollama (local, free)"
    echo "  export WORKER_BASE_URL=\"http://localhost:11434/v1\""
    echo "  export WORKER_MODEL=\"qwen2.5:32b\""
    echo ""
else
    echo "  ✓ API key found"
fi

echo ""
echo "=== Done! ==="
echo ""
echo "Make sure ${BIN_DIR} is on your PATH, then try:"
echo "  ask-kimi --paths some_file.py --question 'what does this do?'"
echo ""
echo "Copy CLAUDE.md.template into your project's CLAUDE.md for auto-routing."
