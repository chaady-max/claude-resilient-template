# TASK - User Authentication API

## Objective

Build a REST API for user authentication with the following features:
- User registration with email/password
- User login with JWT token generation
- Password hashing with bcrypt
- Token validation middleware
- PostgreSQL database backend
- Basic error handling and validation

## Current State

Basic project structure is in place. Express server is configured and running on port 3000. PostgreSQL database connection is established. User model and schema are created. Currently working on implementing the registration endpoint with password hashing.

---

## DONE

- [x] Initialized Node.js project with package.json
- [x] Installed dependencies (express, pg, bcrypt, jsonwebtoken, dotenv)
- [x] Created project directory structure (src/routes, src/models, src/middleware, src/database)
- [x] Set up Express server with basic configuration in src/server.js
- [x] Created database connection module in src/database/connection.js
- [x] Designed and created users table schema (id, email, password_hash, created_at)
- [x] Wrote User model in src/models/User.js with create() and findByEmail() methods
- [x] Created auth router file in src/routes/auth.js

---

## OPEN

- [ ] Implement POST /register endpoint with validation and password hashing
- [ ] Implement POST /login endpoint with password verification and JWT generation
- [ ] Create JWT authentication middleware in src/middleware/auth.js
- [ ] Add input validation for email format and password strength
- [ ] Add proper error handling and HTTP status codes
- [ ] Write integration tests for registration and login flows
- [ ] Add password reset functionality (stretch goal)
- [ ] Document API endpoints in README

---

## Next Action

In the file `src/routes/auth.js`, implement the POST /register endpoint that:
1. Accepts email and password in request body
2. Validates that both fields are present
3. Checks if user already exists using User.findByEmail()
4. Hashes the password using bcrypt with cost factor 12
5. Creates new user using User.create() with email and hashed password
6. Returns 201 status with success message (no sensitive data)
7. Returns appropriate error responses (400 for validation, 409 for duplicate user, 500 for server errors)

---

## Notes

**Environment Variables Required:**
- DATABASE_URL: PostgreSQL connection string
- JWT_SECRET: Secret key for signing tokens
- PORT: Server port (default 3000)

**Code Style:**
- Use async/await for asynchronous operations
- Use try/catch blocks for error handling
- Return consistent JSON response format: `{ success: boolean, message: string, data?: any }`

**Database Schema:**
```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**Security Considerations:**
- Never return password hashes in API responses
- Use bcrypt cost factor of 12 (balance between security and performance)
- JWT tokens should expire in 24 hours
- Validate email format using regex or validator library

---

## Blockers

None currently.

---

**Last Updated:** 2026-01-01 12:30:00

**Updated By:** Claude (via CLAUDE_PROTOCOL)
