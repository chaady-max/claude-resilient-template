#!/bin/bash
# launch-claude.sh - Launch Claude with CLAUDE_PROTOCOL.md automatically loaded
# Use this script anytime you want to start/resume working with Claude

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

echo "=== Launching Claude Code ==="
echo ""

# Check if TASK.md exists
if [ ! -f "TASK.md" ]; then
    echo "❌ ERROR: TASK.md not found!"
    echo ""
    echo "This project has not been initialized yet."
    echo "Please run the bootstrap script first:"
    echo "  $ ./start.sh"
    echo ""
    exit 1
fi

# Check if CLAUDE_PROTOCOL.md exists
if [ ! -f "CLAUDE_PROTOCOL.md" ]; then
    echo "❌ ERROR: CLAUDE_PROTOCOL.md not found!"
    echo ""
    echo "This file is required for Claude to operate."
    echo "Please ensure you're in a Claude-Resilient project."
    echo ""
    exit 1
fi

echo "✓ TASK.md found"
echo "✓ CLAUDE_PROTOCOL.md found"
echo ""
echo "Starting Claude with protocol loaded..."
echo ""
echo "Claude will:"
echo "  1. Read CLAUDE_PROTOCOL.md"
echo "  2. Read TASK.md"
echo "  3. Read claude.md (if exists)"
echo "  4. Begin working on the next action"
echo ""
echo "Press Ctrl+C to exit Claude at any time."
echo ""
sleep 2

# Start Claude with CLAUDE_PROTOCOL.md piped in
cat CLAUDE_PROTOCOL.md | claude

echo ""
echo "=== Claude session ended ==="
echo ""
echo "To resume work, run this script again:"
echo "  $ ./tools/launch-claude.sh"
echo ""
