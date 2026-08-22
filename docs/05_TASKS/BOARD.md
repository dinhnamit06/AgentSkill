# BOARD — Kanban theo dõi tiến độ

> Nguồn chân lý cho PM. Mỗi TASK là 1 thẻ. Chỉ kéo thẻ khi đạt DoD.
> Quy tắc: WIP ≤2 thẻ ở Doing — làm ít, xong nhanh, demo sớm.

## Cột

| Todo | Doing (WIP ≤2) | Review | Done |
|------|----------------|--------|------|
| TASK chưa làm, đã có spec Approved | Đang code + test | Đang review 5-axis | Đã merge + worklog |
| | | | |

## BeShort — Board hiện tại (cập nhật mỗi ngày)

| Mã | Tên | Ưu tiên | Trạng thái | Người làm | Ghi chú |
|----|-----|---------|------------|-----------|---------|
| TASK-001 | DB schema links + migration | P0 | Todo | — | Bắt đầu từ đây — foundation |
| TASK-002 | POST /api/links (tạo slug) | P0 | Todo | — | Sau TASK-001 |
| TASK-003 | GET /:slug redirect + click log | P0 | Todo | — | Xong là demo được luồng Guest |
| TASK-004 | Rate limit + blacklist | P1 | Todo | — | Hardening trước public |
| TASK-005 | Auth (register/login) | P1 | Todo | — | Sau P0 xong |
| TASK-006 | Dashboard list links | P1 | Todo | — | Cần Auth |
| TASK-007 | UI form rút gọn (Pha 5) | P1 | Todo | — | Chỉ sau khi logic xanh |
| TASK-008 | Click analytics chart | P2 | Idea | — | — |

## Cách dùng cho team

1. **Daily:** Mỗi dev chọn 1 thẻ từ Todo → kéo sang Doing, điền `TASK-xxx.md`.
2. **Khi xong code:** Kéo sang Review, gắn `REVIEW-xxx.md`.
3. **Khi review pass + worklog:** Kéo sang Done, **git commit + git push ngay** (17_GIT_VERSIONING.md:3), AI gợi ý next step (xem `TASK-_TEMPLATE.md:8`).
4. **Khi xong 1 BIZ:** `git tag -a v0.X.0 -m "BIZ-xxx Done"` + `git push origin v0.X.0` — demo cho khách.
5. **PM:** Cuối tuần đếm thẻ Done + tags, cập nhật BACKLOG.

## Gợi ý next step tự động (AI điền khi 1 TASK Done)

> Ví dụ khi TASK-003 Done, AI sẽ gợi ý:
> - A (khuyên): TASK-004 Rate limit — vì P0 vừa xong, cần hardening trước khi public
> - B: Nhảy sang Auth — nếu muốn demo Member sớm
> - C: Làm UI form — nếu muốn feedback UX sớm (nhưng vi phạm “logic trước UI”)
>
> **User quyết định cuối cùng** — AI chỉ phân tích trade-off. Đây là cách bạn học quản lý dự án.

---
*Link: `BACKLOG.md:1` (danh sách BIZ) ↔ `BOARD.md` (danh sách TASK) ↔ `TASK-xxx.md` (chi tiết)*
