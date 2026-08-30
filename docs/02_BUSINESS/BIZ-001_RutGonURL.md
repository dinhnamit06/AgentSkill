# BIZ-001: Rút gọn URL (Guest) — Ví dụ mẫu

> **Đây là BIZ mẫu đã điền sẵn để bạn học.** Copy cách viết này cho BIZ mới.
> Trạng thái: Approved — đã sẵn sàng sang SPEC-001.

## 1. Tổng quan

- **Mã:** BIZ-001
- **Tên:** Rút gọn URL cho Guest (không cần đăng nhập)
- **Mức ưu tiên:** P0 — phải có mới demo được
- **Người yêu cầu:** PM BeShort
- **Ngày tạo:** 2026-08-22
- **Trạng thái:** Approved

## 2. Bối cảnh & Vấn đề

- **Vấn đề:** Link gốc dài 100-200 ký tự, khó chia sẻ qua chat/QR, không track được ai click.
- **Mục tiêu:** Guest dán link → nhận link ngắn `beshort.ly/abc123` trong <1s, có thể chia sẻ ngay.
- **Thành công:** 1000 link/ngày, p95 <300ms, lỗi <1%.

## 3. Actor & User Story

| Actor | User Story | Ưu tiên |
|-------|------------|---------|
| Guest | Là khách chưa đăng nhập, tôi muốn dán link dài và nhận link ngắn ngay | P0 |
| Member | Là thành viên, tôi muốn các link tôi tạo được lưu vào “Link của tôi” | P1 (BIZ-003) |

## 4. Luồng chính

1. Guest dán `https://example.com/very/long/url?with=params` vào input
2. Hệ thống validate URL (có http/https, ≤2048), check blacklist
3. Tạo slug 6 ký tự `[a-zA-Z0-9]`, đảm bảo unique (retry 3 lần)
4. Lưu DB: `{slug, originalUrl, ownerId: null, expiresAt: +30 ngày}`
5. Trả về `{slug: "aB3x9Q", shortUrl: "https://beshort.ly/aB3x9Q"}`

## 5. Business Rules

- BR1: Slug 6 ký tự, charset `a-zA-Z0-9`, unique
- BR2: URL phải có scheme `http/https`, độ dài ≤2048, không trong blacklist
- BR3: Guest link hết hạn 30 ngày, Member không hết hạn (BIZ-003)
- BR4: Không cho rút gọn domain `beshort.ly` (tránh loop)

## 6. Edge Cases

| Case | Xử lý |
|------|-------|
| URL thiếu scheme (`example.com`) | 400 `INVALID_URL` — “URL phải bắt đầu bằng http:// hoặc https://” |
| URL trong blacklist (`phishing.com`) | 400 `DOMAIN_BLOCKED` |
| Slug trùng (hiếm) | Retry 3 lần với slug mới, vẫn trùng → 500 `SLUG_FAILED` |
| Body thiếu `url` | 400 `MISSING_URL` |
| Rate limit Guest 10 req/phút vượt | 429 + `Retry-After: 60` |

## 7. Yêu cầu phi chức năng

- Tạo link p95 <300ms, redirect <50ms
- Rate limit + hash IP (bảo mật)
- Không lộ URL gốc trong log

## 8. Phụ thuộc & Phạm vi

- **Phụ thuộc:** DB Postgres + Prisma
- **Trong scope:** Tạo link, validate, slug, lưu DB
- **Ngoài scope:** Redirect (BIZ-002), Auth (BIZ-003), UI (Pha 5)

## 9. Acceptance Criteria

```gherkin
AC1: Guest tạo link thành công
  Given URL hợp lệ "https://example.com"
  When POST /api/links {url: "https://example.com"}
  Then 201 {slug: 6 ký tự, shortUrl: "https://beshort.ly/xxx"}

AC2: URL xấu
  Given URL "not-a-url"
  When POST /api/links
  Then 400 {error: "URL không hợp lệ", code: "INVALID_URL"}

AC3: Thiếu url
  Given body {}
  When POST /api/links
  Then 400 {code: "MISSING_URL"}
```

## 10. Liên kết

- Spec: `docs/03_SPEC/SPEC-001_RutGonURL.md` (tạo tiếp)
- Prompt: `docs/04_PROMPTS/PROMPT-001_TaoLink.md`
- Tasks: `TASK-001` (DB) + `TASK-002` (POST API)

---
*Học: BIZ này là “đề bài” — SPEC sẽ là “bản vẽ”, PROMPT là “lệnh thi công”.*
