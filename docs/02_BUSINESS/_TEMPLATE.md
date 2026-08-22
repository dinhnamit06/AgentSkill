# BIZ-XXX: [TÃªn chá»©c nÄƒng] â€” Template

> Copy file nÃ y thÃ nh `BIZ-001_TenChucNang.md`. 1 chá»©c nÄƒng = 1 file. DÃ¹ng skill `lay-yeu-cau` Ä‘á»ƒ Ä‘iá»n tá»± Ä‘á»™ng.
> GÃ³c nhÃ¬n: Dev hiá»ƒu lÃ m gÃ¬, Mentor dáº¡y táº¡i sao, PM quáº£n lÃ½ scope.

## 1. Tá»•ng quan

- **MÃ£:** BIZ-XXX
- **TÃªn:** [VD: RÃºt gá»n URL]
- **Má»©c Æ°u tiÃªn:** P0 (báº¯t buá»™c) / P1 (cáº§n) / P2 (nice-to-have)
- **NgÆ°á»i yÃªu cáº§u:** @stakeholder
- **NgÃ y táº¡o:** YYYY-MM-DD
- **Tráº¡ng thÃ¡i:** Draft | Review | Approved | Done

## 2. Bá»‘i cáº£nh & Váº¥n Ä‘á» (Why)

- **Váº¥n Ä‘á» hiá»‡n táº¡i:** [MÃ´ táº£ ná»—i Ä‘au â€” VD: link dÃ i khÃ³ chia sáº», khÃ´ng track Ä‘Æ°á»£c click]
- **Má»¥c tiÃªu kinh doanh:** [VD: tÄƒng 20% share rate, thu tháº­p analytics]
- **ThÃ nh cÃ´ng Ä‘o báº±ng:** [VD: 1000 link táº¡o/tuáº§n, 95% request <100ms]

## 3. Actor & User Story

| Actor | User Story | Ghi chÃº |
|-------|------------|---------|
| Guest | LÃ  khÃ¡ch, tÃ´i muá»‘n dÃ¡n link dÃ i vÃ  nháº­n link ngáº¯n ngay, khÃ´ng cáº§n Ä‘Äƒng nháº­p | P0 |
| Member | LÃ  thÃ nh viÃªn, tÃ´i muá»‘n quáº£n lÃ½ cÃ¡c link Ä‘Ã£ táº¡o | P1 |
| Admin | LÃ  admin, tÃ´i muá»‘n xem thá»‘ng kÃª click theo ngÃ y | P1 |

## 4. Luá»“ng chÃ­nh (Happy Path)

1. User dÃ¡n `https://example.com/very/long/url...` vÃ o input
2. Há»‡ thá»‘ng validate URL, táº¡o slug `abc123`, lÆ°u DB
3. Tráº£ vá» `https://beshort.ly/abc123`
4. Khi truy cáº­p `abc123` â†’ redirect 302 vá» URL gá»‘c + ghi log click

## 5. Business Rules

- [ ] BR1: Slug 6 kÃ½ tá»±, charset `[a-zA-Z0-9]`, unique
- [ ] BR2: URL pháº£i cÃ³ scheme `http/https`, Ä‘á»™ dÃ i â‰¤2048
- [ ] BR3: Link háº¿t háº¡n sau 30 ngÃ y náº¿u lÃ  Guest, khÃ´ng háº¿t háº¡n náº¿u Member
- [ ] BR4: KhÃ´ng cho rÃºt gá»n domain trong blacklist

## 6. Edge Cases & Xá»­ lÃ½

| Case | Xá»­ lÃ½ | Spec liÃªn quan |
|------|-------|----------------|
| URL khÃ´ng há»£p lá»‡ | Tráº£ 400 + message tiáº¿ng Viá»‡t | SPEC-XXX |
| Slug trÃ¹ng | Retry 3 láº§n vá»›i slug má»›i, náº¿u váº«n trÃ¹ng â†’ 500 | SPEC-XXX |
| Link háº¿t háº¡n | Tráº£ 410 Gone + trang â€œLink Ä‘Ã£ háº¿t háº¡nâ€ | SPEC-XXX |
| Rate limit Guest 10 req/phÃºt | Tráº£ 429 + header Retry-After | SPEC-XXX |

## 7. YÃªu cáº§u phi chá»©c nÄƒng

- Performance: táº¡o link <300ms p95, redirect <50ms
- Security: khÃ´ng lá»™ URL gá»‘c trong log, rate limit
- Analytics: log IP (hash), user-agent, timestamp

## 8. Phá»¥ thuá»™c & Pháº¡m vi

- **Phá»¥ thuá»™c:** Auth (náº¿u Member), DB Postgres
- **Trong scope:** Táº¡o, redirect, list cá»§a tÃ´i
- **NgoÃ i scope (phase sau):** Custom slug, QR code, team workspace

## 9. Acceptance Criteria (Given/When/Then)

```gherkin
AC1: Táº¡o link thÃ nh cÃ´ng
  Given tÃ´i lÃ  Guest vÃ  URL há»£p lá»‡
  When tÃ´i POST /api/links {url: "https://example.com"}
  Then tráº£ 201 vá»›i {slug: 6 kÃ½ tá»±, shortUrl: "https://beshort.ly/xxx"}

AC2: URL khÃ´ng há»£p lá»‡
  Given URL thiáº¿u scheme
  When POST /api/links
  Then tráº£ 400 {error: "URL khÃ´ng há»£p lá»‡"}

AC3: Redirect
  Given slug tá»“n táº¡i vÃ  chÆ°a háº¿t háº¡n
  When GET /abc123
  Then 302 redirect vá» URL gá»‘c vÃ  tÄƒng click count
```

## 10. LiÃªn káº¿t

- Spec: `docs/03_SPEC/SPEC-XXX.md`
- Prompt: `docs/04_PROMPTS/PROMPT-XXX.md`
- Tasks: `docs/05_TASKS/TASK-XXX.md`

---
<!-- EXAMPLE cho BeShort: BIZ-001 RÃºt gá»n URL â€” copy khá»‘i trÃªn vÃ  Ä‘iá»n. Xem BACKLOG.md:1 Ä‘á»ƒ biáº¿t thá»© tá»± Æ°u tiÃªn -->

