# PLAN

**This file contains high-level, stable intent and architectural decisions.**

Claude should **NOT** modify this file unless explicitly instructed by the user.

---

## Project Overview

[Describe the project at a high level. What is it? Why does it exist?]

Example: A user authentication microservice that provides JWT-based authentication for multiple client applications.

---

## Architecture

[Describe the chosen architecture, technology stack, and structural decisions.]

Example:
- **Backend:** Node.js with Express
- **Database:** PostgreSQL
- **Authentication:** JWT with refresh tokens
- **Testing:** Jest + Supertest
- **Deployment:** Docker containers on AWS ECS

---

## Scope

### In Scope

[What features and functionality are included in this project?]

Example:
- User registration with email verification
- Login with email and password
- JWT token generation and validation
- Refresh token rotation
- Password reset flow

### Out of Scope

[What features and functionality are explicitly excluded?]

Example:
- OAuth social login
- Two-factor authentication
- User profile management
- Role-based access control (RBAC)

---

## Constraints

[List any technical, business, or other constraints that must be respected.]

Example:
- Must support 10,000 concurrent users
- Response time < 200ms for authentication requests
- Must comply with GDPR requirements
- Must use only open-source dependencies
- Budget limit: 2 weeks of development time

---

## Acceptance Criteria

[Define what "done" means. How will we know this project is complete?]

Example:
- [ ] All authentication endpoints return correct responses
- [ ] Test coverage > 80%
- [ ] API documentation is complete
- [ ] Security audit passes
- [ ] Load testing shows < 200ms p95 latency
- [ ] Production deployment is successful

---

## Design Decisions

[Document important design decisions and the reasoning behind them.]

Example:

### Decision: Use JWT instead of sessions
- **Reasoning:** Stateless authentication allows horizontal scaling without shared session storage
- **Trade-offs:** Tokens cannot be revoked immediately; must wait for expiration
- **Mitigation:** Use short-lived access tokens (15 min) with refresh tokens

### Decision: PostgreSQL instead of MongoDB
- **Reasoning:** Relational data model fits user/auth domain well; ACID guarantees important for security
- **Trade-offs:** Less flexible schema changes
- **Mitigation:** Use database migrations for schema evolution

---

## Non-Functional Requirements

[List performance, security, scalability, and other non-functional requirements.]

Example:
- **Security:** Passwords hashed with bcrypt (cost factor 12)
- **Performance:** p95 latency < 200ms
- **Availability:** 99.9% uptime
- **Scalability:** Must handle 10x traffic growth
- **Monitoring:** Full request tracing and error logging

---

## Future Considerations

[Ideas or features that might be added later but are not current priorities.]

Example:
- OAuth integration
- Multi-factor authentication
- Rate limiting per user
- Admin dashboard for user management

---

**Last Updated:** [Date]

**Version:** [Version number if applicable]
