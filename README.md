# BeShort â€” Vibe Coding Kit v1.0

> Kit nghiá»‡p vá»¥ + quy trÃ¬nh + skills Ä‘á»ƒ vibe code **chuáº©n production** â€” vá»«a lÃ m dá»± Ã¡n, vá»«a há»c Ä‘á»ƒ tá»± bay, vá»«a bÃ n giao tá»± tin cho khÃ¡ch.
> Portable: copy `AGENTS.md` + `docs/` + `.opencode/` sang báº¥t ká»³ dá»± Ã¡n nÃ o, cháº¡y `.\install.ps1` lÃ  xong.

## 30s cÃ i vÃ o dá»± Ã¡n má»›i

```powershell
# Windows
.\install.ps1 -Target "C:\path\to\NewProject" -ProjectName "MyApp"

# macOS/Linux
./install.sh ../MyNewApp MyNewApp
```

Sau Ä‘Ã³ Ä‘iá»n `docs/_meta/PROJECT_CONTEXT.md` (báº¯t buá»™c) rá»“i Ä‘á»c `docs/00_WORKFLOW.md`.

## 5 pha workflow (báº¯t buá»™c)

```
Pha 1: Chá»n cÃ´ng nghá»‡ â†’ User Review
Pha 2: Nghiá»‡p vá»¥ (lay-yeu-cau) â†’ Spec â†’ User Review
Pha 3: Prompt (tao-prompt) â†’ Code 1 slice â†’ TDD â†’ Verify
Pha 4: Review 5-axis â†’ Worklog
Pha 5: UI/UX (chá»‰ sau khi logic xanh)
```

Má»—i pha cÃ³ DoD trong `docs/00_WORKFLOW.md:1`. Má»—i láº§n chá»‰ lÃ m **1 TASK = 1 slice = 1 PR**.

## Docs â€” Äá»c theo thá»© tá»±

| # | File | Äá»ƒ lÃ m gÃ¬ |
|---|------|-----------|
| 0 | `docs/README.md` | Index â€” lá»™ trÃ¬nh 13 file |
| 1 | `AGENTS.md` | Luáº­t chung cho má»i AI (Level 1 Context) |
| 2 | `docs/11_KIEN_TRUC.md` | **Hiá»ƒu táº­n gá»‘c** FEâ†”BE, endpoint, táº¡i sao chá»n tech |
| 3 | `docs/14_CODE_READING_GUIDE.md` | **Äá»c code lÃ  hiá»ƒu** ai viáº¿t, táº¡i sao chá»n cáº¥u trÃºc Ä‘Ã³ |
| 4 | `docs/12_BAO_MAT.md` | Checklist bÃ n giao â€” báº£o máº­t + production |
| 5 | `docs/15_HOC_VIBE.md` | 37 tips + 8 bÃ­ quyáº¿t senior |

## 2 Skills (AI há»— trá»£, ngÆ°á»i quyáº¿t)

* `/lay-yeu-cau` â€” há»i sÃ¢u â†’ sinh `BIZ` + `SPEC` (type-first)
* `/tao-prompt` â€” spec â†’ prompt 6 khá»‘i (context, yÃªu cáº§u, files, vÃ­ dá»¥, rÃ ng buá»™c, verify) â€” dáº¡y báº¡n tá»± viáº¿t prompt sau nÃ y

Luá»“ng: `Idea â†’ lay-yeu-cau â†’ User duyá»‡t â†’ tao-prompt â†’ Code 1 slice â†’ Test â†’ Review â†’ Gá»£i Ã½ next step (user chá»n)`

## VÃ­ dá»¥ BeShort Ä‘Ã£ cÃ³ sáºµn

* `docs/02_BUSINESS/BIZ-001_RutGonURL.md` â€” BIZ máº«u
* `docs/03_SPEC/SPEC-001_RutGonURL.md` â€” SPEC máº«u (zod + Prisma)
* `docs/04_PROMPTS/PROMPT-001_TaoLink.md` â€” Prompt máº«u 6 khá»‘i
* `docs/05_TASKS/TASK-001_DBLinks.md` â€” Task Ä‘áº§u tiÃªn

## NguyÃªn táº¯c â€œrÃµ rÃ ng nháº¥t cÃ³ thá»ƒâ€

* Má»i file AI táº¡o cÃ³ **header 3 Biáº¿t**: ai viáº¿t + táº¡i sao + link SPEC/ADR
* Má»i quyáº¿t Ä‘á»‹nh khÃ³ hiá»ƒu cÃ³ **comment WHY** + link
* Má»i commit ghi rÃµ `AI PROMPT-xxx` hay `human @ten` â€” `git blame` lÃ  biáº¿t ai
* Xem `docs/14_CODE_READING_GUIDE.md:2` Ä‘á»ƒ biáº¿t chuáº©n.

## BÃ n giao cho khÃ¡ch

Cháº¡y `docs/12_BAO_MAT.md:1` â€” Ä‘á»§ 8 nhÃ³m (chá»©c nÄƒng, báº£o máº­t, hiá»‡u nÄƒng, â€¦) lÃ  tá»± tin kÃ½ bÃ n giao.

---
*Kit version: v1.0 â€” Portable. Xem `docs/13_SELF_LEARNING_GUIDE.md:1` Ä‘á»ƒ há»c 4 tuáº§n tá»± bay.*

