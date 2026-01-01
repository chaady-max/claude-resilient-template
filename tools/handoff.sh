#!/bin/bash
# handoff.sh - Capture current project state for task handoff
# This script collects all relevant state information and appends it to TASK.md
# Run this before ending a session or when state needs to be captured

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

echo "=== Capturing Project State ==="
echo ""

# Check if this is a git repository
if [ ! -d ".git" ]; then
    echo "ERROR: Not a git repository. Initialize with 'git init' first."
    exit 1
fi

# Create temporary state file
STATE_FILE="STATE.raw.md"

{
    echo "# Project State Capture"
    echo "Generated: $(date '+%Y-%m-%d %H:%M:%S')"
    echo ""

    echo "## Git Status"
    echo '```'
    git status
    echo '```'
    echo ""

    echo "## Current Branch"
    echo '```'
    git branch --show-current
    echo '```'
    echo ""

    echo "## HEAD Commit"
    echo '```'
    git log -1 --oneline
    echo '```'
    echo ""

    echo "## Recent Commits (Last 5)"
    echo '```'
    git log -5 --oneline --decorate
    echo '```'
    echo ""

    echo "## Staged Changes"
    if git diff --cached --quiet; then
        echo "No staged changes."
    else
        echo '```diff'
        git diff --cached
        echo '```'
    fi
    echo ""

    echo "## Unstaged Changes"
    if git diff --quiet; then
        echo "No unstaged changes."
    else
        echo '```diff'
        git diff
        echo '```'
    fi
    echo ""

    echo "## Untracked Files"
    UNTRACKED=$(git ls-files --others --exclude-standard)
    if [ -z "$UNTRACKED" ]; then
        echo "No untracked files."
    else
        echo '```'
        echo "$UNTRACKED"
        echo '```'
    fi
    echo ""

    echo "## TODO/FIXME Markers"
    TODO_RESULTS=$(grep -rn --include="*.js" --include="*.ts" --include="*.jsx" --include="*.tsx" --include="*.py" --include="*.go" --include="*.java" --include="*.rb" --include="*.php" --include="*.c" --include="*.cpp" --include="*.h" --include="*.sh" -E "TODO|FIXME" . 2>/dev/null || true)

    if [ -z "$TODO_RESULTS" ]; then
        echo "No TODO/FIXME markers found."
    else
        echo '```'
        echo "$TODO_RESULTS"
        echo '```'
    fi
    echo ""

    echo "## Files Changed (vs origin/main or origin/master)"
    MAIN_BRANCH=$(git remote show origin 2>/dev/null | grep "HEAD branch" | cut -d' ' -f5 || echo "main")
    if git rev-parse "origin/$MAIN_BRANCH" >/dev/null 2>&1; then
        echo '```'
        git diff --name-status "origin/$MAIN_BRANCH"...HEAD
        echo '```'
    else
        echo "No remote branch found. Showing all tracked files:"
        echo '```'
        git ls-files
        echo '```'
    fi
    echo ""

} > "$STATE_FILE"

echo "State captured to: $STATE_FILE"
echo ""

# Optionally append relevant parts to TASK.md
if [ -f "TASK.md" ]; then
    echo "Would you like to append this state to TASK.md? (y/n)"
    read -r RESPONSE
    if [ "$RESPONSE" = "y" ] || [ "$RESPONSE" = "Y" ]; then
        echo "" >> TASK.md
        echo "---" >> TASK.md
        echo "" >> TASK.md
        echo "## Auto-Captured State ($(date '+%Y-%m-%d %H:%M:%S'))" >> TASK.md
        cat "$STATE_FILE" >> TASK.md
        echo "State appended to TASK.md"
    fi
else
    echo "WARNING: TASK.md not found. State only saved to $STATE_FILE"
fi

echo ""
echo "=== State Capture Complete ==="
