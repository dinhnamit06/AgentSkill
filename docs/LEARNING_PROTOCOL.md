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

## Learning while coding

Use `.opencode/skills/internship-coach/SKILL.md` to keep learning inside the coding loop and reduce help over time. The aim is transfer, not proof or scoring.

| Moment | Coaching loop | Dependency guardrail |
| --- | --- | --- |
| Every verified slice | Explain one flow and one decision, then offer one nearby thing to read or try | Next task uses less explanation when the pattern is familiar |
| Every failure before a fix | Ask for reproduction and a first hypothesis, then move from hint to skeleton to solution as needed | AI does not hide the debugging path |
| Every two or three slices | Offer a short no-copy exercise: test, schema, pure function, or route | User gets spaced practice without turning every task into an exam |
| Every verified feature or milestone | Offer a small requirement change for the user to try, with AI review | Assistance fades for feature changes; choosing later is allowed |

Use `new`, `learning`, `known`, and `needs-review` to choose the next help level, not to rank the user. A missed exercise leaves delivery unchanged and becomes a small follow-up item.

For an unfamiliar coding slice, begin with Explain, Hint, or Skeleton before Full solution. If the user asks to ship quickly or is blocked, provide the authorized solution and return later with a smaller adjacent practice task. Documentation/setup tasks do not need artificial coding exercises.

## Every two or three slices

Let the user independently write one small part: acceptance criteria, a Zod schema, an Express route, a test, a database query, or the next implementation prompt. Review the attempt before continuing.

Skip this exercise when the user has already demonstrated the concept. Prefer a new exercise when the existing concept appears in a harder context.

## Independence signal

The user is progressing when they can explain the request flow, predict edge cases, choose an appropriate test level, and write a scoped prompt without copying a template blindly.
