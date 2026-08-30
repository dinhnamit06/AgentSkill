# AgentSkill — Vibe Coding Kit

**Production-grade engineering skills for AI coding agents. Ship software while learning how it works.**

Skills encode the workflows, quality gates, and teaching loops that senior engineers use — packaged so any AI agent follows them consistently across every phase of development.

> BeShort (URL shortener like bit.ly) is the worked example. The kit itself is domain-agnostic — use it for web, mobile, backend, data, or automation.

[![Kit](https://img.shields.io/badge/kit-v1.0-blue)](#)
[![Stack](https://img.shields.io/badge/stack-TS%205%20%E2%80%A2%20React%2018%20%E2%80%A2%20Node%2022%20%E2%80%A2%20Postgres%2016-black)](#)
[![Skills](https://img.shields.io/badge/skills-17-green)](#all-17-skills)
[![License](https://img.shields.io/badge/license-MIT-lightgrey)](#license)

```
  DEFINE         PLAN          BUILD         VERIFY        REVIEW         SHIP          LEARN
┌──────┐     ┌──────┐     ┌──────┐     ┌──────┐     ┌──────┐     ┌──────┐     ┌──────┐
│ Idea │────▶│ Spec │────▶│ Code │────▶│ Test │────▶│  QA  │────▶│  Go  │────▶│Understand│
│Refine│     │  PRD │     │ Impl │     │Debug │     │ Gate │     │ Live │     │Retention │
└──────┘     └──────┘     └──────┘     └──────┘     └──────┘     └──────┘     └──────┘
 /lay-yeu-cau  /tao-ke-hoach /tao-prompt  /tdd  /review  /ship   /hoc-tap
                              + tdd/security   + security  + ci-cd/deploy
```

Every change follows the mandatory state machine:

```
DRAFT → APPROVED → PLANNED → IMPLEMENTING → VERIFIED → REVIEWED → DONE
```

No phase is skipped. See `docs/PHASE_GATES.md` for the full gate definition.

---

## Commands

8 commands that map to the development lifecycle. You rarely need to type them — `using-vibe-coding` routes natural language automatically.

| What you're doing | Command | Key principle |
| --- | --- | --- |
| Idea is vague or missing scope | `/lay-yeu-cau` | Spec before code |
| Approved spec needs breakdown | `/tao-ke-hoach` | Small, verifiable tasks |
| Task ready to implement | `/tao-prompt` | One prompt = one vertical slice |
| Writing or changing logic | `/tdd` | Red → Green → Refactor |
| Touching input, auth, data, or network | `/security` | Validate at the boundary |
| Tests fail, build breaks, or UI is wrong | `debugging` | Reproduce → Localize → Reduce → Fix → Guard |
| Ready to merge | `/review` | Five-axis review before merge |
| Ready to release or ship | `/ship` | Verify, then ship with rollback awareness |

Completed task/slice? `/hoc-tap` runs **automatically** at `ADAPTIVE` level — you don't need to ask. See `docs/15_HOC_VIBE.md`.

Skills also activate automatically: designing an API triggers `api` concerns, building UI triggers `frontend-react` and `browser-testing`, releasing triggers `ci-cd`/`deployment`/`observability`/`rollback`.

---

## Quick start

### Option A — Solo in 1 minute (3 files)

Best when you work alone and want the smallest setup. Global skills are already in `~/.config/opencode/skills`.

```powershell
# 1. create a new repo
mkdir MyApp; cd MyApp; git init

# 2. copy the minimal kit
Copy-Item "C:\path\to\AgentSkill\AGENTS.md" .
New-Item -ItemType Directory -Force -Path "docs/_meta" | Out-Null
Copy-Item "C:\path\to\AgentSkill\docs\_meta\PROJECT_CONTEXT.template.md" "docs/_meta/PROJECT_CONTEXT.md"

# 3. wire OpenCode to global skills
@'
{
  "$schema": "https://opencode.ai/config.json",
  "skills": { "paths": ["C:/Users/Admin/.config/opencode/skills"] },
  "mcp": {
    "vibe-coding": {
      "type": "local",
      "command": ["node", "C:/Users/Admin/.config/opencode/mcp-server/dist/index.js"],
      "enabled": true
    }
  }
}
'@ | Set-Content -Path "opencode.json" -Encoding UTF8

# 4. restart your IDE, then:
# /lay-yeu-cau  → describe your idea in plain language
```

See `docs/SOLO_STARTER.md:1` for the full checklist.

### Option B — Full kit (recommended for teams)

```powershell
.\install.ps1 -Target "C:\path\to\NewProject" -ProjectName "MyApp"
# or
./install.sh ../MyNewApp MyApp
```

Then fill `docs/_meta/PROJECT_CONTEXT.md` and run `/lay-yeu-cau`.

### Option C — Run the BeShort example

```bash
npm install
cp .env.example .env
npm run prisma:generate
npm run build
npm test
npm run dev
```

BeShort implements `src/features/links/` (create + redirect with Postgres + Prisma + Fastify + Zod) as a reference vertical slice.

---

## All 17 skills

The commands above are entry points. The pack includes 17 skills total — one coordinator plus 16 lifecycle skills. Each skill is a structured workflow with steps, verification gates, and anti-rationalization checks.

### Meta — Discover which skill applies

| Skill | What it does | Use when |
| --- | --- | --- |
| `using-vibe-coding` | Maps natural-language work to the right skill workflow and enforces phase gates | Starting any session or deciding which skill applies |

### Define — Clarify what to build

| Skill | What it does | Use when |
| --- | --- | --- |
| `lay-yeu-cau` | Socratic 5 Whys → `BIZ-xxx.md` + `SPEC-xxx.md` (Zod, Prisma, API contract) | Idea is underspecified or spec is missing |

### Plan — Break it down

| Skill | What it does | Use when |
| --- | --- | --- |
| `tao-ke-hoach` | Decompose a spec into small ordered tasks with acceptance criteria and risks | You have an approved spec and need implementable units |

### Build — Write the code

| Skill | What it does | Use when |
| --- | --- | --- |
| `tao-prompt` | Turn a task into a 6-block implementation prompt (context/scope/files/examples/constraints/verify) | Delegating a coding task to an agent |
| `tdd` | Red-Green-Refactor, test pyramid, focused unit/integration/E2E tests | Implementing logic, fixing bugs, changing behavior |
| `prompt-coaching` | Teaches precise prompt writing with contracts and verification | Creating or improving an implementation prompt |
| `frontend-react` | Accessible React components, typed boundaries, responsive states, colocated tests | Building or modifying UI |
| `security` | Input validation, auth, secrets, S1–S8 checklist, OWASP Top 10 | Handling input, auth, data, or integrations |

### Verify — Prove it works

| Skill | What it does | Use when |
| --- | --- | --- |
| `debugging` | Reproduce → localize → reduce → fix → guard with regression test | Tests fail, builds break, or behavior is unexpected |
| `browser-testing` | Verify critical React journeys in a real browser (nav/forms/API/loading/error/a11y/responsive) | Before review or release for UI changes |

### Review — Quality gates before merge

| Skill | What it does | Use when |
| --- | --- | --- |
| `review` | Five-axis review: correctness / readability / architecture / security / performance | Before merging any change |

### Ship — Deploy with confidence

| Skill | What it does | Use when |
| --- | --- | --- |
| `ci-cd` | Pipelines, quality gates, migrations, automated deployment | Adding pipelines or release checks |
| `deployment` | Environments, health checks, smoke tests, secrets, rollback | Staging or production delivery |
| `observability` | Logging, metrics, health checks, error visibility without leaking secrets | Before production or when diagnosing runtime |
| `rollback` | Recovery from failed releases, migrations, or config changes | Before prod deploy and whenever recovery is hard |
| `ship` | Clean diff, atomic commit, release notes, authorized push | After review passes and checks are green |

### Learn — Retain what you built

| Skill | What it does | Use when |
| --- | --- | --- |
| `hoc-tap` | Explains 5 essentials: code + architecture + prompt + domain + security, with spaced repetition | After every verified slice (automatic) or when you ask why/how |

---

## How skills work

Every skill follows a consistent anatomy:

```
┌────────────────────────────────────────────────┐
│  SKILL.md                                      │
│  ┌─ Frontmatter ─────────────────────────────┐ │
│  │ name: lowercase-hyphen-name               │ │
│  │ description: Guides agents through [task].│ │
│  │              Use when…                    │ │
│  └───────────────────────────────────────────┘ │
│  Overview        → What this skill does        │
│  When to Use     → Triggering conditions       │
│  Process         → Step-by-step workflow       │
│  Verification    → Evidence requirements       │
└────────────────────────────────────────────────┘
```

* **Process, not prose.** Skills are workflows agents follow — steps, checkpoints, exit criteria.
* **Verification is non-negotiable.** Every skill ends with evidence: tests, build output, typecheck, or runtime data.
* **Progressive disclosure.** `SKILL.md` is the entry point; supporting checklists load only when needed.

---

## Project structure

```
AgentSkill/
├── AGENTS.md                      # Always-loaded operating rules + auto-routing
├── opencode.json                  # OpenCode skills + MCP wiring
├── .opencode/skills/              # 17 skills (1 meta + 16 lifecycle)
│   ├── using-vibe-coding/         #   coordinator
│   ├── lay-yeu-cau/               #   define
│   ├── tao-ke-hoach/              #   plan
│   ├── tao-prompt/                #   build
│   ├── tdd/                       #   build/verify
│   ├── frontend-react/            #   build
│   ├── security/                  #   build/review
│   ├── debugging/                 #   verify
│   ├── browser-testing/           #   verify
│   ├── review/                    #   review
│   ├── ci-cd/                     #   ship
│   ├── deployment/                #   ship
│   ├── observability/             #   ship
│   ├── rollback/                  #   ship
│   ├── ship/                      #   ship
│   └── hoc-tap/                   #   learn
├── docs/
│   ├── 00_WORKFLOW.md             # Lifecycle DRAFT→DONE
│   ├── PHASE_GATES.md             # Mandatory state machine
│   ├── OPERATING_MODES.md         # LEARNER / ENGINEER / ADAPTIVE
│   ├── 01_TECH_STACK.md           # Stack selection with trade-offs
│   ├── _meta/PROJECT_CONTEXT.md   # Single source of truth per project
│   ├── 02_BUSINESS/               # BIZ templates + example BIZ-001
│   ├── 03_SPEC/                   # SPEC templates + example SPEC-001
│   ├── 04_PROMPTS/                # Prompt templates + example PROMPT-001
│   ├── 05_TASKS/                  # Task board + TASK-001
│   ├── 06_REVIEW/ 07_WORKLOG/     # Reviews + evidence
│   ├── 11_KIEN_TRUC.md            # Architecture: feature folders, layers
│   ├── 20_CODE_CRAFTSMANSHIP.md   # ≤300/≤50, naming, DRY, YAGNI
│   ├── SOLO_STARTER.md            # 3-file solo path
│   └── INTEGRATION.md             # Portable file set + verification
├── src/features/links/            # BeShort example feature (route→service→db)
├── mcp-server/                    # Local MCP for vibe-coding
└── scripts/                       # security-audit.ps1, workflow-check.ps1
```

---

## Integrate with any IDE or agent

The kit is plain Markdown plus optional scripts. It is not tied to one editor.

See `docs/INTEGRATION.md` for the portable file set and verification checklist.

| Tool | Integration |
| --- | --- |
| OpenCode | Keep `.opencode/skills/` and `opencode.json` in the project |
| Claude Code | Copy `AGENTS.md` and skills into the project or Claude skills directory |
| Codex | Keep `AGENTS.md`; install skill folders via Codex plugin mechanism |
| Cursor | Keep `AGENTS.md`; copy skills into `.cursor/skills/` and rules into `.cursor/rules/` |
| GitHub Copilot | Keep `AGENTS.md`; include its rules in `.github/copilot-instructions.md` |
| Gemini CLI | Keep `AGENTS.md` and expose skill folders via Gemini skills setup |
| Windsurf | Keep `AGENTS.md`; map workflow rules into Windsurf rules |
| Any other agent | Give the agent `AGENTS.md`, `.opencode/skills/`, and relevant `docs/` files |

Users never need to memorize slash commands — describe the outcome and the coordinator picks the skill.

---

## Learning modes

| Mode | Best for | Behavior |
| --- | --- | --- |
| `LEARNER` | New concepts | Explain, hint, review your attempts |
| `ENGINEER` | Known concepts | Move faster, keep quality gates |
| `ADAPTIVE` | Default | Teach unfamiliar/risky concepts in depth; recall known concepts briefly via spaced repetition |

Every verified slice automatically triggers `hoc-tap` at `ADAPTIVE` unless you switch modes. Your knowledge is tracked in `docs/KNOWLEDGE_TRACKING.md` (`new` → `learning` → `known` → `needs-review`).

---

## Quality gates

Run before concluding any slice — `git push` is blocked until these pass (pre-push hook):

```bash
npm test
npm run build
npx tsc --noEmit
powershell -File scripts/security-audit.ps1   # S1–S8
powershell -File scripts/workflow-check.ps1   # phase + evidence
```

See `docs/PRODUCTION_DOD.md` for the full frontend / backend / security / deployment / monitoring / rollback / learning checklist.

## Why AgentSkill?

AI coding agents default to the shortest path — skipping specs, tests, security, and review. This kit gives agents the same discipline senior engineers bring to production code: small slices, type-first specs, tested boundaries, explicit decisions, and learning that sticks.

It bakes in:

* Locked stack with explicit trade-offs (`docs/01_TECH_STACK.md`)
* Feature-folder architecture (`docs/11_KIEN_TRUC.md:1`) and craftsman limits (`docs/20_CODE_CRAFTSMANSHIP.md:1` — ≤300 lines/file, ≤50 lines/function)
* Security S1–S8 and privacy consent (`docs/12_BAO_MAT.md:1`)
* UTF-8 enforcement and mojibake guard (`AGENTS.md:2.1`)
* Attributable atomic commits (`AI PROMPT-xxx` / `human @name`)

Inspired by the structure of [`addyosmani/agent-skills`](https://github.com/addyosmani/agent-skills), adapted for the locked TypeScript/React/Node/Postgres stack and the BeShort example.

---

## Contributing

* Keep changes focused, UTF-8 encoded (`docs/README.md:Encoding`), and attributable.
* Add tests for behavior changes; document non-obvious decisions with a link to `SPEC-xxx` or `ADR-xxx`.
* Preserve the locked stack; any dependency needs rationale + bundle/security impact.
* One task = one commit = one checkpoint; never mix refactor + feature.

See `AGENTS.md` and `docs/14_CODE_READING_GUIDE.md:2` for the required header (`Who + Why + Link to SPEC/PROMPT`).

## License

MIT — see `LICENSE`. No license was selected in earlier commits; add `LICENSE` before publishing for external reuse if missing.

## Related

* Reference inspiration: [`addyosmani/agent-skills`](https://github.com/addyosmani/agent-skills)
* Kit docs index: `docs/README.md`
* Solo starter: `docs/SOLO_STARTER.md:1`
* Integration: `docs/INTEGRATION.md`

---

*Kit version: v1.0 — Portable. Install via `.\install.ps1` or `bash install.sh`. Stack details: `docs/01_TECH_STACK.md` + `docs/_meta/PROJECT_CONTEXT.md`.*
