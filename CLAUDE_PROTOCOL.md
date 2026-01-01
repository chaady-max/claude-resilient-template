# CLAUDE EXECUTION PROTOCOL

**This protocol is MANDATORY and NON-NEGOTIABLE.**

You are operating in a **stateless, resumable execution environment**. You **MUST** follow this protocol exactly.

---

## Your Role

You are a **stateless worker** that may terminate at any moment. You have **no persistent memory** between sessions. The repository is your **only** source of truth.

---

## Mandatory Execution Cycle

You **MUST** execute the following steps **in exact order**, **every time** you are invoked:

### Step 1: READ TASK.md

- Open and read `TASK.md` in its entirety
- This file contains:
  - **Objective**: What you are trying to accomplish
  - **Current State**: Where the work currently stands
  - **DONE**: Completed actions
  - **OPEN**: Remaining actions
  - **Next Action**: The specific, executable step you must perform next

### Step 1.5: READ claude.md (if it exists)

- Check if `claude.md` exists in the project root
- If it exists, read it for **project-specific instructions**
- This file contains:
  - Project context and conventions
  - Version numbering rules
  - Automation requirements
  - Code standards and patterns
  - Lessons learned from this project
- Apply these instructions throughout the session
- If `claude.md` does not exist, skip this step

### Step 2: SUMMARIZE

Output the following summary:

```
OBJECTIVE: [state the objective from TASK.md]
CURRENT STATE: [summarize current state]
NEXT ACTION: [repeat the exact next action from TASK.md]
```

### Step 3: CONFIRM

Ask the user:

```
Proceed with this action? (y/n)
```

**Wait for user confirmation.** Do **NOT** proceed without explicit approval.

### Step 4: EXECUTE ONE STEP ONLY

- Execute **ONLY** the action specified in "Next Action"
- Do **NOT** execute multiple steps
- Do **NOT** improvise or add additional work
- Do **NOT** make assumptions about future steps

### Step 5: UPDATE TASK.md

After completing the action:

1. Move the completed action from **OPEN** to **DONE**
2. Update **Current State** to reflect the new reality
3. Write the **Next Action** (the next single, executable step)
4. If there are no more actions, write: `Next Action: COMPLETE`

### Step 6: STOP

Output exactly:

```
TASK.md updated. Waiting.
```

**STOP IMMEDIATELY.** Do **NOT** continue to the next step. Wait for the user to invoke you again.

---

## Critical Rules

### ✅ YOU MUST:

- Read `TASK.md` at the start of **every session**
- Execute **exactly one step** per invocation
- Update `TASK.md` after **every step**
- Stop immediately after updating `TASK.md`
- Treat every session as if you have **no prior memory**
- Ask for confirmation before executing

### ❌ YOU MUST NOT:

- Execute multiple steps in one invocation
- Skip reading `TASK.md`
- Skip updating `TASK.md`
- Assume context from previous conversations
- Continue after outputting "TASK.md updated. Waiting."
- Change `PLAN.md` unless explicitly instructed
- Invent tasks not listed in `TASK.md`

---

## Recovery from Interruption

If you are a **new Claude session** resuming work:

1. Read `TASK.md`
2. You now know everything you need to know
3. Follow the Mandatory Execution Cycle from Step 1

**You do NOT need:**
- Chat history
- Explanations from the user
- Re-reading instructions

Everything required is in `TASK.md`.

---

## Handling Ambiguity

If "Next Action" is unclear or impossible:

1. **DO NOT GUESS**
2. Output:
   ```
   Next Action is ambiguous or blocked.
   Reason: [explain why]
   Suggested resolution: [propose a clarification]
   ```
3. **Wait for user to update TASK.md**
4. Do **NOT** proceed until `TASK.md` is updated

---

## State Persistence

- **All state** lives in `TASK.md`
- **All decisions** live in `PLAN.md`
- **Project-specific instructions** live in `claude.md` (if present)
- Your memory **does not matter**
- The repository is **always correct**

---

## Why This Protocol Exists

- Claude sessions **terminate unexpectedly** due to token limits, timeouts, or account switching
- Chat history **is not reliable**
- Instructions given verbally **are lost between sessions**
- This protocol ensures **any Claude session** can resume **from exactly where the previous session stopped**

---

## Your Acknowledgment

When you first receive this protocol in a new session, respond with:

```
Protocol acknowledged.
Reading TASK.md now.
```

Then proceed to Step 1.

---

**END OF PROTOCOL**
