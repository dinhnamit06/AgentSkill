# BeShort

**Production-minded workflows for AI coding agents.**

BeShort is a portable Vibe Coding Kit: requirements, specs, prompts, implementation, testing, review, and shipping are connected into one repeatable workflow. The repository also contains a working URL-shortener example built with TypeScript, Fastify, Prisma, and PostgreSQL.

## Lifecycle

```text
DEFINE -> PLAN -> BUILD -> VERIFY -> REVIEW -> SHIP
 Idea     Spec    Slice    Test      QA        Git
```

The core rule is simple: one small vertical slice at a time, with evidence before moving on.

## Skills

| Skill | Purpose | Output |
| --- | --- | --- |
| `/lay-yeu-cau` | Ask focused business questions | BIZ and SPEC |
| `/tao-prompt` | Turn an approved spec into an implementation prompt | Six-block PROMPT |
| `/hoc-tap` | Explain code, architecture, security, and trade-offs | Learning notes |

Skills live in `.opencode/skills/` and are supported by `AGENTS.md`, project documentation, and templates under `docs/`.

## Quick start

```bash
npm install
cp .env.example .env
npm run prisma:generate
npm run build
npm test
npm run dev
```

The API runs at `http://localhost:3000`; health check: `GET /health`.

Install into another project:

```powershell
.\install.ps1 -Target "C:\path\to\NewProject" -ProjectName "MyApp"
```

```bash
./install.sh ../MyNewApp MyApp
```

After installation, complete `docs/_meta/PROJECT_CONTEXT.md` before implementation.

## Quality gates

Every slice should pass:

```bash
npm test
npm run build
npx tsc --noEmit
npm run security:audit
```

Do not commit secrets, change the database without a reviewed migration, or build UI before the underlying logic is tested.

## Project structure

- `AGENTS.md` - agent rules and operating boundaries
- `docs/` - workflow, business requirements, specs, prompts, tasks, reviews, and worklogs
- `.opencode/skills/` - reusable agent skills
- `src/features/links/` - URL-shortener feature
- `src/lib/` - framework-independent utilities
- `src/db/` - Prisma database client

## Current status

The first slice includes link persistence, slug generation, API routes, Prisma migration, and tests. UI and click analytics are planned follow-up slices.

## Contributing

Keep changes focused, document non-obvious decisions, add tests for behavior changes, and use atomic commits with clear attribution such as `AI PROMPT-001` or `human @name`.

## License

No license has been selected yet. Add one before publishing this kit for external reuse.
