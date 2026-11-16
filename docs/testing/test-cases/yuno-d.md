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
