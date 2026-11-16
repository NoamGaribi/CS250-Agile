# Test Cases: Jania L

**Team number:** 09
**My area:** Audit parsing

---

**Test ID:** JL-01
**From Part 6:** TC-2
**Written by:** Jania Little
**Title:** A course with a failing grade (F) is not counted as completed
**Traces to:** REQ-JL-02-1
**Test type:** Negative
**Preconditions:** Repo installed (`npm install` in my-app). Test runs DegreeAudit directly, no database or login needed.
**Test data:** Audit text: "FA21 CS 150 3.0 F"

**Steps:**
1. Create `new DegreeAudit("Test", "FA21 CS 150 3.0 F")` from app/lib/DegreeAudit.ts
2. Call `extractProgress()` and save the result as `p`
3. Call `p.getCompletedCourseCodes()` and read the result

**Expected result:** Returns `[]` because F is a failing grade. (A passing line like "FA21 CS 150 3.0 B" returns `["CS 150"]`.)
**Actual result:** Returns `["CS 150"]`. Any grade, including F, marks the course as completed.
**Status:** Fail
**Severity:** Major
**V or V:** Verification
**GitHub Issue:** #__ ([JL-01] Failed course (F) is counted as completed)

---

**Test ID:** JL-02
**From Part 6:** TC-3
**Written by:** Jania Little
**Title:** A course subject with exactly 5 letters is recognized
**Traces to:** REQ-JL-02-2
**Test type:** Boundary Value
**Preconditions:** Repo installed (`npm install` in my-app). Test runs DegreeAudit directly, no database or login needed.
**Test data:** Audit text: "FA21 ABCDE 101 3.0 A"

**Steps:**
1. Create `new DegreeAudit("Test", "FA21 ABCDE 101 3.0 A")` from app/lib/DegreeAudit.ts
2. Call `extractProgress()` and save the result as `p`
3. Call `p.getCompletedCourseCodes()` and read the result

**Expected result:** Returns `["ABCDE 101"]`.
**Actual result:** Returns `["ABCDE 101"]`. (A 6-letter subject, "FA21 ABCDEF 101 3.0 A", returns `[]`, so 5 is the limit.)
**Status:** Pass
**Severity:** N/A
**V or V:** N/A
**GitHub Issue:** N/A

---

**Test ID:** JL-03
**From Part 6:** New
**Written by:** Jania Little
**Title:** Upload form rejects files that are not PDF or .txt
**Traces to:** REQ-JL-02-3
**Test type:** Negative
**Preconditions:** App running at localhost:3000. Signed in to an existing account.
**Test data:** A .png file and a .exe file

**Steps:**
1. Open localhost:3000/dashboard/upload
2. Choose the .png file and click "Upload Audit"
3. Repeat with the .exe file

**Expected result:** The file is rejected and the page shows "Invalid file type." Nothing is saved to audit_imports.
**Actual result:** [run and fill in]
**Status:** [Pass / Fail]
**Severity:**
**V or V:** Minor
**GitHub Issue:** Verification

---

**Test ID:** JL-04
**From Part 6:** New
**Written by:** Jania Little
**Title:** Upload of an audit file over 5MB is rejected
**Traces to:** NFR-JL-02
**Test type:** Boundary Value
**Preconditions:** App running at localhost:3000. Signed in to an existing account.
**Test data:** A .pdf audit file of 5.1MB

**Steps:**
1. Open localhost:3000/dashboard/upload
2. Choose the 5.1MB file and click "Upload Audit"
3. Read the message under the button

**Expected result:** The page shows "File size exceeds 5MB limit." Nothing is saved to audit_imports.
**Actual result:** [run and fill in]
**Status:** [Pass / Fail]
**Severity:** Minor
**V or V:**  Verification
**GitHub Issue:**

---

**Test ID:** JL-05
**From Part 6:** New
**Written by:** Jania Little
**Title:** A student's uploaded audit saves their completed courses with term and grade
**Traces to:** G-JL-01
**Test type:** Acceptance
**Preconditions:** App running at localhost:3000. Signed in to an existing account. You can open the app's MySQL database.
**Test data:** A .txt file containing these two lines:
FA21 CS 150 3.0 B
SP22 MATH 150 4.0 A

**Steps:**
1. Open localhost:3000/dashboard/upload
2. Choose the .txt file and click "Upload Audit"
3. Note the audit number in the success message
4. In MySQL, run: select course_code, status, term_label, grade from user_courses where audit_import_id = [audit number]

**Expected result:** The page says the file was saved. The query returns 2 rows: CS 150 / completed / FA21 / B and MATH 150 / completed / SP22 / A.
**Actual result:** [run and fill in]
**Status:** [Pass / Fail]
**Severity:**
**V or V:**
**GitHub Issue:**

---