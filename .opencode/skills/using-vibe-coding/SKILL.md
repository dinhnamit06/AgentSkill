---
name: using-vibe-coding
description: Orchestrate the complete AI-assisted development lifecycle for any project. Use automatically for natural-language requests involving product ideas, features, bugs, refactors, tests, reviews, releases, or learning. Select and sequence the right project skills without requiring the user to know slash commands.
---

# Skill: Using Vibe Coding

Act as the workflow coordinator. The user describes the outcome in natural language; do not ask them to choose a skill or command.

## Operating loop

1. Load `AGENTS.md`, `docs/_meta/PROJECT_CONTEXT.md`, and only the relevant project files.
2. Classify the request as idea, clarification, planning, implementation, bug, review, release, or learning.
3. Select the smallest set of skills needed from the routing table below.
4. Tell the user the current stage and the next decision in one or two sentences.
5. Execute one small slice, then verify before expanding scope.
6. Pause for user approval only at product, architecture, destructive, external-access, or release decisions.
7. End each completed slice with a compact teaching note: code, architecture, and security/testing lesson.

## Routing table

| Situation | Apply |
| --- | --- |
| Vague idea or missing constraints | `lay-yeu-cau` |
| Approved requirements or spec | `tao-ke-hoach` |
| Task ready for implementation | `tao-prompt`, then implementation rules in `AGENTS.md` |
| Behavior or logic change | `tdd` |
| User input, auth, data, network, or third-party integration | `security` |
| Test/build failure or unexpected behavior | Diagnose, reproduce, localize, reduce, fix, and add a regression test |
| Change ready to merge | `review` |
| Review and verification passed | `ship` |
| User asks why/how or slice is complete | `hoc-tap` |

Combine skills when the request crosses boundaries. For example, an authenticated API feature uses planning, prompting, TDD, security, review, ship, and learning; do not wait for the user to invoke each one.

## Teaching contract

Keep implementation momentum while teaching. Explain only the decisions relevant to the current slice, use the project's own code as the example, and ask at most one short learning question after completion.

## Safety contract

Do not invent missing requirements, credentials, private data, or external consent. Do not push, deploy, delete, migrate production data, or change a remote unless the user has authorized that action. When blocked, state the missing decision and offer the smallest safe next step.

## Manual commands

Slash commands remain optional shortcuts for advanced users. Never require `/lay-yeu-cau`, `/tdd`, `/review`, or another command when the natural-language request already provides enough context.
