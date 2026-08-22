# 17 — GIT VERSIONING: Sau mỗi chức năng nhỏ pass → push để lưu phiên bản

> **Nguyên tắc thầy:** 1 TASK Done = 1 commit = 1 push = 1 checkpoint rollback được. Không push = chưa lưu, mất máy là mất hết.
> Dành cho team 1-10 người, áp dụng trunk-based đơn giản — không phức tạp như GitFlow.

---

## 1. Tại sao phải push ngay khi pass?

| Không push | Push ngay |
|------------|-----------|
| Mất điện, hỏng máy → mất cả ngày code | Remote đã có, clone lại là xong |
| Muốn thử ý tưởng mới → sợ hỏng code cũ, không dám đụng | Push rồi → tự tin tạo branch thử, hỏng thì `git reset --hard` về checkpoint |
| `git blame` không biết ai viết | `git log` ghi rõ `AI PROMPT-xxx` hay `human @ten` — truy được prompt nào gen ra bug |
| Khách hỏi "bản hôm qua chạy được đâu?" → không có | Tag `v0.1.0-BIZ-001` → checkout lại demo ngay |

---

## 2. Chuẩn commit — 1 dòng là biết ai, làm gì, từ đâu

```bash
# Cú pháp: <type>(scope): <AI|human> <PROMPT/TASK> — <mô tả 1 câu>
# type: feat | fix | refactor | docs | chore

feat(links): AI PROMPT-001 — POST /api/links tao slug (TASK-002)
fix(links): human @tu — retry slug 3 lan (REVIEW-001:2)
docs(biz): human @pm — duyet BIZ-001 (Approved 2026-08-22)
chore(git): tag v0.1.0 — BIZ-001 Done, demo cho khach
```

**Quy tắc:**
* **1 TASK = 1 commit** — không gộp 3 TASK vào 1 commit (`incremental-implementation` Rule 1)
* **Ghi rõ nguồn:** `AI PROMPT-xxx` hay `human @ten` — để `git blame src/routes/links.ts:15` là biết dòng đó AI gen theo prompt nào → mở prompt sửa, không đoán
* **Không commit `.env`, `node_modules`, `dist`** — đã có `.gitignore:1`

---

## 3. Workflow Git cho vibe code (trunk-based, đơn giản nhất)

```
main (luon chay duoc, luon deploy duoc)
  │
  ├─ feat/BIZ-001-rut-gon (branch cho 1 BIZ, tach tu main)
  │     ├─ TASK-001 DB schema — commit → push
  │     ├─ TASK-002 POST /api/links — commit → push
  │     └─ merge vao main (qua PR + REVIEW) → tag v0.1.0
  │
  ├─ feat/BIZ-002-redirect (branch tiep theo)
  │     └─ ...
  └─ main → deploy
```

**Lệnh cho 1 TASK (copy dán) — co security audit chan push neu ho:**

```bash
# 1. Bat dau TASK moi (tu main moi nhat)
git checkout main && git pull
git checkout -b feat/TASK-002-post-links  # hoặc dung chung feat/BIZ-001

# 2. Code + test xanh + security audit (BAT BUOC truoc push)
npm test && npx tsc --noEmit && npm run build
powershell -ExecutionPolicy Bypass -File scripts/security-audit.ps1  # S1-S8 + consent (12_HANDOVER + 18_PRIVACY)
# hoac: bash scripts/security-audit.sh
# → FAIL thi sua theo S1-S8 roi chay lai, khong duoc --no-verify

# 3. Commit 1 TASK = 1 commit
git add src/features/links/links.route.ts src/features/links/links.service.ts src/lib/slug.ts prisma/schema.prisma
git commit -m "feat(links): AI PROMPT-001 — POST /api/links tao slug (TASK-002)"

# 4. Push ngay — checkpoint (pre-push hook se tu chay audit lai, FAIL thi chan push)
git push -u origin feat/TASK-002-post-links
# → tạo PR, gắn REVIEW-002, worklog, chờ duyệt

# 5. Merge xong → tag phiên bản (khi xong 1 BIZ)
git checkout main && git pull
git tag -a v0.1.0 -m "BIZ-001 rut gon URL — P0 Done, demo 2026-08-22"
git push origin v0.1.0
```

**Khi nào tag?**
* `v0.1.0` — xong BIZ-001 (P0 đầu tiên, demo được)
* `v0.2.0` — xong BIZ-002 (redirect)
* `v1.0.0` — xong hết P0, bàn giao khách (`12_BAO_MAT.md:1` pass)

---

## 4. Checklist sau khi 1 chức năng nhỏ pass (không chỉ push)

> Sau khi `npm test` xanh cho 1 TASK, chạy checklist này **trước khi** sang TASK mới — tick hết mới tính Done.

- [ ] **Verify:** `npm test` + `npx tsc --noEmit` + `npm run build` xanh (00_WORKFLOW.md Pha 3 DoD)
- [ ] **Security audit:** `scripts/security-audit.ps1` PASS (S1-S8 + consent 18_PRIVACY) — pre-push hook se chan neu FAIL
- [ ] **Review:** `06_REVIEW/REVIEW-xxx.md` — 0 Critical, header 3 Biết đủ (`14_CODE_READING_GUIDE.md:7`), cau truc chuan `11_KIEN_TRUC.md:4`
- [ ] **Worklog:** Ghi `07_WORKLOG/YYYY-MM-DD.md` — đã làm/học được/quyết định + gợi ý next step (AI hỏi, bạn chọn)
- [ ] **Board:** Kéo `TASK-xxx` sang Done trong `05_TASKS/BOARD.md:1`
- [ ] **Commit:** 1 commit đúng cú pháp trên, `git log --oneline -5` thấy rõ AI/human
- [ ] **Push:** `git push` ngay — kiểm tra GitHub đã có commit
- [ ] **Tag (nếu xong BIZ):** `git tag -a vX.Y.Z -m "..."` + `git push origin vX.Y.Z`
- [ ] **Demo:** Quay màn hình 30s hoặc `curl` demo cho PM/khách (lưu vào `07_WORKLOG`)
- [ ] **Dọn:** Xóa branch đã merge nếu không cần (`git branch -d feat/...`)

**Còn gì nữa ngoài push?** 8 thứ trên — push chỉ là 1 trong 9. Thiếu worklog/board thì 1 tuần sau không nhớ tại sao chọn vậy.

---

## 5. Học để tự quản Git sau này

| Câu hỏi | Trả lời nhanh | Học sâu |
|---------|---------------|---------|
| Tại sao 1 TASK 1 commit? | Dễ revert, dễ blame, dễ review 15p thay vì 2h | `incremental-implementation` Rule 1,5 |
| Khi nào dùng branch? | Mỗi BIZ 1 branch, mỗi TASK có thể chung branch BIZ — không cần branch cho mỗi TASK nếu TASK <1 ngày | Trunk-based vs GitFlow — hỏi AI `So sánh trunk-based vs GitFlow khi nào dùng?` |
| Mất code thì sao? | `git reflog` hoặc checkout tag gần nhất | `15_HOC_VIBE.md:D` Beaver debug |
| Muốn thử ý tưởng rủi ro? | Tạo `wip/thu-nghiem` từ checkpoint đã push, hỏng thì bỏ | `git checkout -b wip/...` |

**Bài tập:** Sau TASK-002, thử `git log --oneline --graph --all` và `git blame src/lib/slug.ts:10` — thấy rõ ai viết dòng nào?

---

## 6. Cài đặt 1 lần cho repo mới

```bash
git init
git config commit.template .gitmessage  # (optional) template commit
git config core.hooksPath .githooks     # bat pre-push audit S1-S8 (chan push neu ho bao mat)
echo "v0.1.0" > .gitignore  # đã có — không commit .env
git add AGENTS.md docs/ .opencode/ scripts/ .githooks/ && git commit -m "chore(kit): cai Vibe Coding Kit v1.0"
git remote add origin https://github.com/you/beshort.git
git push -u origin main  # pre-push se chay audit, FAIL thi chan
```

*Kit đã có `.gitignore:1` — chỉ cần `git init` như trên.*

---
*Liên quan: `00_WORKFLOW.md:4` (Pha 4) → `14_CODE_READING_GUIDE.md:5` (ai viết) → `07_WORKLOG/2026-08-22.md:1` (ghi quyết định).*
