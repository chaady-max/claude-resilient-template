# Claude-Resilient Project Template

A GitHub template repository that enables **deterministic, resumable workflows** for Claude Code sessions.

---

## Purpose

This template solves a critical problem: **Claude sessions terminate unexpectedly** due to token limits, timeouts, or account switching. When this happens, context is lost and work must be restarted.

This template treats Claude as a **stateless worker** and externalizes all state into the repository, ensuring:

- ✅ **Zero context loss** when Claude sessions terminate
- ✅ **Seamless handoff** between different Claude accounts
- ✅ **Deterministic execution** with clear, enforced protocols
- ✅ **Full state visibility** through version-controlled files
- ✅ **No cloud dependencies** - everything is local

---

## How It Works

### Core Principle

> **The repository is the single source of truth.**
>
> Claude has no memory. Claude reads state from files, executes one step, updates files, and stops.

### Key Files

| File | Purpose | Modified By |
|------|---------|-------------|
| `TASK.md` | Single source of truth for execution state | Claude + Human |
| `PLAN.md` | High-level intent and architectural decisions | Human (mostly) |
| `claude.md` | Project-specific instructions for Claude | Human + Claude |
| `CLAUDE_PROTOCOL.md` | Mandatory execution protocol for Claude | Human (never changes) |
| `tools/launch-claude.sh` | Launch Claude with protocol auto-loaded | Human |
| `tools/handoff.sh` | Script to capture current state | Human |

---

## Quick Start

⚠️ **IMPORTANT: You MUST run `./start.sh` before using Claude!** ⚠️

### 1. Create New Project from Template

```bash
# On GitHub: Click "Use this template" → "Create a new repository"
# Or clone directly:
git clone <your-new-repo> my-project
cd my-project
```

### 2. **RUN THE BOOTSTRAP SCRIPT (REQUIRED!)**

```bash
./start.sh
```

This script will:
- Guide you through project setup
- Create `TASK.md` with your project details
- Create `PLAN.md` with your architecture
- Create `claude.md` with project-specific instructions
- Set up git hooks (optional)
- Create initial commit
- **Optionally launch Claude with CLAUDE_PROTOCOL.md copied to clipboard!**

**Do NOT skip this step!** Without running `start.sh`, you will not have a `TASK.md` file and Claude cannot work.

**Note:** If you choose to start Claude at the end of `start.sh`, the protocol will be copied to your clipboard. Just paste (Cmd+V) when Claude starts!

### 3. (Alternative) Manually Create TASK.md

If you prefer not to use the bootstrap script, manually create `TASK.md`:

```markdown
## Objective
Build a REST API for user authentication

## Current State
Project just initialized

## DONE
- Created project from template

## OPEN
- Set up project structure
- Install dependencies
- Create database schema

## Next Action
Create a package.json file with Express and PostgreSQL dependencies
```

Also create `PLAN.md` and `claude.md` if needed.

### 4. Start Claude (Clipboard-Assisted or Manual)

**Option A: Clipboard-Assisted (Recommended)**

The bootstrap script asks if you want to start Claude. If you say yes:
1. CLAUDE_PROTOCOL.md is copied to your clipboard
2. Claude starts automatically
3. Just press **Cmd+V** (or Ctrl+V) and **Enter** to paste the protocol
4. Done! Claude reads TASK.md and starts working

**Option B: Use Helper Script**

Anytime you want to resume work:

```bash
./tools/launch-claude.sh
```

This copies `CLAUDE_PROTOCOL.md` to clipboard and starts Claude. Just paste and press Enter!

**Option C: Manual**

Start Claude manually and paste the protocol:

```bash
claude
# Then paste the entire contents of CLAUDE_PROTOCOL.md
```

Claude will respond:
```
Protocol acknowledged.
Reading TASK.md now.
```

### 6. Let Claude Work

Claude will:
1. Read `TASK.md`
2. Read `claude.md` (if it exists) for project-specific instructions
3. Summarize the current state
4. Ask for confirmation
5. Execute **one step**
6. Update `TASK.md`
7. Output: `TASK.md updated. Waiting.`
8. **Stop**

### 7. Continue

Simply type "continue" or "next" to proceed to the next step.

Claude will read the updated `TASK.md` and repeat the cycle.

---

## Recovery from Interruption

### If Claude Session Ends Unexpectedly

**Quick Resume (Recommended):**
```bash
./tools/launch-claude.sh
```

This automatically loads the protocol and resumes from where you left off.

**Manual Resume:**
1. Start a new Claude session: `claude`
2. Paste the contents of `CLAUDE_PROTOCOL.md` again
3. Claude reads `TASK.md` and continues from where it stopped

**No explanation needed. No context required. It just works.**

---

## Usage Patterns

### Normal Workflow

```
You: [Paste CLAUDE_PROTOCOL.md]
Claude: Protocol acknowledged. Reading TASK.md now.
Claude: [Summarizes objective, current state, next action]
Claude: Proceed with this action? (y/n)
You: y
Claude: [Executes one step]
Claude: TASK.md updated. Waiting.
You: continue
Claude: [Reads TASK.md again, repeats cycle]
```

### Switching Claude Accounts

```
[Token limit reached on Account A]

You: [Open Claude Code with Account B]
You: [Paste CLAUDE_PROTOCOL.md]
Claude (Account B): Protocol acknowledged. Reading TASK.md now.
[Continues seamlessly from where Account A stopped]
```

### Capturing State with `handoff.sh`

Run this script to capture detailed state before ending a session:

```bash
./tools/handoff.sh
```

This captures:
- Git status and diffs
- Recent commits
- TODO/FIXME markers
- Untracked files

Optionally appends this information to `TASK.md`.

---

## File Responsibilities in Detail

### `TASK.md` - Execution State (CRITICAL)

This file is the **single source of truth** for task execution.

**Structure:**
- **Objective:** What are we building?
- **Current State:** Where are we now?
- **DONE:** Completed actions (with checkboxes)
- **OPEN:** Remaining actions (with checkboxes)
- **Next Action:** ONE specific, executable step
- **Notes:** Context or constraints
- **Blockers:** Issues preventing progress

**Rules:**
- Claude **must** update this after every step
- Any Claude session **must** be able to resume from this file
- Keep "Next Action" **imperative and unambiguous**

**Example:**
```markdown
## Next Action
Create a new file `src/routes/auth.js` that exports an Express router with POST /login and POST /register endpoints.
```

### `PLAN.md` - Strategic Intent (STABLE)

This file contains **high-level, slow-changing decisions**.

**Structure:**
- Project overview
- Architecture and tech stack
- Scope (in/out)
- Constraints
- Acceptance criteria
- Design decisions with rationale

**Rules:**
- Claude should **not** modify this unless explicitly told
- Humans update this when architecture changes
- Provides context for **why** decisions were made

### `claude.md` - Project-Specific Instructions (OPTIONAL)

This file contains **project-specific instructions** that Claude should follow.

**Structure:**
- Project context (name, tech stack, version)
- Automation rules (version numbering, auto-open/close)
- Code standards and conventions
- Testing requirements
- Common patterns
- Lessons learned

**Purpose:**
- Supplements global `~/.claude/CLAUDE.md`
- Provides project-specific context
- Documents version numbers and automation rules
- Captures lessons learned during development

**Rules:**
- Created during bootstrap (`./start.sh`)
- Claude reads this **after** `TASK.md` and **before** starting work
- Updated by both humans and Claude
- Can include version numbers, coding standards, and project-specific rules

**Example:**
```markdown
## Automation Rules

### Version Numbering
- Current version: v0.1
- Update version in app header after each significant change

### Auto-Open/Close Logic
- System should start and stop automatically
- No manual intervention required
```

### `CLAUDE_PROTOCOL.md` - Execution Rules (IMMUTABLE)

This file defines **how Claude must operate**.

**Purpose:**
- Ensures Claude executes one step at a time
- Forces state updates after every step
- Enables stateless operation
- Makes handoffs seamless

**Rules:**
- **Never modified** after creation
- Pasted into every new Claude session
- Non-negotiable execution protocol

### `tools/launch-claude.sh` - Auto-Launch Helper (UTILITY)

A shell script that launches Claude with the protocol automatically loaded.

**Usage:**
```bash
./tools/launch-claude.sh
```

**What it does:**
- Checks if `TASK.md` exists (prevents errors)
- Checks if `CLAUDE_PROTOCOL.md` exists
- Copies protocol to your clipboard
- Launches Claude automatically
- You just paste (Cmd+V) and press Enter

**When to use:**
- After `start.sh` completes (if you didn't auto-launch)
- When resuming work after a break
- After Claude session ends unexpectedly
- Anytime you want to start a new Claude session

**Benefits:**
- Protocol ready in clipboard - just one paste!
- Faster workflow than manual copy
- Works on macOS (pbcopy) and Linux (xclip)
- Less room for error

### `tools/handoff.sh` - State Capture (UTILITY)

A shell script that captures project state.

**Usage:**
```bash
./tools/handoff.sh
```

**Captures:**
- Git status, diffs, commits
- TODO/FIXME markers
- Untracked files
- Changes vs main branch

**Output:**
- Creates `STATE.raw.md` (ignored by git)
- Optionally appends to `TASK.md`

---

## Best Practices

### ✅ Do This

- Keep "Next Action" **specific and executable**
- Update `TASK.md` after every meaningful change
- Run `./tools/handoff.sh` before long breaks
- Review `TASK.md` regularly to ensure it's accurate
- Use `PLAN.md` to document **why** decisions were made

### ❌ Don't Do This

- Don't let Claude execute multiple steps without updating `TASK.md`
- Don't rely on Claude's memory or chat history
- Don't skip pasting `CLAUDE_PROTOCOL.md` in new sessions
- Don't make `TASK.md` vague or ambiguous
- Don't change `PLAN.md` frequently (it should be stable)

---

## Advanced Usage

### Parallel Work Streams

If you need to work on multiple independent tasks:

1. Create separate task files: `TASK-auth.md`, `TASK-frontend.md`
2. Tell Claude which task file to read
3. Each file maintains independent state

### Integration with Git Hooks

Add a pre-commit hook to ensure `TASK.md` is always up to date:

```bash
#!/bin/bash
# .git/hooks/pre-commit
if ! git diff --cached --name-only | grep -q "TASK.md"; then
    echo "Warning: TASK.md was not updated in this commit"
    echo "Consider running ./tools/handoff.sh"
fi
```

### Emergency API-Based Resume

If you need to summarize a large `TASK.md` for context:

```bash
# Use Claude API to summarize
cat TASK.md | claude-api "Summarize the current state and next action"
```

---

## Troubleshooting

### Problem: Claude isn't following the protocol

**Solution:** Paste `CLAUDE_PROTOCOL.md` again. Claude has no memory of previous sessions.

### Problem: Claude is executing multiple steps

**Solution:** Stop Claude immediately. Remind it to follow the protocol. Only one step per cycle.

### Problem: TASK.md is out of sync with reality

**Solution:** Run `./tools/handoff.sh` to capture current state, then manually update `TASK.md`.

### Problem: Next Action is unclear

**Solution:** Update `TASK.md` with a clearer, more specific Next Action. Make it imperative and executable.

### Problem: Lost track of what was done

**Solution:** Check git history:
```bash
git log --oneline
git diff HEAD~5
```

---

## Why This Template Exists

### The Problem

Claude Code sessions are **not persistent**:
- Token limits cause sudden termination
- Users switch between multiple Claude Pro accounts
- Chat history is unreliable
- Instructions must be repeated every session

### The Solution

**Externalize all state** into version-controlled files:
- `TASK.md` = execution state
- `PLAN.md` = strategic intent
- `CLAUDE_PROTOCOL.md` = execution rules

Treat Claude as a **stateless worker** that:
- Reads state from files
- Executes one atomic step
- Writes state back to files
- Stops immediately

### The Result

- Claude can terminate **at any moment** without data loss
- **Any Claude account** can resume seamlessly
- **No repeated explanations** needed
- **Full transparency** into what was done and what remains
- **Deterministic execution** with clear protocols

---

## Contributing

This is a template repository. To improve it:

1. Fork this repository
2. Make improvements
3. Submit a pull request

Focus on:
- Clearer documentation
- Better `handoff.sh` functionality
- Additional optional tools
- Real-world usage examples

---

## License

MIT License - Use freely for any project.

---

## Credits

Designed for **Claude Code power users** who need reliable, resumable workflows across multiple sessions and accounts.

Built on the principle: **The repository is the single source of truth.**
