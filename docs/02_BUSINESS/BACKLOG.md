# BACKLOG â€” Danh sÃ¡ch chá»©c nÄƒng (chia nhá» Ä‘á»ƒ vibe code)

> Má»—i dÃ²ng lÃ  1 BIZ. Má»—i BIZ sáº½ tÃ¡ch thÃ nh nhiá»u TASK (1 TASK = 1 slice). PM sáº¯p xáº¿p Æ°u tiÃªn, Dev chá»‰ lÃ m theo thá»© tá»±.
> NguyÃªn táº¯c: P0 trÆ°á»›c, má»—i láº§n chá»‰ lÃ m 1 BIZ, má»—i BIZ chá»‰ lÃ m 1 TASK táº¡i 1 thá»i Ä‘iá»ƒm.

## BeShort â€” Backlog gá»£i Ã½ (Ä‘Ã£ chia theo vertical slice)

| # | MÃ£ | Chá»©c nÄƒng | MÃ´ táº£ 1 cÃ¢u | Æ¯u tiÃªn | Tráº¡ng thÃ¡i | Spec |
|---|----|-----------|-------------|---------|------------|------|
| 1 | BIZ-001 | RÃºt gá»n URL (Guest) | DÃ¡n link dÃ i â†’ nháº­n link ngáº¯n 6 kÃ½ tá»± | P0 | Draft | SPEC-001 |
| 2 | BIZ-002 | Redirect + Click log | Truy cáº­p slug â†’ redirect + ghi analytics | P0 | Draft | SPEC-002 |
| 3 | BIZ-003 | Auth (Member) | ÄÄƒng kÃ½/Ä‘Äƒng nháº­p Ä‘á»ƒ quáº£n lÃ½ link | P1 | Draft | SPEC-003 |
| 4 | BIZ-004 | Dashboard â€œLink cá»§a tÃ´iâ€ | List, search, xÃ³a link | P1 | Draft | SPEC-004 |
| 5 | BIZ-005 | Thá»‘ng kÃª click | Xem chart click theo ngÃ y/device | P1 | Draft | SPEC-005 |
| 6 | BIZ-006 | Custom slug & Expiry | User tá»± Ä‘áº·t slug, Ä‘áº·t háº¡n | P2 | Idea | â€” |
| 7 | BIZ-007 | QR Code | Táº¡o QR cho link ngáº¯n | P2 | Idea | â€” |
| 8 | BIZ-008 | Team workspace | Chia sáº» link trong team | P2 | Idea | â€” |

## CÃ¡ch chia BIZ â†’ TASK (vÃ­ dá»¥ BIZ-001)

```
BIZ-001: RÃºt gá»n URL
â”œâ”€â”€ TASK-001: DB schema + migration (links table)
â”œâ”€â”€ TASK-002: POST /api/links â€” táº¡o slug + validate zod (logic, chÆ°a UI)
â”œâ”€â”€ TASK-003: Rate limit + blacklist check
â””â”€â”€ TASK-004: UI form rÃºt gá»n (Pha 5 â€” sau khi logic xanh)
```

Má»—i TASK â‰¤300 dÃ²ng, cÃ³ test riÃªng, 1 PR riÃªng.

## Quy táº¯c cho team

1. **KhÃ´ng lÃ m P1 khi P0 chÆ°a Done.** PM chá»‹u trÃ¡ch nhiá»‡m sáº¯p xáº¿p.
2. **Má»—i BIZ pháº£i cÃ³ REVIEW trÆ°á»›c khi sang BIZ má»›i.**
3. **Æ¯á»›c lÆ°á»£ng:** Má»—i TASK = 0.5â€“1 ngÃ y. Náº¿u >1 ngÃ y â†’ tÃ¡ch tiáº¿p.
4. **Há»p backlog 1 láº§n/tuáº§n:** Cáº­p nháº­t tráº¡ng thÃ¡i, thÃªm/bá»›t scope cÃ³ ADR.

## Template thÃªm BIZ má»›i

Copy `docs/02_BUSINESS/_TEMPLATE.md` â†’ `BIZ-00X_Ten.md` â†’ Ä‘iá»n â†’ cháº¡y `/lay-yeu-cau` Ä‘á»ƒ refine â†’ thÃªm vÃ o báº£ng trÃªn.

---
*Teams: DÃ¡n báº£ng nÃ y lÃªn Notion/Linear/Jira náº¿u cáº§n, nhÆ°ng file nÃ y lÃ  nguá»“n chÃ¢n lÃ½.*

