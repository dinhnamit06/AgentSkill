---
name: hoc-tap
description: Teach what was built, why its design works, and relevant testing or security trade-offs. Use after a verified slice or when the user asks to understand project code.
---

# Learn from the work

> Author: AI (Codex). WHY: concise explanation supports practice without treating a lecture as mastery. Prompt: `docs/04_PROMPTS/PROMPT-002_InternshipCoach.md` (project root).

Use automatically after a verified slice, or when the user asks why/how. Default to ADAPTIVE; follow an explicit preference for more or less depth. No completed task is required to explain existing code.

## Explain only what helps this task

Read the relevant code and project learning context. Give at most three short takeaways, one or two sentences each:

1. Code: what input becomes what output, and one important edge case.
2. Architecture: trace the relevant path and explain one boundary or trade-off.
3. Testing/security: what the actual checks prove, and what they leave unverified.

Include prompt or business decisions inside those takeaways only when relevant. Use the project's real files and tests, not invented timings, percentages, or claims that validation alone prevents every security issue. Explain line by line only when requested.

## Hand off to practice

For an internship/learning goal, use `internship-coach` for one relevant question or exercise. Coordinate the two skills so the user receives at most one practice question in the response, not one from each skill.

Do not infer independent coding ability from correct answers about code. Record explanations as explanation evidence; record debugging, feature changes and independent coding only from the user's attempt and appropriate verification. Unanswered practice stays pending.

Keep an explicit request to finish/ship moving within its authorization. Give the recap and leave pending practice recorded without inventing knowledge gains.

Project references: `docs/LEARNING_PROTOCOL.md`, `docs/KNOWLEDGE_TRACKING.md`, and `docs/LEARNING_MAP.md`. Load only relevant material and write UTF-8.
