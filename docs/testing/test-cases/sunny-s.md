# Test Cases: Sunny S

**Team number:**09
**My area:** Accounts and login

---

**Test ID:** SS-01
**From Part 6:** New
**Written by:** Sunny Suarez
**Title:** Wrong passworrd shows the login error and does not log in user
**Traces to:** REQ-SS-01
**Test type:** Negative
**Preconditions:** App running at localhost:3000. Signed out, but account exists with email sunny@example.com and password Password?
**Test data:** Email: sunny@example.com | Password: WrongPass?

**Steps:**
1. Open localhost:3000/
2. Type the test data email into email field
3. Type test data password into password field
3. click the login button

**Expected result:** The page reloads at /?error=CredentialsSignin and shows the message "Invalid email or password." User is not taken to /dashboard
**Actual result:** The page reloads at http://localhost:3000/?error=CredentialsSignin and shows the message "Invalid email or password." Not taken to /dashboard.
**Status:** Pass
**Severity:** 
**V or V:** 
**GitHub Issue:** 

---

**Test ID:** SS-02
**From Part 6:** New
**Written by:** Sunny Suarez
**Title:**Signed-out visitor to /dashboard is redirected to the login page
**Traces to:** REQ-SS-02
**Test type:** Security
**Preconditions:** App running at localhost:3000. Signed out (with no active session)
**Test data:** URL: localhost:3000/dashboard

**Steps:**
1. Open new private browser (to ensure no active session)
2. Type test data URL in address bar and press Enter
3. Look at address bar and page content
 
**Expected result:** Browser ends up at localhost:3000/ and shows the login form. Dashboard content and audit upload form are not visible
**Actual result:** Browser ends up at localhost:3000/ with login form. Dashboard content & upload form not visible
**Status:** Pass
**Severity:**
**V or V:**
**GitHub Issue:**

---

**Test ID:** SS-03
**From Part 6:** New
**Written by:** Sunny Suarez
**Title:** A new user can sign up, log in, and reach the dashboard
**Traces to:** REQ-SS-03
**Test type:** System
**Preconditions:** App running at localhost:3000. Signed out. No account exists yet with test email.
**Test data:** Email: blah@example.com | Password: Password!

**Steps:**
1.Open localhost:3000/signup
2. Type the test data email and password into the signup form and submit
3. Open localhost:3000/ if not already on page
4. Type the same email and password into login form and click login.

**Expected result:** After step 4, the browser is at localhost:3000/dashboard and the dashboard page is displayed with no error message.
**Actual result:** Address bar shows localhost:3000/dashboard and dashboard content is displayed without error.
**Status:** Pass
**Severity:**
**V or V:**
**GitHub Issue:**

---

**Test ID:** SS-04
**From Part 6:** New
**Written by:** Sunny Suarez
**Title:** Password is stored only as bcrypt hash
**Traces to:** NFR-SS-01
**Test type:** Security
**Preconditions:** SS-03 had been run, so account blah@example.com exists. You can open MySQL database user by the app.
**Test data:** Email: blah@example.com | Password: Password! | Query: select email, password_hash from user where email = 'blah@example.com'

**Steps:**
1. Connect to the app's MySQL database
2. Run the test data query
3. Read value in password_hash column

**Expected result:** One row is returned and password hash value starts with $2b$12$ and not equal to Password!
**Actual result:** One row is returned and password hash value starts with $2b$12$ and not equal to actual password
**Status:** Pass
**Severity:**
**V or V:**
**GitHub Issue:**

---

**Test ID:** SS-05
**From Part 6:** New
**Written by:** Sunny Suarez
**Title:** A returning student can sign back in to their own account
**Traces to:** G-SS-01 
**Test Type:** Acceptance
**Preconditions:** App running at localhost:3000. Account blah@example.com already exists and is signed in.
**Test data:** Email: blah@example.com | Password: Password!

**Steps:**
1. On the dashboard, sign out
2. Confirm browser shows login page
3. Type test data email and password into login form and click login. 
4. Look at dashboard.

**Expected result:** The student is signed back in and reaches /dashboard in under 10 seconds without creating a new account. Dashboard shows the same account.
**Actual result:** Student signs back in and reaches /dashboard under 10 seconds - views same account and doesn't have to create a new account
**Status:** Pass
**Severity:**
**V or V:**
**GitHub Issue:**

---

**Test ID:** SS-06
**From Part 6:** New
**Written by:** Sunny Suarez
**Title:** Signup with a 300-character email shows a generic error instead of a length validation message.

**Steps:**
1. Run the app (npm run dev in my-app) and open localhost:3000/signup.
2. Enter any name, a 300-character email (300 letters "a" plus @example.com), and the password Password! in both password fields.
3. Click Create Account.

**Expected result:** A specific message such as "Email must be 254 characters or fewer", and no account created.
**Actual result:** The page reloads at /signup?error=SignupError and shows "We could not create your account. Please try again." The terminal shows ER_DATA_TOO_LONG (errno 1406, "Data too long for column 'error'"). No account is created, but the message gives no hint that the email is the problem.
**Status:** Fail
**Environment:** MacBook Air, macOS, branch main
**Severity:** Low. No data is lost and the app keeps running
**Priority:** Low. Few students have emails this long, but the message is misleading.
**V or V:** Verification
**GitHub Issue:**

---