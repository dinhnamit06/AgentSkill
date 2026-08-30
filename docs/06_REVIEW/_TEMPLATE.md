# REVIEW-XXX: [Tên slice] — Template 5-axis

> Copy thành `REVIEW-001_Ten.md`. Review trước khi merge — không review = không merge.
> Dành cho reviewer (người hoặc AI). Mỗi lỗi gắn nhãn: Critical / Important / Nit / FYI.

## 1. Meta

- **Mã:** REVIEW-XXX (map TASK-XXX)
- **PR/Commit:** #link
- **Người review:** @reviewer
- **Ngày:** YYYY-MM-DD
- **Kết quả:** Approved | Request Changes

## 2. Context

- [ ] Đã đọc SPEC và PROMPT liên quan
- [ ] Đã hiểu yêu cầu business (đọc BIZ)
- [ ] Đã chạy `npm test` + `build` local

## 3. Checklist 5-axis

### Correctness — Có đúng spec không?
- [ ] Match acceptance criteria trong SPEC
- [ ] Edge cases có test (null, empty, quá dài, trùng slug)
- [ ] Error paths có xử lý (không chỉ happy path)
- [ ] Test thực sự test đúng thứ (không mock quá đà)
- **Lỗi:** _ghi vào mục 4_

### Readability — Người mới đọc hiểu không? (xem 14_CODE_READING_GUIDE:7)
- [ ] Header 3 Biết có đủ? (Ai viết + Tại sao + Link SPEC/PROMPT)
- [ ] Mọi quyết định khó hiểu có comment WHY + link ADR/SPEC? (không comment WHAT)
- [ ] Tên biến/hàm rõ nghĩa (không `data`, `tmp`, `result`)
- [ ] Hàm ≤50 dòng, file ≤300 dòng
- [ ] Không có “clever code” khó hiểu
- [ ] Dead code đã xóa
- **Bài học:** Code cho người đọc, không cho máy — 6 tháng sau chính bạn là người đọc. Thiếu header = junior mất 30p đoán, có header = 10s hiểu.

### Architecture — Có hợp structure không? (11_KIEN_TRUC.md:4)
- [ ] Đúng cấu trúc chuẩn: `src/features/<ten>/` (chia theo feature, không `utils.ts` chung), Route→Service→DB tách biên, `lib/` thuần không DB
- [ ] Đúng pattern dự án (xem `AGENTS.md:6`)
- [ ] Không circular dependency
- [ ] Không duplicate logic (nếu có → tách shared util)
- [ ] DB migration có rollback

### Security — Có lỗ hổng không?
- [ ] Input validate bằng zod ở boundary
- [ ] SQL parameterized (không nối chuỗi)
- [ ] Không lộ secret trong code/log — check `.env.example:1` không có giá trị thật
- [ ] Có rate limit / auth check nơi cần
- [ ] Không tự tiện lấy GitHub/API/thông tin cá nhân — mọi external fetch đã hỏi consent trước (12_BAO_MAT.md:1)
- **Bài học:** Mọi input từ user là untrusted — validate trước khi dùng. Secret phải hỏi mới dùng.

### Performance — Có chậm không?
- [ ] Không N+1 query
- [ ] Có pagination cho list
- [ ] Không fetch unbounded
- [ ] Không tạo object lớn trong hot path

## 4. Findings (ghi rõ file:dòng)

| # | Mức | File:dòng | Vấn đề | Gợi ý fix |
|---|-----|-----------|--------|-----------|
| 1 | Critical | `src/routes/links.ts:42` | Không validate URL, có thể injection | Dùng `CreateLinkSchema.parse` |
| 2 | Important | `src/lib/slug.ts:15` | Không retry khi slug trùng | Thêm loop retry 3 |
| 3 | Nit | `src/routes/links.ts:10` | Tên `data` mơ hồ | Đổi thành `createLinkInput` |
| 4 | FYI | — | Có thể thêm index cho `slug` | Đã có trong SPEC |

## 5. Verification

- [ ] `npm test` xanh (ghi số test pass)
- [ ] `npm run build` pass
- [ ] `npx tsc --noEmit` pass
- [ ] Manual test (ghi curl command đã chạy)

## 6. Gợi ý cải thiện cho lần sau (dạy học)

> Sau review, reviewer ghi 1-2 bài học để dev tiến bộ:
> - VD: “Lần sau nhớ viết test RED trước — lần này code trước test nên test không bắt được bug retry logic.”
> - VD: “Prompt thiếu ví dụ output nên AI gen sai format — nhớ khối 4 trong PROMPT template.”

## 7. Quyết định

- [ ] **Approved** — merge được
- [ ] **Request Changes** — phải fix Critical/Important trước

---
<!-- EXAMPLE BeShort REVIEW-001: Review cho POST /api/links. Sau Approved → cập nhật BOARD.md → gợi ý next TASK -->
