# SPEC-001: RÃºt gá»n URL â€” Spec máº«u (Approved)

> Map BIZ-001. ÄÃ£ Approved â€” sáºµn sÃ ng cho tao-prompt.
> Äá»c Ä‘á»ƒ há»c cÃ¡ch viáº¿t spec type-driven.

## 1. Meta

- **MÃ£:** SPEC-001 (BIZ-001)
- **Tráº¡ng thÃ¡i:** Approved
- **NgÃ y duyá»‡t:** 2026-08-22

## 2. Types

```typescript
import { z } from "zod";

type Slug = string & { readonly __brand: "Slug" };
type Url = string & { readonly __brand: "Url" };

export const CreateLinkSchema = z.object({
  url: z.string().url({ message: "URL khÃ´ng há»£p lá»‡" }).max(2048),
});

export type CreateLinkInput = z.infer<typeof CreateLinkSchema>;

export interface Link {
  id: string;
  slug: Slug;
  originalUrl: Url;
  ownerId: string | null;
  clicks: number;
  createdAt: Date;
  expiresAt: Date | null;
}

export interface CreateLinkResponse {
  slug: string;
  shortUrl: string; // https://beshort.ly/${slug}
}
```

**Táº¡i sao zod?** Validate + type + message VN 3 trong 1, AI khÃ´ng pháº£i Ä‘oÃ¡n.

## 3. DB Schema

```prisma
model Link {
  id          String   @id @default(cuid())
  slug        String   @unique @db.VarChar(20)
  originalUrl String   @db.VarChar(2048)
  ownerId     String?
  clicks      Int      @default(0)
  createdAt   DateTime @default(now())
  expiresAt   DateTime?
  @@index([slug])
  @@index([ownerId])
}
```

Migration: `npx prisma migrate dev --name create_links`

## 4. API Contract

| Method | Endpoint | Input | Output | Auth |
|--------|----------|-------|--------|------|
| POST | `/api/links` | `CreateLinkInput` | `201 {slug, shortUrl}` | Optional |

**Errors:**

| Code | Status | Khi nÃ o |
|------|--------|---------|
| INVALID_URL | 400 | zod fail |
| MISSING_URL | 400 | thiáº¿u field url |
| DOMAIN_BLOCKED | 400 | blacklist |
| RATE_LIMITED | 429 | vÆ°á»£t 10/phÃºt |
| SLUG_FAILED | 500 | retry 3 váº«n trÃ¹ng |

## 5. Logic

```
POST /api/links {url}
  â†’ CreateLinkSchema.parse (400 náº¿u fail)
  â†’ check blacklist (400 náº¿u blocked)
  â†’ check rate limit (429 náº¿u vÆ°á»£t)
  â†’ generate slug (nanoid 6) â†’ check unique â†’ retry 3
  â†’ prisma.link.create({slug, originalUrl, expiresAt: now+30d})
  â†’ return 201 {slug, shortUrl}
```

## 6. LiÃªn káº¿t

- BIZ: `docs/02_BUSINESS/BIZ-001_RutGonURL.md`
- Prompt: `docs/04_PROMPTS/PROMPT-001_TaoLink.md`
- Tasks: `TASK-001` (DB), `TASK-002` (API)

