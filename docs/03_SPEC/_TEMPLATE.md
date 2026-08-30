# SPEC-XXX: [TÃªn chá»©c nÄƒng] â€” Template (lay-yeu-cau phase)

> Copy thÃ nh `SPEC-001_Ten.md`. Äiá»n sau khi BIZ Ä‘Ã£ Approved. ÄÃ¢y lÃ  â€œhá»£p Ä‘á»“ngâ€ giá»¯a ngÆ°á»i vÃ  AI â€” AI chá»‰ code theo spec nÃ y.
> GÃ³c Mentor: Spec tá»‘t = code Ã­t bug, prompt ngáº¯n, khÃ´ng pháº£i Ä‘oÃ¡n.

## 1. Meta

- **MÃ£:** SPEC-XXX (map tá»›i BIZ-XXX)
- **Tráº¡ng thÃ¡i:** Draft | Review | Approved
- **TÃ¡c giáº£:** @dev + lay-yeu-cau skill
- **NgÃ y duyá»‡t:** YYYY-MM-DD (user kÃ½ duyá»‡t má»›i Ä‘Æ°á»£c code)

## 2. Types (Type-driven â€” há»c tá»« Matt Pocock)

```typescript
// Branded types giÃºp AI khÃ´ng nháº§m láº«n
type Slug = string & { readonly __brand: "Slug" };
type Url = string & { readonly __brand: "Url" };

// Zod schema = validation + type + docs 3 trong 1
import { z } from "zod";

export const CreateLinkSchema = z.object({
  url: z.string().url().max(2048),
  customSlug: z.string().regex(/^[a-zA-Z0-9_-]{3,20}$/).optional(),
  expiresAt: z.coerce.date().optional(),
});

export type CreateLinkInput = z.infer<typeof CreateLinkSchema>;

export interface Link {
  id: string;
  slug: Slug;
  originalUrl: Url;
  ownerId: string | null; // null náº¿u Guest
  clicks: number;
  createdAt: Date;
  expiresAt: Date | null;
}
```

**BÃ i há»c:** Viáº¿t type trÆ°á»›c code â€” compiler sáº½ báº¯t lá»—i thay báº¡n. Khi nÃ o dÃ¹ng `zod`? Má»i chá»— nháº­n input tá»« user/API.

## 3. Database Schema (Prisma)

```prisma
model Link {
  id          String   @id @default(cuid())
  slug        String   @unique @db.VarChar(20)
  originalUrl String   @db.VarChar(2048)
  ownerId     String?
  clicks      Int      @default(0)
  createdAt   DateTime @default(now())
  expiresAt   DateTime?
  @@index([ownerId])
  @@index([slug])
}
```

**Khi nÃ o cáº§n migration?** Má»—i láº§n thay Ä‘á»•i model â†’ `npx prisma migrate dev --name add_expires_at`.

## 4. API Contract (OpenAPI-lite)

| Method | Endpoint | Input | Output | Auth | Ghi chÃº |
|--------|----------|-------|--------|------|---------|
| POST | `/api/links` | `CreateLinkInput` | `201 {slug, shortUrl}` | Optional | Rate limit 10/phÃºt náº¿u Guest |
| GET | `/:slug` | â€” | `302 redirect` | No | Ghi click log |
| GET | `/api/links` | `?q=&page=` | `200 {links[], total}` | Required | List cá»§a tÃ´i |
| DELETE | `/api/links/:id` | â€” | `204` | Required | Chá»‰ owner |

**BÃ i há»c â€” Khi nÃ o dÃ¹ng endpoint nÃ o?**

* **POST** = táº¡o má»›i (khÃ´ng idempotent, má»—i láº§n táº¡o slug má»›i)
* **GET** = Ä‘á»c, khÃ´ng Ä‘á»•i DB (trá»« analytics â€” váº«n lÃ  GET vÃ¬ client chá»‰ Ä‘á»c)
* **DELETE** = xÃ³a, idempotent (xÃ³a 2 láº§n váº«n 204)
* **PUT/PATCH** = cáº­p nháº­t â€” dÃ¹ng PATCH náº¿u chá»‰ Ä‘á»•i 1 pháº§n (vd: Ä‘á»•i expiry)

**Quy táº¯c cho AI:** Má»i endpoint pháº£i cÃ³ zod validate á»Ÿ boundary, tráº£ lá»—i chuáº©n `{error: string, code: string}`, khÃ´ng throw string.

## 5. Logic & State

```
[Input URL] â†’ validate â†’ check blacklist â†’ generate slug â†’ check unique (retry 3) â†’ save DB â†’ return shortUrl
                â†“ fail
              400 + message VN
```

## 6. Edge Cases (tá»« BIZ)

| Case | Spec xá»­ lÃ½ |
|------|------------|
| URL blacklist | 400 `DOMAIN_BLOCKED` |
| Slug collision 3 láº§n | 500 `SLUG_GENERATION_FAILED` |
| Expired link | GET /:slug â†’ 410 Gone |

## 7. LiÃªn káº¿t

- BIZ: `docs/02_BUSINESS/BIZ-XXX.md`
- Prompt: `docs/04_PROMPTS/PROMPT-XXX.md`
- Task: `docs/05_TASKS/TASK-XXX.md`

---
<!-- EXAMPLE BeShort SPEC-001: Äiá»n khá»‘i trÃªn cho rÃºt gá»n URL. Sau khi user duyá»‡t â†’ cháº¡y /tao-prompt -->

