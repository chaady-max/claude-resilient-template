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

# Try to copy CLAUDE_PROTOCOL.md to clipboard (macOS/Linux)
if command -v pbcopy >/dev/null 2>&1; then
    cat CLAUDE_PROTOCOL.md | pbcopy
    echo "✓ CLAUDE_PROTOCOL.md copied to clipboard!"
    echo ""
    echo "When Claude starts:"
    echo "  1. Press Cmd+V (or Ctrl+V) to paste the protocol"
    echo "  2. Press Enter"
    echo "  3. Claude will read TASK.md and begin working"
    echo ""
elif command -v xclip >/dev/null 2>&1; then
    cat CLAUDE_PROTOCOL.md | xclip -selection clipboard
    echo "✓ CLAUDE_PROTOCOL.md copied to clipboard!"
    echo ""
    echo "When Claude starts:"
    echo "  1. Press Ctrl+V to paste the protocol"
    echo "  2. Press Enter"
    echo "  3. Claude will read TASK.md and begin working"
    echo ""
else
    echo "⚠️  Could not copy to clipboard automatically."
    echo ""
    echo "Please manually copy CLAUDE_PROTOCOL.md contents and paste into Claude."
    echo ""
fi

echo "Starting Claude Code in 3 seconds..."
echo "Press Ctrl+C to cancel"
echo ""
sleep 3

# Start Claude normally (interactive mode)
claude

echo ""
echo "=== Claude session ended ==="
echo ""
echo "To resume work, run this script again:"
echo "  $ ./tools/launch-claude.sh"
echo ""
