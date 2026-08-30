# 13 â€” SELF LEARNING: Tá»« Vibe Code â†’ Tá»± Viáº¿t Prompt & Tá»± LÃ m Dá»± Ãn

> **Má»¥c tiÃªu cuá»‘i cÃ¹ng cá»§a kit nÃ y:** Báº¡n khÃ´ng cáº§n kit ná»¯a váº«n lÃ m Ä‘Æ°á»£c.
> Lá»™ trÃ¬nh 4 tuáº§n â€” má»—i tuáº§n 1 náº¥c, vá»«a lÃ m BeShort vá»«a há»c.

---

## Tuáº§n 1: Hiá»ƒu luá»“ng & Báº¯t chÆ°á»›c (dÃ¹ng kit 100%)

**LÃ m:** DÃ¹ng kit y nguyÃªn cho BIZ-001 (rÃºt gá»n URL). Copy template, Ä‘iá»n, cháº¡y skill.

**Há»c:**

* Äá»c `11_KIEN_TRUC.md:1` â€” váº½ láº¡i sÆ¡ Ä‘á»“ FEâ†’BEâ†’DB báº±ng tay
* Tráº£ lá»i: â€œKhi user báº¥m nÃºt, hÃ m nÃ o cháº¡y Ä‘áº§u tiÃªn? Ai táº¡o slug?â€
* BÃ i táº­p: ThÃªm 1 field `title` cho link â€” tá»± viáº¿t migration + endpoint PATCH

**ThoÃ¡t khi:** Tá»± ká»ƒ Ä‘Æ°á»£c luá»“ng táº¡o link mÃ  khÃ´ng nhÃ¬n docs.

---

## Tuáº§n 2: Hiá»ƒu â€œtáº¡i saoâ€ & Tá»± quyáº¿t nhá»

**LÃ m:** BIZ-002 (redirect) â€” láº§n nÃ y **tá»± viáº¿t PROMPT** trÆ°á»›c, rá»“i so vá»›i tao-prompt sinh ra.

**Há»c:**

* Äá»c `12_BAO_MAT.md:1` báº£ng Security â€” tá»± check S1â†’S4 cho code tuáº§n 1
* Tráº£ lá»i: â€œTáº¡i sao validate á»Ÿ BE dÃ¹ FE Ä‘Ã£ validate? Táº¡i sao hash IP?â€
* BÃ i táº­p: Tá»± chá»n giá»¯a `nanoid` vs `crypto.randomUUID` cho slug â€” ghi ADR 1 Ä‘oáº¡n, so vá»›i `DECISIONS.md:1`

**ThoÃ¡t khi:** Tá»± viáº¿t Ä‘Æ°á»£c prompt 6 khá»‘i cho 1 endpoint má»›i mÃ  khÃ´ng má»Ÿ `_TEMPLATE.md`.

---

## Tuáº§n 3: Tá»± thiáº¿t káº¿ 1 feature nhá»

**LÃ m:** BIZ-006 Custom slug â€” **khÃ´ng dÃ¹ng skill**, tá»± viáº¿t BIZ + SPEC + PROMPT + TASK tá»« Ä‘áº§u.

**Há»c:**

* Äá»c `01_TECH_STACK.md:1` â€” tá»± tráº£ lá»i â€œnáº¿u khÃ¡ch yÃªu cáº§u SEO, mÃ¬nh Ä‘á»•i gÃ¬?â€
* Dáº¡y láº¡i cho ngÆ°á»i khÃ¡c (hoáº·c ghi video 5p): â€œFrontend káº¿t ná»‘i backend tháº¿ nÃ o?â€
* BÃ i táº­p: Thiáº¿t káº¿ endpoint `POST /api/links/:id/qr` â€” chá»n method, input/output, validate, test plan

**ThoÃ¡t khi:** NgÆ°á»i khÃ¡c nghe báº¡n giáº£i thÃ­ch hiá»ƒu Ä‘Æ°á»£c 80%.

---

## Tuáº§n 4: Tá»± lÃ m dá»± Ã¡n mini & BÃ n giao thá»­

**LÃ m:** Dá»± Ã¡n má»›i 1 ngÃ y: â€œTodo appâ€ hoáº·c â€œBookmark managerâ€ â€” **khÃ´ng copy kit**, tá»± táº¡o `docs/` tá»‘i giáº£n (chá»‰ 3 file: BIZ, SPEC, TASK).

**Há»c:**

* DÃ¹ng `12_BAO_MAT.md:1` Ä‘á»ƒ tá»± audit dá»± Ã¡n mini
* Thá»­ `npm audit`, `npx tsc --noEmit`, `curl` test endpoint
* Viáº¿t README bÃ n giao 1 trang cho â€œkhÃ¡ch giáº£ Ä‘á»‹nhâ€

**ThoÃ¡t khi:** Báº¡n tá»± tin nÃ³i â€œEm lÃ m Ä‘Æ°á»£c dá»± Ã¡n CRUD hoÃ n chá»‰nh vÃ  bÃ n giao Ä‘Æ°á»£câ€.

---

## Bá»™ cÃ¢u há»i tá»± kiá»ƒm tra (dÃ¡n tÆ°á»ng)

1. **Cáº¥u trÃºc:** FE, BE, DB náº±m Ä‘Ã¢u? NÃ³i chuyá»‡n qua gÃ¬?
2. **Endpoint:** Khi nÃ o POST vs GET vs DELETE? Idempotent lÃ  gÃ¬?
3. **Tech:** Táº¡i sao chá»n TS/React/Prisma? Khi nÃ o Ä‘á»•i sang Next/Mongo?
4. **Prompt:** 6 khá»‘i lÃ  gÃ¬? Thiáº¿u khá»‘i 4 (vÃ­ dá»¥) sáº½ sao?
5. **Báº£o máº­t:** 3 lá»—i nguy hiá»ƒm nháº¥t náº¿u khÃ´ng validate input?
6. **Quy trÃ¬nh:** 5 pha lÃ  gÃ¬? Táº¡i sao UI Ä‘á»ƒ cuá»‘i?
7. **BÃ n giao:** KhÃ¡ch cáº§n gÃ¬ Ä‘á»ƒ tá»± váº­n hÃ nh? (README, .env.example, migration, worklog)

Tráº£ lá»i Ä‘Æ°á»£c 7 cÃ¢u â†’ báº¡n Ä‘Ã£ â€œtá»‘t nghiá»‡pâ€ kit.

---

## Sau khi tá»‘t nghiá»‡p â€” Kit cÃ²n cáº§n khÃ´ng?

* Giá»¯ `AGENTS.md` + `00_WORKFLOW.md` + `12_BAO_MAT.md` â€” 3 file lÃµi cho má»i dá»± Ã¡n
* Bá» BIZ/SPEC template dÃ i, chá»‰ giá»¯ checklist 5 cÃ¢u há»i Socratic (tá»± há»i trong Ä‘áº§u)
* Dáº¡y láº¡i cho dev má»›i báº±ng chÃ­nh kit nÃ y â€” Ä‘Ã³ lÃ  cÃ¡ch senior scale team.

> **Triáº¿t lÃ½ tháº§y:** â€œTháº§y khÃ´ng cho con cÃ¡, tháº§y cho cáº§n cÃ¢u + chá»‰ chá»— cÃ¡ + dáº¡y cÃ¡ch tá»± lÃ m cáº§n má»›i. Sau nÃ y khÃ´ng cÃ³ tháº§y, con váº«n cÃ¢u Ä‘Æ°á»£c cÃ¡ to hÆ¡n.â€

---
*Lá»™ trÃ¬nh nÃ y gáº¯n vá»›i `15_HOC_VIBE.md:1` (45 tips) â€” má»—i tuáº§n Ã¡p dá»¥ng 10 tips.*

