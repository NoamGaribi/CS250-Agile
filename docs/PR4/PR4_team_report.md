# PR4 TEAM REPORT

**Team number:** 09
**Members:** Sunny Suarez, Yuno Dela Pena, Jania Little

---

## 1. Bug Triage Table

| Test name | Bucket | Issue link | Severity | Priority | Owner | Status |
|---|---|---|---|---|---|---|
| SS-06: Signup with a 300-character email shows a generic error | Code bug | [#89](https://github.com/NoamGaribi/CS250-Agile/issues/89) | Low | Low | Sunny Suarez | Fixed |
| SS-07: Signup with a 300-character name shows a generic error | Code bug | [#92](https://github.com/NoamGaribi/CS250-Agile/issues/92) | Low | Low | Sunny Suarez | Fixed |
| [Yuno's failing test] | [bucket] | [Issue link] | [sev] | [prio] | Yuno Dela Pena | [status] |
| JL-01 (TC-2): Failing grade (F) is counted as completed | Code bug | [#88](https://github.com/NoamGaribi/CS250-Agile/issues/88) | High | High | Jania Little | Fixed |

---

## 2. Regression Log

**No regressions found.** Full suite run on: 11/22/2026 (after merging the fix for #88: TC-1, TC-2, and TC-3 all pass).

---

## 3. Final Test Run

![Final test run](screenshots/final_test_run.png)

**Tests still failing after freeze:**

| Test name | Reason (one line) |
|---|---|
| | |

---

## 4. Feature Decision

- **Feature:** Degree Roadmap: show a student which required courses they still need after uploading their audit.
- **User story:** As an SDSU computer science student, I want to see a roadmap of the required courses I haven't completed yet, so that I can plan what to take next without checking my audit by hand.
- **Why we chose it:** It is a key part of the program's purpose, and without it the program is incomplete. The codebase already has the pieces it needs: `DegreeAudit.ts` parses completed courses, and `Roadmap.ts` and `PlanningPreferences.ts` are in `app/lib`.
- **Owners:** Sunny: Problem/Solution Framer · Yuno: Back-end · Jania: Front-end
- **Test cases we will use to know it works:**
  1. **Completed course excluded.** Upload an audit with `FA21 CS 150 3.0 B` and open the roadmap. Expected: CS 150 does not appear in the remaining courses, and the other required courses do.
  2. **Failed course still required.** Upload an audit with `FA21 CS 250 3.0 F` and open the roadmap. Expected: CS 250 does appear in the remaining courses, because a failed course doesn't satisfy the requirement.
- **Feature Issue:** [#21](https://github.com/NoamGaribi/CS250-Agile/issues/21)

---

## 5. Board Snapshot

![Project board](screenshots/board.png)

---

## 6. Sprint Summary

We ran the System Map Part 6 tests and our new edge-case tests against the inherited degree planner app. We found real bugs, including a course with an F grade being counted as completed and signup failing with a generic error on over-long input. We documented each one as a GitHub Issue and fixed it through an approved pull request. The audit parser no longer counts failing grades (F, NC, NP) as completed (#88), and signup now validates email and name length (#89, #92). Still broken: the audit upload always uses `degreeId = 1` instead of the student's own degree, and imported audits stay in `pending_review` with no way to confirm them. Next sprint, look first at audit confirmation, because the roadmap feature depends on reading confirmed audit data.
