# BeShort

**An AI engineering kit for shipping software while learning how it works.**

BeShort gives AI coding agents a repeatable workflow for any project: clarify, plan, build, verify, review, ship, and learn.

> BeShort is the example application. The workflow and skills are domain-agnostic.

## What makes it different

- Automatic skill routing from natural-language requests.
- Mandatory phase gates and one active slice at a time.
- Locked stack support: TypeScript, React, Node.js/Express, PostgreSQL, and Prisma.
- Learning in context: code, terminology, prompts, architecture, security, and trade-offs.
- User-controlled decisions for product scope, architecture, data, external access, and release.

## Lifecycle

```text
DEFINE -> PLAN -> BUILD -> VERIFY -> REVIEW -> SHIP -> LEARN
 Idea     Spec    Slice    Tests     QA        Release  Understand
```

Every task follows:

```text
DRAFT -> APPROVED -> PLANNED -> IMPLEMENTING -> VERIFIED -> REVIEWED -> DONE
```

## Quick start

Run the example:

```bash
npm install
cp .env.example .env
npm run prisma:generate
npm run build
npm test
npm run dev
```

Install into another project:

```powershell
.\install.ps1 -Target "C:\path\to\NewProject" -ProjectName "MyApp"
```

```bash
./install.sh ../MyNewApp MyApp
```

Then complete `docs/_meta/PROJECT_CONTEXT.md`.

## Integrate with any IDE or agent

The kit is plain Markdown plus optional scripts. It is not tied to BeShort or one editor.

See `docs/INTEGRATION.md` for the portable file set and verification checklist.

| Tool | Integration |
| --- | --- |
| OpenCode | Keep `.opencode/skills/` and `opencode.json` in the project |
| Claude Code | Copy `AGENTS.md` and skills into the project or Claude skills directory |
| Codex | Keep `AGENTS.md`; install the skill folders through the Codex skill/plugin mechanism |
| Cursor | Keep `AGENTS.md`; copy relevant skills into `.cursor/skills/` and rules into `.cursor/rules/` |
| GitHub Copilot | Keep `AGENTS.md`; include the operating rules from it in `.github/copilot-instructions.md` |
| Gemini CLI | Keep `AGENTS.md` and expose the skill folders through the project's Gemini skills setup |
| Windsurf | Keep `AGENTS.md`; map the workflow rules into Windsurf rules and skills |
| Any other agent | Give the agent `AGENTS.md`, `.opencode/skills/`, and the relevant `docs/` files |

For a new project, copy the kit files, fill `docs/_meta/PROJECT_CONTEXT.md`, and start with a natural-language request. Users do not need to memorize slash commands.

## Automatic skill routing

| User intent | Agent route |
| --- | --- |
| Vague idea | Requirements discovery |
| Approved requirements | Planning and task breakdown |
| Task ready to implement | Prompt generation and coaching |
| Logic change | TDD |
| Input, auth, data, integration | Security |
| Broken test, build, API, or UI | Evidence-driven debugging |
| React UI work | Frontend React and browser testing |
| Ready to merge | Review |
| Ready to release | CI/CD, deployment, observability, rollback |
| Completed slice | Learning and spaced repetition |

## Learning modes

| Mode | Best for | Behavior |
| --- | --- | --- |
| `LEARNER` | New concepts | Explain, hint, review user attempts |
| `ENGINEER` | Known concepts | Move faster, keep quality gates |
| `ADAPTIVE` | Default | Teach unfamiliar or risky concepts; recall known concepts briefly |

## Quality gates

```bash
npm test
npm run build
npx tsc --noEmit
npm run security:audit
npm run workflow:check
```

See `docs/PRODUCTION_DOD.md` for the frontend, backend, security, deployment, monitoring, rollback, and learning completion checklist.

## Repository map

- `AGENTS.md` - always-loaded operating rules and automatic routing
- `.opencode/skills/` - lifecycle skills
- `docs/PHASE_GATES.md` - mandatory state machine
- `docs/LEARNING_MAP.md` - TypeScript/React/Express/PostgreSQL curriculum
- `docs/KNOWLEDGE_TRACKING.md` - adaptive spaced repetition
- `docs/PROMPT_PATTERNS.md` - prompt patterns and coaching
- `docs/GLOSSARY.md` - practical engineering terms
- `docs/` - workflow, specs, templates, reviews, and worklogs
- `src/features/links/` - BeShort example feature
- `scripts/workflow-check.ps1` - phase-state validator

## Contributing

Keep changes focused and UTF-8 encoded. Add tests for behavior changes, document non-obvious decisions, preserve the locked stack, and use attributable atomic commits.

## License

No license has been selected yet. Add one before publishing this kit for external reuse.
