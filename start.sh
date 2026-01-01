#!/bin/bash
# start.sh - Bootstrap script for Claude-Resilient projects
# Run this after cloning the template to set up your new project

set -e

echo "=================================="
echo "Claude-Resilient Project Bootstrap"
echo "=================================="
echo ""

# Function to prompt user for yes/no
prompt_yes_no() {
    local prompt="$1"
    local default="${2:-n}"

    while true; do
        read -p "$prompt [y/n] (default: $default): " yn
        yn=${yn:-$default}
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer y or n.";;
        esac
    done
}

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "⚠️  Git repository not initialized"
    if prompt_yes_no "Initialize git repository?"; then
        git init
        echo "✓ Git initialized"
    fi
    echo ""
fi

# Install git hooks
if prompt_yes_no "Install git hooks (reminds you to update TASK.md)?"; then
    if [ -d ".git" ]; then
        cp git-hooks/pre-commit .git/hooks/ 2>/dev/null || true
        cp git-hooks/post-commit .git/hooks/ 2>/dev/null || true
        chmod +x .git/hooks/pre-commit .git/hooks/post-commit 2>/dev/null || true
        echo "✓ Git hooks installed"
    else
        echo "✗ Cannot install hooks: not a git repository"
    fi
    echo ""
fi

# Set up TASK.md
echo "Let's set up your TASK.md file"
echo ""

read -p "Project name: " project_name
project_name=${project_name:-"My Project"}

read -p "Project objective (what are you building?): " objective
objective=${objective:-"[Describe your project objective]"}

read -p "First action (what should Claude do first?): " first_action
first_action=${first_action:-"[Write your first action]"}

# Create TASK.md from template
cat > TASK.md <<EOF
# TASK - ${project_name}

## Objective

${objective}

---

## Current State

Project initialized from Claude-Resilient template. Ready to begin work.

---

## DONE

- [x] Created project from Claude-Resilient template
- [x] Ran bootstrap script (start.sh)

---

## OPEN

- [ ] [Add your tasks here]

---

## Next Action

${first_action}

---

## Notes

[Add any important context, constraints, or notes here]

---

## Blockers

None currently.

---

**Last Updated:** $(date '+%Y-%m-%d %H:%M:%S')

**Updated By:** Human (bootstrap script)
EOF

echo "✓ TASK.md created"
echo ""

# Optionally create PLAN.md
if prompt_yes_no "Create PLAN.md with project architecture?"; then
    read -p "Tech stack (e.g., 'Node.js, React, PostgreSQL'): " tech_stack
    tech_stack=${tech_stack:-"[Specify your tech stack]"}

    cat > PLAN.md <<EOF
# PLAN - ${project_name}

## Project Overview

${objective}

---

## Architecture

**Tech Stack:** ${tech_stack}

[Describe your architecture, components, and design decisions]

---

## Scope

### In Scope
- [List included features]

### Out of Scope
- [List excluded features]

---

## Constraints

[List any technical, business, or time constraints]

---

## Acceptance Criteria

- [ ] [Define what "done" means]

---

**Last Updated:** $(date '+%Y-%m-%d %H:%M:%S')
EOF

    echo "✓ PLAN.md created"
    echo ""
fi

# Create initial commit
if [ -d ".git" ]; then
    if prompt_yes_no "Create initial commit?"; then
        git add -A
        git commit -m "Initial project setup from Claude-Resilient template

Project: ${project_name}
Objective: ${objective}

Ready to begin work." || echo "Note: Commit may have failed (files might already be committed)"
        echo "✓ Initial commit created"
        echo ""
    fi
fi

# Display next steps
echo "=================================="
echo "✓ Bootstrap Complete!"
echo "=================================="
echo ""
echo "Next steps:"
echo ""
echo "1. Review and edit TASK.md if needed"
echo "2. Review and edit PLAN.md if needed"
echo "3. Start Claude Code:"
echo "   $ claude"
echo ""
echo "4. Paste the contents of CLAUDE_PROTOCOL.md into Claude"
echo ""
echo "5. Claude will read TASK.md and begin work"
echo ""
echo "Useful commands:"
echo "  ./tools/handoff.sh    - Capture current project state"
echo "  git status            - Check git status"
echo "  cat TASK.md           - View current tasks"
echo ""
echo "Documentation:"
echo "  README.md             - Full usage guide"
echo "  CLAUDE_PROTOCOL.md    - Execution protocol for Claude"
echo "  git-hooks/README.md   - Git hooks documentation"
echo ""
echo "Happy building! 🚀"
echo ""
