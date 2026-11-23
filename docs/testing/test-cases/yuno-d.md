# Test Cases: Yuno D

**Team number:** 09
**My area:** Audit Upload

<!--
HOW TO USE THIS FILE
1. Copy this file. Name the copy with your first name and last initial, like  maria-g.md
2. Leave TEMPLATE.md untouched for your teammates.
3. If a Part 6 test belongs to your area, upgrade it first and put it in the first block.
   Write at least 4 test cases using at least 3 test types. Include 1 Acceptance test that traces to your Stakeholder Goal.
   Run every test on the inherited system. Every Fail gets a GitHub Issue.
4. Copy the block between the lines for each new test case.
5. Test IDs: use your initials plus a number, like  MG-01, MG-02. This keeps IDs unique across your team.
   "Traces to" must name one of YOUR requirement IDs, like REQ-MG-02.
6. See docs/TESTING_FIELD_GUIDE.md for the sample test case TC-00.
-->

---

**Test ID:** YD-01
**From Part 6:** New
**Written by:** Yuno Dela Pena
**Title:** Rejects files that are not .txt or .pdf 
**Traces to:** REQ-YD-01
**Test type:** Negative
**Preconditions:** Create account using 'mdelapena7203@sdsu.edu' and 'cs250agile' and sign-in, run localhost:3000
**Test data:** .jpg file

**Steps:**
1. Sign into account
2. Press 'Upload' under 'Upload Degree Audit'
3. Attempt to upload .jpg file

**Expected result:** Unable to upload any other files other than .pdf and .txt
**Actual result:** All files except .pdf and .txt are greyed out
**Status:** Pass
**Severity:** N/A
**V or V:** N/A
**GitHub Issue:** N/A

---

**Test ID:** YD-02
**From Part 6:** New
**Written by:** Yuno Dela Pena
**Title:** Accepts files less than or equal to 5MB and rejects files over 5MB
**Traces to:** NFR-YD-01
**Test type:** Boundary Value
**Preconditions:** Create account using 'mdelapena7203@sdsu.edu' and 'cs250agile' and sign-in, run localhost:3000
**Test data:** .pdf file larger than 5MB

**Steps:**
1. Open localhost:3000
2. Press 'Upload' under 'Upload Degree Audit'
3. Select .pdf file larger than 5MB

**Expected result:** Rejects uploaded file
**Actual result:** Rejects uploaded file and shows runtime error
**Status:** Pass
**Severity:** N/A
**V or V:** N/A
**GitHub Issue:** N/A

---

**Test ID:** YD-03
**From Part 6:** New
**Written by:** Yuno Dela Pena
**Title:** Users that are signed out redirect when attempting to open upload audit page
**Traces to:** REQ-YD-02
**Test type:** Security
**Preconditions:** Create account using 'mdelapena7203@sdsu.edu' and 'cs250agile' and sign-in, run localhost:3000
**Test data:** Signed into account, pressing logged out while on audit upload page

**Steps:**
1. Open localhost:3000
2. Press 'Upload' under 'Upload Degree Audit'
3. Press sign-out in top right corner

**Expected result:** Redirects back to log-in screen
**Actual result:** Redirected to log-in screen
**Status:** Pass
**Severity:** N/A
**V or V:** N/A
**GitHub Issue:** N/A

---

**Test ID:** YD-04
**From Part 6:** New
**Written by:** Yuno Dela Pena
**Title:** User uploads a valid audit and sees confirmation screen
**Traces to:** REQ-YD-03
**Test type:** Acceptance
**Preconditions:** Create account using 'mdelapena7203@sdsu.edu' and 'cs250agile' and sign-in, run localhost:3000, have appropriate file
**Test data:** Degree audit file less than or equal to 5MB

**Steps:**
1. Open localhost:3000
2. Press 'Upload' under 'Upload Degree Audit'
3. Press 'Upload Audit'
4. Select degree audit that is a .pdf or .txt file and less than 5MB

**Expected result:** Shows message that audit has successfuly uploaded
**Actual result:** Shows that audit successfully uploaded and 'Upload Audit' button is greyed out
**Status:** Pass
**Severity:** N/A
**V or V:** N/A
**GitHub Issue:** N/A

---

**Test ID:** YD-05
**From Part 6:** New
**Written by:** Yuno Dela Pena
**Title:** Upload Audit button stays disabled when no file is selected
**Traces to:** REQ-YD-03
**Test type:** Negative
**Preconditions:** App running at localhost:3000. Signed in to an existing test account.
**Test data:** No file selected

**Steps:**
1. Open localhost:3000/dashboard/upload
2. Do not choose a file
3. Try to click "Upload Audit"

**Expected result:** The "Upload Audit" button is greyed out and nothing is submitted or saved.
**Actual result:** The button is greyed out and nothing is submitted.
**Status:** Pass
**Severity:** N/A
**V or V:** N/A
**GitHub Issue:** N/A

---

**Test ID:** YD-06
**From Part 6:** New
**Written by:** Yuno Dela Pena
**Title:** A 0-byte file is rejected
**Traces to:** REQ-YD-01
**Test type:** Boundary Value
**Preconditions:** App running at localhost:3000. Signed in to an existing test account.
**Test data:** An empty file named empty.txt (0 bytes), made with `empty.txt`

**Steps:**
1. Open localhost:3000/dashboard/upload
2. Choose empty.txt
3. Click "Upload Audit"

**Expected result:** The file is rejected with an error message and nothing is saved to audit_imports.
**Actual result:** The file was rejected and no upload succeeded.
**Status:** Pass
**Severity:** N/A
**V or V:** N/A
**GitHub Issue:** N/A

---

**Test ID:** YD-07
**From Part 6:** New
**Written by:** Yuno Dela Pena
**Title:** A .txt file renamed to .pdf is rejected
**Traces to:** REQ-YD-01
**Test type:** Negative
**Preconditions:** App running at localhost:3000. Signed in to an existing test account.
**Test data:** A plain text file renamed to fake-audit.pdf (contents are not a real PDF)

**Steps:**
1. Open localhost:3000/dashboard/upload
2. Choose fake-audit.pdf
3. Click "Upload Audit"

**Expected result:** The file is rejected with an error message and nothing is saved to audit_imports.
**Actual result:** The file was rejected and no upload succeeded.
**Status:** Pass
**Severity:** N/A
**V or V:** N/A
**GitHub Issue:** N/A

---

**Test ID:** YD-08
**From Part 6:** New
**Written by:** Yuno Dela Pena
**Title:** A valid PDF with an uppercase extension is accepted
**Traces to:** REQ-YD-01
**Test type:** Boundary Value
**Preconditions:** App running at localhost:3000. Signed in to an existing test account.
**Test data:** A valid degree audit PDF named AUDIT.PDF (uppercase extension), under 5MB

**Steps:**
1. Open localhost:3000/dashboard/upload
2. Choose AUDIT.PDF
3. Click "Upload Audit"

**Expected result:** The upload succeeds and the page shows the "Upload succeeded!" message, because the file is a valid PDF.
**Actual result:** The upload succeeded and the success message was shown.
**Status:** Pass
**Severity:** N/A
**V or V:** N/A
**GitHub Issue:** N/A

---

**Test ID:** YD-09
**From Part 6:** New
**Written by:** Yuno Dela Pena
**Title:** A file with no extension is rejected
**Traces to:** REQ-YD-01
**Test type:** Negative
**Preconditions:** App running at localhost:3000. Signed in to an existing test account.
**Test data:** A text file named "audit" with no extension

**Steps:**
1. Open localhost:3000/dashboard/upload
2. Change the file picker filter to "All files" and choose "audit"
3. Click "Upload Audit"

**Expected result:** The file is rejected with an error message and nothing is saved to audit_imports.
**Actual result:** The file was rejected and no upload succeeded.
**Status:** Pass
**Severity:** N/A
**V or V:** N/A
**GitHub Issue:** N/A

---

**Test ID:** YD-10
**From Part 6:** New
**Written by:** Yuno Dela Pena
**Title:** Uploading the same audit twice does not create duplicate courses
**Traces to:** REQ-YD-04
**Test type:** Integration
**Preconditions:** App running at localhost:3000. Signed in to an existing test account. You can open the app's MySQL database (degree_planner).
**Test data:** One valid degree audit .pdf or .txt under 5MB, uploaded twice. Query: SELECT course_code, COUNT(*) AS times_saved FROM user_courses WHERE user_id = [id] GROUP BY course_code HAVING COUNT(*) > 1;

**Steps:**
1. Open localhost:3000/dashboard/upload
2. Choose the audit file and click "Upload Audit"
3. Upload the same file a second time
4. In MySQL, run the test data query for the test account's user id

**Expected result:** The query returns no rows, so no course is saved more than once for the same user.
**Actual result:** The query returned "Empty set". No duplicate courses were saved. [Add what you saw in audit_imports, e.g. 2 rows or 1 row.]
**Status:** Pass
**Severity:** N/A
**V or V:** N/A
**GitHub Issue:** N/A

---

**Test ID:** YD-11
**From Part 6:** New
**Written by:** Yuno Dela Pena
**Title:** A PDF with no readable text layer is rejected
**Traces to:** REQ-YD-05
**Test type:** Negative
**Preconditions:** App running at localhost:3000. Signed in to an existing test account. You can open the app's MySQL database (degree_planner).
**Test data:** An image-only (scanned) PDF with no text layer, under 5MB, named [file name]

**Steps:**
1. Open localhost:3000/dashboard/upload
2. Choose the image-only PDF
3. Click "Upload Audit"
4. In MySQL, run: SELECT * FROM audit_imports ORDER BY id DESC LIMIT 3; and check user_courses for the new audit id

**Expected result:** The file is rejected with an error message such as "No readable text found" and nothing is saved to audit_imports or user_courses.
**Actual result:** The page showed 'Upload succeeded!' and a new audit_imports row was saved
**Status:** Fail
**Severity:** Medium
**V or V:** Verification
**GitHub Issue:** #101

---

**Test ID:** YD-12
**From Part 6:** New
**Written by:** Yuno Dela Pena
**Title:** Signed-out request to /api/users is rejected and never returns password hashes
**Traces to:** REQ-YD-06
**Test type:** Security
**Preconditions:** App running at localhost:3000. Signed out (use a private browser window so there is no active session). At least one account exists in the user table.
**Test data:** URL: localhost:3000/api/users

**Steps:**
1. Open a new private browser window
2. Type localhost:3000/api/users in the address bar and press Enter
3. Read the response body
4. Sign in to the app in a normal window, then open localhost:3000/api/users and read the response body

**Expected result:** Signed out, the response is {"error":"Unauthorized"} with status 401 and no user data. Signed in, the response lists users with only id, email, name and last_name. The password_hash field never appears in either response.
**Actual result:** Signed-out response listed every user and included each password_hash value.
**Status:** Pass
**Severity:** High
**V or V:** Verification
**GitHub Issue:** #104