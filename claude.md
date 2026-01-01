# Project-Specific Claude Instructions

This file contains project-specific instructions for Claude. These instructions supplement the global `~/.claude/CLAUDE.md` and apply only to this project.

**Important:** Claude should read this file at the start of each session (after reading CLAUDE_PROTOCOL.md and TASK.md).

---

## Project Context

**Project Name:** [Your Project Name]

**Tech Stack:** [e.g., Node.js, React, PostgreSQL, etc.]

**Key Conventions:**
- [Add your code style conventions]
- [Add naming conventions]
- [Add any project-specific rules]

---

## Automation Rules

### Version Numbering
- Every significant feature or change should increment the version number
- Version format: `v0.1`, `v0.2`, etc.
- Version should be displayed in the app header/footer
- Starting version: `v0.1`

### Auto-Open/Close Logic
- If the system is "smart" (automated), it should open and close automatically
- No human interaction should be required for automated systems
- Always implement graceful startup and shutdown

---

## Code Standards

### File Organization
[Describe how files should be organized in this project]

Example:
```
src/
├── components/    # React components
├── routes/        # API routes
├── models/        # Data models
├── middleware/    # Express middleware
└── utils/         # Utility functions
```

### Naming Conventions
- Files: `kebab-case.js`
- Components: `PascalCase`
- Functions: `camelCase`
- Constants: `UPPER_SNAKE_CASE`

### Error Handling
- Always use try/catch for async operations
- Return consistent error response format
- Log errors with context

---

## Testing Requirements

- [ ] Write tests for all new features
- [ ] Minimum test coverage: [specify %]
- [ ] Run tests before committing: `npm test`

---

## Deployment Checklist

Before deploying:
- [ ] All tests pass
- [ ] No console errors
- [ ] Version number updated
- [ ] TASK.md updated
- [ ] README updated if needed

---

## Common Patterns

### API Response Format
```javascript
{
  success: boolean,
  message: string,
  data?: any,
  error?: string
}
```

### Database Queries
[Add common query patterns for your database]

### State Management
[Add state management patterns for your frontend]

---

## Lessons Learned

As you work on this project, document lessons learned here:

### [Date] - [Topic]
- **Problem:** [What went wrong]
- **Solution:** [How it was fixed]
- **Takeaway:** [What to remember for next time]

---

## Project-Specific Constraints

[Add any constraints specific to this project]

Example:
- Must support IE11 (if applicable)
- API response time must be < 200ms
- Must work offline
- Database queries must use prepared statements

---

## External Resources

- [Link to API documentation]
- [Link to design files]
- [Link to project management board]

---

**Last Updated:** [Date]

**Maintained By:** [Your Name/Team]
