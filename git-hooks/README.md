# Git Hooks for Claude-Resilient Template

These optional git hooks help enforce the Claude-Resilient workflow by reminding you to update `TASK.md`.

## Available Hooks

### `pre-commit`
- Checks if `TASK.md` is included in commits
- Shows a warning if `TASK.md` is not being committed
- Does **not** block commits (you can override)
- Reminds you to run `./tools/handoff.sh`

### `post-commit`
- Runs after successful commit
- Reminds you to update `TASK.md` with:
  - Move completed action to DONE
  - Update Current State
  - Write new Next Action

## Installation

### Install Individual Hook

```bash
# Install pre-commit hook
cp git-hooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

# Install post-commit hook
cp git-hooks/post-commit .git/hooks/post-commit
chmod +x .git/hooks/post-commit
```

### Install All Hooks

```bash
# Copy all hooks
cp git-hooks/pre-commit .git/hooks/
cp git-hooks/post-commit .git/hooks/

# Make them executable
chmod +x .git/hooks/pre-commit
chmod +x .git/hooks/post-commit
```

### Automated Installation

Use the bootstrap script:

```bash
./start.sh
# Select option to install git hooks
```

## Uninstalling Hooks

```bash
# Remove specific hook
rm .git/hooks/pre-commit

# Remove all hooks
rm .git/hooks/pre-commit .git/hooks/post-commit
```

## Bypassing Hooks

If you need to commit without running hooks:

```bash
git commit --no-verify -m "Your commit message"
```

## Customization

Feel free to modify these hooks to match your workflow:

- Make them **stricter** (block commits if `TASK.md` not updated)
- Make them **quieter** (reduce output)
- Add **automatic updates** (auto-run `handoff.sh`)
- Integrate with **CI/CD** pipelines

## Notes

- Git hooks are **not tracked** in the repository
- Each developer must install hooks manually
- Hooks run locally on your machine
- They cannot be automatically distributed via git clone

This is by design for security reasons - it prevents malicious code execution from cloned repositories.
