# Testable Requirements: [Project Name]

**Team number:** [09]
**Inherited from:** Team [08]

## Who Owns What

| Area of the system | Owner | ID prefix |
|---|---|---|
| Accounts and Login| Sunny | SS |
| Audit Upload | Yuno | YD |
| Audit parsing| Jania| JL|
| Database and roadmap| Alexa| AQ|

<!--
RULES
- Only edit YOUR OWN section below. This keeps merge conflicts away.
- Categories: G = Stakeholder Goal, REQ = Functional, NFR = Non-Functional.
- "From Part 5": write the original CR ID and its text from SYSTEM_MAP.md. Write "New" if you added it this sprint.
- Status: Confirmed or Suspected bug. No Unconfirmed allowed. Every Suspected bug needs a GitHub Issue.
- The test: could a stranger write a Pass or Fail test without asking you a question?
-->

---

## Section: Accounts and Login (Sunny Suarez)

### Stakeholder Goals

| ID | Stakeholder | Goal |
|---|---|---|
| G-SS-01 | SDSU CS student|Create an account and sign back in later so they can return to their own degree plan |

### Functional Requirements

| ID | Requirement | Status | From Part 5 |
|---|---|---|---|
| REQ-SS-01 | The system shall show "Invalid email or password." when a user logs in with a registered email and a wrong password.|Confirmed |CR-1 |
| REQ-SS-02 | The syste shall redirect a signed-out visitor who opens /dashboard to the login page at /.|Confirmed |CR-3 |
| REQ-SS-03 | The system shall send a user with a correct email and password to /dashboard after login.|Confirmed |New |

### Non-Functional Requirements

| ID | Requirement | Status | From Part 5 |
|---|---|---|---|
| NFR-SS-01 | The system shall store each password only as a bcrypt hash that starts with $2b$12$ and never equals the password the user typed.|Confirmed |CR-2 |

###

---

## Section: Audit Upload (Yuno D)

### Stakeholder Goals

| ID | Stakeholder | Goal |
|---|---|---|
| G-YD-01 | SDSU Students | Be able to upload their audit to be analyzed for their system map |

### Functional Requirements

| ID | Requirement | Status | From Part 5 |
|---|---|---|---|
| REQ-YD-01 | The system shall reject non-text and non-PDF file formats submitted on the audit upload form. | Suspected Bug | CR-05 |
| REQ-YD-02 | The system shall redirect the user to the login if they are not signed in from teh audit upload page. | Confirmed | New |
| REQ-YD-03 | The system shall grey-out the "Upload Audit" button until a file is selected and while it uploads the file. | Confirmed | New |

### Non-Functional Requirements

| ID | Requirement | Status | From Part 5 |
|---|---|---|---|
| NFR-YD-01 | The system shall reject audit file uploads larger than 5MB. | Suspected Bug | CR-04 |

---

## Section: [Your Area] ([Your Name])

### Stakeholder Goals

| ID | Stakeholder | Goal |
|---|---|---|
| | | |

### Functional Requirements

| ID | Requirement | Status | From Part 5 |
|---|---|---|---|
| | | | |
| | | | |
| | | | |

### Non-Functional Requirements

| ID | Requirement | Status | From Part 5 |
|---|---|---|---|
| | | | |

---

## Section: [Your Area] ([Your Name])

### Stakeholder Goals

| ID | Stakeholder | Goal |
|---|---|---|
| | | |

### Functional Requirements

| ID | Requirement | Status | From Part 5 |
|---|---|---|---|
| | | | |
| | | | |
| | | | |

### Non-Functional Requirements

| ID | Requirement | Status | From Part 5 |
|---|---|---|---|
| | | | |
