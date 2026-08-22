# Project: {{PROJECT_NAME}} - Vibe Coding Kit

> Copy file nay sang moi du an. Chi sua khoi `PROJECT_CONTEXT` (tro toi `docs/_meta/PROJECT_CONTEXT.md`). Moi quy tac duoi day la **Level 1 Context** - luon duoc load.

## 1. Tech Stack - Nguon chan ly: `docs/_meta/PROJECT_CONTEXT.md`

| Lop | Lua chon mac dinh | Thay the khi can |
|-----|-------------------|------------------|
| Frontend | TypeScript 5, React 18 (Vite), Tailwind CSS 4, shadcn/ui | Next.js neu can SSR/SEO |
| Backend | TypeScript, Node.js 22, Express / Fastify | — |
| Database | TBD - chon sau khi co BIZ/SPEC (mac dinh: PostgreSQL 16 + Prisma) | MongoDB neu linh dong, SQLite neu demo |
| Mobile | Dart + Flutter 3.x | — |
| Auth/Storage | Supabase Auth, S3-compatible | — |

> **Quy tac:** Core (FE/BE) chon o Pha 1, DB chon sau khi co BIZ/SPEC o Pha 2 (xem 00_WORKFLOW.md + 01_TECH_STACK.md). Khong tu y doi stack. Doc `docs/01_TECH_STACK.md` + `docs/_meta/PROJECT_CONTEXT.md` truoc. Neu trong -> hoi user.

## 2. Commands - chay truoc khi ket luan

```bash
npm run dev        # chay local
npm test           # toan bo test (vitest/jest)
npm run build      # build prod
npm run lint --fix # lint
npx tsc --noEmit   # type check
# Sau moi slice DONE:
git add <files> && git commit -m "feat(scope): AI PROMPT-xxx — ..." && git push
git tag -a v0.1.0 -m "BIZ-xxx Done" && git push origin v0.1.0  # khi xong 1 BIZ
```

* Sau moi slice: `npm test` + `npm run build` + `npx tsc --noEmit` + `powershell -File scripts/security-audit.ps1` (S1-S8 PASS moi duoc `git push` — pre-push hook se chan neu ho) — xem `17_GIT_VERSIONING.md:3` + `12_BAO_MAT.md:2`.
* Khong lap lai cung lenh khi code chua doi.

## 3. Workflow 5 pha - BAT BUOC

```
Pha 1: Chon cong nghe (01_TECH_STACK) → User Review
Pha 2: Nghiep vu (02_BUSINESS) → Skill lay-yeu-cau → Spec (03_SPEC) → User Review
Pha 3: Skill tao-prompt → Prompt (04_PROMPTS) → Code Logic 1 slice (05_TASKS) → TDD (08_TESTING)
Pha 4: Review 5-axis (06_REVIEW) → Worklog (07_WORKLOG)
Pha 5: UI/UX (09_UIUX) — CHI sau khi logic pass 100%
```

* Moi pha co Definition of Done trong `docs/00_WORKFLOW.md`.
* Moi lan chi xu ly **1 chuc nang nho** (1 TASK = 1 vertical slice DB+API+test, chua UI).

## 4. Code Conventions - Tho code & Kien truc su (ngan gon, de scale)

* **Header 3 Biet bat buoc** cho moi file AI tao: `Ai viet + Tai sao chon tech/cau truc + Link toi SPEC/PROMPT` — xem `docs/14_CODE_READING_GUIDE.md:2`.
* **Tho code (ngan gon, de hieu):** File ≤300 dong, ham ≤50 dong & 1 viec, ten ro nghia (khong data/tmp/result), khong magic number (dat const SLUG_LEN=6 + WHY), early return it long, DRY 3 lan → tach, khong comment WHAT chi WHY — xem `docs/20_CODE_CRAFTSMANSHIP.md:2`.
* **Kien truc su (de mo rong, de scale):** Tach bien Route(validate) → Service(BR) → DB(Prisma), chia theo feature src/features/links/ (khong theo loai file), YAGNI khong lam thua, config bang env khong hardcode, do truoc toi uu sau — xem `docs/20_CODE_CRAFTSMANSHIP.md:3`.
* **Cau truc file chuan:** `src/features/<ten>/` moi feature 1 folder, `src/lib/` ham thuan khong DB, `src/db/` chi Prisma — xem `docs/11_KIEN_TRUC.md:1`.
* **Attribution:** Commit ghi ro `AI PROMPT-xxx` hay `human @ten` — de git blame la biet ai, git log la truy duoc prompt.
* Functional components + hooks (khong class), named exports (khong default), colocate test: Button.tsx → Button.test.tsx.
* Dung cn() cho classNames, zod cho validation, date-fns cho date.
* Error handling: dung Result<T,E> hoac custom Error class, khong throw string.
* Moi quyet dinh kho hieu phai co link SPEC-xxx hoac ADR-xxx trong header/comment.
* **Prompt khoi 5 bat buoc co:** `Tho + kien truc su: ≤300/≤50, ten ro, DRY/YAGNI, tach bien, header 3 Biet` — xem `docs/15_HOC_VIBE.md:1`.

## 5. Boundaries - Khong bao gio

* Khong commit `.env`, secrets, `node_modules`.
* Khong tu y doi DB schema — hoi truoc (`docs/06_REVIEW`).
* Khong them dependency khi chua check bundle size + `npm audit`.
* Khong gop refactor + feature trong 1 commit.
* Khong lam UI khi logic chua co test xanh.
* **Khong tu tien lay GitHub/API/thong tin ca nhan** — phai hoi consent truoc (xem `docs/12_BAO_MAT.md:1`): hoi link repo, API key, email... → cho user cap → moi fetch/dung. Thieu thi dung mock + ghi `MOCK`.

## 6. Patterns - Vi du chuan

```typescript
// Good: tach bien, ham 1 viec, ten ro, early return, khong magic number
import { z } from "zod";

const SLUG_LEN = 6; // WHY: BR1 — 6 ky tu du 56B to hop
export const CreateLinkSchema = z.object({
  url: z.string().url().max(2048),
});
export type CreateLinkInput = z.infer<typeof CreateLinkSchema>;

// Route: chi validate → goi service
export async function createLinkRoute(req, reply) {
  const input = CreateLinkSchema.parse(req.body); // WHY: validate o boundary
  const result = await createLinkService(input);
  return reply.code(201).send(result);
}
// Service: chua BR, retry 3
export async function createLinkService(input: CreateLinkInput) {
  const slug = await generateUniqueSlug(); // WHY: tach lib/slug.ts de test khong DB
  return db.link.create({ data: { slug, originalUrl: input.url } });
}
// Test: colocated — links.test.ts
```

## 7. Context Loading - Truoc khi code

1. Doc `docs/_meta/PROJECT_CONTEXT.md` + spec lien quan (`03_SPEC/SPEC-xxx.md`).
2. Doc file se sua + 1 vi du pattern tuong tu trong codebase.
3. Chi load <2000 dong context lien quan (Selective Include).
4. Neu spec thieu → dung va hoi (khong tu bia).

## 8. Skills

* `/lay-yeu-cau` → lay yeu cau → sinh `02_BUSINESS` + `03_SPEC`.
* `/tao-prompt` → bien spec thanh `04_PROMPTS` toi uu (6 khoi).
* `/hoc-tap` → giai thich tinh hoa vua lam (code + kien truc + prompt + nghiep vu + bao mat) — go sau moi TASK Done.
* Luong: `Idea → lay-yeu-cau → User Review → tao-prompt → Code 1 slice → /hoc-tap → Review → Worklog`.

## 9. Goc nhin 3 vai + Hoc trong hoi thoai (moi cau tra loi phai co)

* **Dev (lam):** code chay, test xanh.
* **Mentor (day):** giai thich tai sao lam vay, trade-off — neu user la new dev thi giu don gian, vi du BeShort, san sang giai thich line-by-line.
* **PM (quan ly):** task chia nho, estimate, rui ro, DoD.
* **Hoc ma khong can doc md:** Sau moi slice, AI chu dong hoi 1 cau trong `docs/15_HOC_VIBE.md:C` + goi y next step A/B/C de user quyet. Chi tro `docs/xx:line` khi user muon dao sau.

---
*Kit version: v1.0 — Portable. De cai vao du an moi: chay `.\install.ps1` hoac `bash install.sh`. Xem `docs/00_WORKFLOW.md:1`.*
*Kien truc file chuan: `docs/11_KIEN_TRUC.md:1` | Tho code: `docs/20_CODE_CRAFTSMANSHIP.md:1`*
