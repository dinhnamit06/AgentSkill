# 14 â€” CODE READING: Äá»c code lÃ  hiá»ƒu ai viáº¿t, táº¡i sao chá»n váº­y, tá»«ng dÃ²ng lÃ m gÃ¬

> **Má»¥c tiÃªu:** Má»Ÿ báº¥t ká»³ file nÃ o trong `src/` lÃ  báº¡n biáº¿t ngay: (1) ai viáº¿t (ngÆ°á»i hay AI), (2) táº¡i sao dÃ¹ng tech/cáº¥u trÃºc Ä‘Ã³, (3) tá»«ng dÃ²ng Ä‘á»ƒ lÃ m gÃ¬, (4) liÃªn káº¿t tá»›i spec nÃ o.
> DÃ nh cho ngÆ°á»i má»›i â€” Ä‘á»c xong tá»± tin review code AI mÃ  khÃ´ng sá»£ bá»‹ â€œáº£oâ€.

---

## 1. NguyÃªn táº¯c â€œ3 Biáº¿tâ€ cho má»i file code

Má»i file do AI hoáº·c ngÆ°á»i táº¡o **pháº£i** tráº£ lá»i Ä‘Æ°á»£c 3 cÃ¢u ngay á»Ÿ Ä‘áº§u file:

| Biáº¿t gÃ¬ | Xem á»Ÿ Ä‘Ã¢u | VÃ­ dá»¥ |
|---------|-----------|-------|
| **Ai viáº¿t & khi nÃ o** | Header comment + `git log` + `TASK-xxx.md` | `// AI: tao-prompt PROMPT-001, human review @tu, 2026-08-22` |
| **Táº¡i sao chá»n tech/cáº¥u trÃºc nÃ y** | Header â€œWHYâ€ + `DECISIONS.md` + `SPEC-xxx.md` | â€œDÃ¹ng Fastify thay Express vÃ¬ benchmark 2x, xem ADR-001â€ |
| **Tá»«ng dÃ²ng lÃ m gÃ¬** | Comment ngáº¯n gá»n dÃ²ng phá»©c táº¡p + test cáº¡nh bÃªn | `// retry 3 láº§n vÃ¬ slug cÃ³ thá»ƒ trÃ¹ng (BR1)` |

**Náº¿u file nÃ o thiáº¿u 3 Biáº¿t â†’ chÆ°a Ä‘áº¡t chuáº©n bÃ n giao, pháº£i bá»• sung trÆ°á»›c khi merge.**

---

## 2. Header máº«u â€” Copy dÃ¡n vÃ o Ä‘áº§u má»—i file do AI táº¡o

```typescript
/**
 * File: src/routes/links.ts
 * Feature: BIZ-001 Rut gon URL â€” POST /api/links
 * Spec: docs/03_SPEC/SPEC-001_RutGonURL.md:2 (CreateLinkSchema)
 * Prompt: docs/04_PROMPTS/PROMPT-001_TaoLink.md (6 khoi)
 * Task: docs/05_TASKS/TASK-002 (DB+API+test)
 * Author: AI (tao-prompt) + human review @tu â€” 2026-08-22
 * Tech chon: Fastify (ADR-001: nhanh hon Express 2x) + zod validate + Prisma
 * Cau truc: route handler -> validate -> generateSlug -> prisma.create -> return 201
 * Whitelist: endpoint public, co rate-limit (TASK-004 se lam)
 *
 * Doc header nay de biet tai sao file ton tai â€” xoa header = mat lich su.
 */

// WHY: Dung Fastify thay Express â€” xem docs/07_WORKLOG/DECISIONS.md:ADR-001
// WHY: Dung zod o boundary â€” fail nhanh, message ro, khong ton query DB
import { z } from "zod";
import { prisma } from "../db/client";

// WHY: Tach generateUniqueSlug ra src/lib/slug.ts â€” de test rieng, de mock khi test API
import { generateUniqueSlug } from "../lib/slug";

export const CreateLinkSchema = z.object({
  url: z.string().url({ message: "URL khong hop le" }).max(2048), // WHY: max 2048 de tranh DoS
});
```

**BÃ i há»c:** Header khÃ´ng pháº£i Ä‘á»ƒ â€œtrang trÃ­â€, header lÃ  **há»£p Ä‘á»“ng truy váº¿t** â€” khÃ¡ch há»i â€œsao dÃ¹ng Fastify?â€ â†’ trá» ngay `ADR-001`. Dev má»›i Ä‘á»c header 10s lÃ  hiá»ƒu file Ä‘á»ƒ lÃ m gÃ¬, khÃ´ng pháº£i Ä‘á»c 200 dÃ²ng.

### Quy táº¯c header cho team

* AI **báº¯t buá»™c** gen header khi táº¡o file má»›i (ghi trong PROMPT khá»‘i 5: â€œthem header 3 Bietâ€)
* NgÆ°á»i review **báº¯t buá»™c** kiá»ƒm tra header trÆ°á»›c khi approve (checklist REVIEW má»¥c 3)
* Sá»­a file â†’ cáº­p nháº­t `Author` dÃ²ng cuá»‘i: `+ human fix @lan 2026-08-23: them retry`

---

## 3. Comment â€œWHYâ€ trong code â€” Khi nÃ o cáº§n, khi nÃ o khÃ´ng

**Cáº§n comment WHY (táº¡i sao, khÃ´ng pháº£i lÃ m gÃ¬):**

```typescript
// Good: WHY â€” giai thich quyet dinh kho hieu
// Retry 3 lan vi slug 6 ky tu co xac suat trung 1/56B, nhung van co the trung khi tai cao
for (let i = 0; i < 3; i++) {
  const slug = nanoid(6);
  const exists = await prisma.link.findUnique({ where: { slug } });
  if (!exists) return slug;
}
throw new AppError("SLUG_FAILED", 500); // WHY: throw AppError de tra JSON chuan, khong throw string

// Bad: WHAT â€” lap lai code
// Tao slug
const slug = nanoid(6); // thua â€” code da noi lam gi
```

**Quy táº¯c:** Comment WHAT lÃ  ná»£, comment WHY lÃ  tÃ i sáº£n. AI hay gen comment WHAT â†’ reviewer pháº£i xÃ³a.

---

## 4. Truy váº¿t: Tá»« dÃ²ng code â†’ Spec â†’ Prompt â†’ BIZ (Ä‘á»ƒ hiá»ƒu táº¡i sao AI dÃ¹ng cáº¥u trÃºc Ä‘Ã³)

```
BIZ-001 (de bai: can rut gon link, slug 6 ky tu)
  â†’ SPEC-001:2 (quy dinh type Slug + CreateLinkSchema + DB index)
    â†’ PROMPT-001 khoi 3 (chi duoc cham src/routes/links.ts, src/lib/slug.ts)
      â†’ src/routes/links.ts:15 (dong validate) â€” tai sao dung zod? Vi SPEC-001:2 bao vay
      â†’ src/lib/slug.ts:8 (ham generate) â€” tai sao tach file? Vi PROMPT khoi 5 bao file â‰¤300 dong
```

**CÃ¡ch tá»± truy váº¿t khi Ä‘á»c code láº¡:**

1. Má»Ÿ header â†’ láº¥y `Spec: docs/03_SPEC/SPEC-xxx.md:2`
2. Má»Ÿ SPEC dÃ²ng Ä‘Ã³ â†’ tháº¥y zod schema + lÃ½ do
3. Má»Ÿ `DECISIONS.md` náº¿u tháº¥y `ADR-001` â†’ hiá»ƒu trade-off
4. Má»Ÿ `TASK-xxx.md` â†’ biáº¿t estimate, scope IN/OUT
5. Má»Ÿ `PROMPT-xxx.md` khá»‘i 4 â†’ tháº¥y vÃ­ dá»¥ input/output AI dá»±a vÃ o

**BÃ i táº­p:** Má»Ÿ `src/routes/links.ts:15` (dÃ²ng validate), thá»­ truy vá» `SPEC-001:2` mÃ  khÃ´ng nhÃ¬n guide nÃ y â€” náº¿u lÃ m Ä‘Æ°á»£c â†’ báº¡n Ä‘Ã£ náº¯m cáº¥u trÃºc.

---

## 5. Ai viáº¿t? â€” PhÃ¢n biá»‡t AI vs NgÆ°á»i & trÃ¡ch nhiá»‡m

| Dáº¥u hiá»‡u | AI viáº¿t | NgÆ°á»i viáº¿t/sá»­a |
|----------|---------|----------------|
| Commit message | `feat(links): AI PROMPT-001 â€” POST /api/links` | `fix(links): human @tu â€” them retry 3` |
| Header Author | `AI (tao-prompt) + human review @tu` | `human @tu â€” fix edge case` |
| Git blame | DÃ²ng do AI gen, ngÆ°á»i review | DÃ²ng do ngÆ°á»i sá»­a sau |
| Worklog | `AI gen 120 dong, human review 15p` | `Human them test 20 dong` |

**Quy Æ°á»›c commit cho team (Ä‘á»ƒ `git log` lÃ  biáº¿t ai):**

```bash
# AI gen (tao-prompt)
feat(links): AI PROMPT-001 â€” POST /api/links (TASK-002)

# Human fix sau review
fix(links): human @tu â€” retry slug 3 lan (REVIEW-001:2)

# Human tu viet (khong AI)
feat(auth): human @lan â€” them JWT middleware
```

**Táº¡i sao cáº§n?** Khi bug, `git blame` biáº¿t ngay dÃ²ng Ä‘Ã³ AI gen theo prompt nÃ o â†’ má»Ÿ prompt ra sá»­a, khÃ´ng pháº£i Ä‘oÃ¡n. BÃ n giao cho khÃ¡ch, khÃ¡ch tháº¥y log rÃµ rÃ ng â†’ tin tÆ°á»Ÿng.

---

## 6. VÃ­ dá»¥ hoÃ n chá»‰nh â€” File dá»… Ä‘á»c nháº¥t cÃ³ thá»ƒ

```typescript
/**
 * File: src/lib/slug.ts
 * Feature: BIZ-001 â€” tao slug duy nhat
 * Spec: SPEC-001:5 (retry 3)
 * Prompt: PROMPT-001 khoi 2+5
 * Author: AI (tao-prompt) + human review @tu â€” 2026-08-22
 * Tech: nanoid (nhanh, khong phu thuoc crypto) â€” da check npm audit
 * Test: src/lib/slug.test.ts (2 test: 6 ky tu + khong trung 1000 lan)
 */
import { customAlphabet } from "nanoid";

// WHY: customAlphabet chi lay a-zA-Z0-9 â€” de slug gon, khong co _- (BR1)
const nanoid = customAlphabet("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", 6);

/**
 * Tao 1 slug 6 ky tu. Khong dam bao duy nhat â€” caller phai check DB.
 * WHY tach ham nay? De test rieng, khong can DB.
 */
export function generateSlug(): string {
  return nanoid(); // 6 ky tu, 56B to hop, xac suat trung cuc thap
}

/**
 * Tao slug duy nhat, retry 3 lan neu trung DB.
 * WHY retry 3? Du de tranh trung khi tai cao, khong loop vo han gay treo.
 */
export async function generateUniqueSlug(prisma: PrismaClient): Promise<string> {
  for (let i = 0; i < 3; i++) {
    const slug = generateSlug();
    const exists = await prisma.link.findUnique({ where: { slug } });
    if (!exists) return slug; // WHY: check DB truoc khi tra â€” dam bao unique
  }
  throw new AppError("SLUG_FAILED", 500, "Khong tao duoc slug sau 3 lan thu");
}
```

Má»Ÿ file nÃ y, junior 1 tuáº§n cÅ©ng hiá»ƒu: ai viáº¿t, táº¡i sao dÃ¹ng nanoid, táº¡i sao retry 3, test á»Ÿ Ä‘Ã¢u.

---

## 7. Checklist â€œRÃµ rÃ ngâ€ trÆ°á»›c khi merge (dÃ¡n vÃ o REVIEW)

- [ ] Má»i file má»›i cÃ³ header 3 Biáº¿t?
- [ ] Má»i quyáº¿t Ä‘á»‹nh khÃ³ hiá»ƒu cÃ³ comment WHY + link ADR/SPEC?
- [ ] `git log` ghi rÃµ AI vs human?
- [ ] Má»Ÿ header â†’ truy Ä‘Æ°á»£c vá» BIZ/SPEC/PROMPT trong 30s?
- [ ] Junior Ä‘á»c file 5 phÃºt hiá»ƒu Ä‘Æ°á»£c luá»“ng chÃ­nh?

Náº¿u 5 cÃ¢u Ä‘á»u â€œcÃ³â€ â†’ file nÃ y **rÃµ rÃ ng nháº¥t cÃ³ thá»ƒ** â€” bÃ n giao khÃ´ng sá»£ khÃ¡ch há»i â€œÄ‘oáº¡n nÃ y Ä‘á»ƒ lÃ m gÃ¬?â€.

---
*Lien quan: `AGENTS.md:4` (conventions) â†’ `11_KIEN_TRUC.md:2` (FEâ†”BE) â†’ `06_REVIEW/_TEMPLATE.md:3` (review header).*

