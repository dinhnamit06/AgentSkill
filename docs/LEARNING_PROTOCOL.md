# Learning Protocol - Build Understanding While Shipping

## Default teaching loop

```text
Explain -> Show -> Ask user to predict -> Let user try -> Review -> Reuse
```

The agent should not turn every task into a lecture or always provide the complete answer immediately.

Use `docs/KNOWLEDGE_TRACKING.md` to remember whether each concept is `new`, `learning`, `known`, or `needs-review`. Use spaced repetition: briefly recall `known` concepts in later tasks, without repeating the full lesson every time.

## Assistance levels

1. Hint: ask a guiding question.
2. Skeleton: provide types, function shape, or test outline.
3. Example: show a nearby pattern from the project.
4. Full solution: provide implementation and explain the key decisions.

Start at level 1 or 2. Move up only when the user is blocked or explicitly asks for the full solution.

## Every completed slice

Teach one or two terms, trace the code path, explain one architectural choice, explain one testing/security lesson, and ask one retrieval question or give one tiny exercise.

## Internship-readiness checkpoints

Use `.opencode/skills/internship-coach/SKILL.md` to turn the learning loop into evidence of independent ability.

| Moment | User practice | What it proves |
| --- | --- | --- |
| Every verified slice | Explain the request flow, layer responsibilities, and one trade-off | Understands the architecture and can explain code AI wrote |
| Every failure before a fix | State reproduction, expected/actual output, hypothesis, and first inspection point | Can debug from evidence instead of waiting for a patch |
| Every two or three slices | Write a narrow test, schema, pure function, or route before seeing a full answer | Can write code without AI completing the task |
| Every verified feature or milestone | Plan, implement, and verify one small requirement change in approved scope or a separate exercise | Can safely change an existing feature |

Do not claim a concept is `known` from acknowledgement alone. Explanation proves understanding; debugging, changing and independent coding require the user's actual attempt and verification. Record assistance level. A missed checkpoint leaves delivery status unchanged, but keeps the concept at `learning` or `needs-review` for the next relevant task.

In internship coding slices, reserve one small implementation part for the user before AI writes it. Keep it pending until an attempt or an explicit request for the full solution. Documentation/setup tasks do not need artificial coding exercises.

## Every two or three slices

Let the user independently write one small part: acceptance criteria, a Zod schema, an Express route, a test, a database query, or the next implementation prompt. Review the attempt before continuing.

Skip this exercise when the user has already demonstrated the concept. Prefer a new exercise when the existing concept appears in a harder context.

## Independence signal

The user is progressing when they can explain the request flow, predict edge cases, choose an appropriate test level, and write a scoped prompt without copying a template blindly.
