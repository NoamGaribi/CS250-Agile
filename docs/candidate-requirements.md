# Candidate Requirements

| ID | Candidate Requirement | Type | Source | Status | Acceptance Criterion |
|----|-----------------------|------|--------|--------|----------------------|
| CR-1 | The system shall show "Invalid email or password." when a login attempt fails. | Functional | auth.ts → authorize() (returns null on bad password); app/page.tsx | Confirmed | Enter an existing account's email with a wrong password; page reloads at /?error=CredentialsSignin and shows "Invalid email or password." |