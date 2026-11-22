# PR4 TEAM REPORT

**Team number:** 09
**Members:** Sunny, Suarez, Yuno Dela Pena, Jania Little

---

## 1. Bug Triage Table

| Test name | Bucket | Issue link | Severity | Priority | Owner | Status |
|---|---|---|---|---|---|---|
| SS-06: Signup with a 300-character email shows a generic error | Code bug | https://github.com/NoamGaribi/CS250-Agile/issues/89 | Low | Low | Sunny Suarez | Fixed |
| SS-07: Signup with a 300-character name shows a generic error | Code bug | https://github.com/NoamGaribi/CS250-Agile/issues/92 | Low | Low | Sunny Suarez | Fixed |
| [Yuno's failing test] | [bucket] | [Issue link] | [sev] | [prio] | Yuno Dela Pena | [status] |
| [Jania's failing test]  | Code bug | [Issue link] | Major | High | Jania Little | [Fixed / Open] |

---

## 2. Regression Log

**No regressions found.** Full suite run on: 11/22.

---

## 3. Final Test Run

![Final test run] (screenshots/final_test_run.png)

Tests still failing after freeze:

---

## 4. Feature Decision

- **Feature:** Degree Roadmap: show a student which required coursees they still need after uploading the audit.
- **User story:** As a SDSU computer science student, I want to see a roadmap of the required courses I haven't completed yet, so that I can plan what to take next without checking my audit by hand.
- **Why we chose it:** We chose to implement this feature as it is a key piece of this programs purpose - and without this feature, the program is lacking. The codebase already has the pieces it needs: DegreeAudit.ts parses completed courses and Roadmap.ts and Planning Preferences.ts are in app/lib.
- **Owners:** [Sunny: Problem/Solution Framer], [Yuno: Back-end], [Jania: Front-end]
- **Test cases we will use to know it works:**
1. Completed course excluded. Upload an audit with FA21 CS 150 3.0 B and open the roadmap. Expected: CS 150 does not appear in the remaining courses, and the other required courses do.
2. Failed course still required. Upload an audit with FA21 CS 250 3.0 F. Expected: CS 150 does appear in the remaining courses, because a failed course doesn't satisfy the requirement.
- ** Feature Issue:** https://github.com/NoamGaribi/CS250-Agile/issues/21

---

## 6. Sprint Summary

We ran the System Map Part 6 tests and our new edge-case tests against the inherited degree planner app. We found real bugs, including a course with an F grade counted as completed and a signup crashing on over-long input. We documented them as GitHub issues and fixed them through approved pull requests.
| JL-01:  | Code bug | [Issue link] | Major | High | Jania Little | [Fixed / Open] |
| SS-06: Signup with a 300-character email shows a generic error | Code bug | https://github.com/NoamGaribi/CS250-Agile/issues/89 | Low | Low | Sunny Suarez | Fixed |
| SS-07: Signup with a 300-character name shows a generic error | Code bug | https://github.com/NoamGaribi/CS250-Agile/issues/92 | Low | Low | Sunny Suarez | Fixed |
| [Yuno's failing test] | [bucket] | [Issue link] | [sev] | [prio] | Yuno Dela Pena | [status] |
|  |  |  |  |  |  |  |
