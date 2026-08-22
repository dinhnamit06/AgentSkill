# PROMPT-001: POST /api/links — Tạo link rút gọn (mẫu)

> **Prompt mẫu đã điền sẵn — copy cách viết 6 khối này cho prompt sau.**
> Map SPEC-001 → TASK-002. Dùng để giao AI code slice này.

## 1. Meta

- **Mã:** PROMPT-001 (SPEC-001 → TASK-002)
- **Mục tiêu:** Guest POST URL hợp lệ → nhận slug 6 ký tự + shortUrl, có test xanh
- **Scope:** Chỉ POST /api/links, không làm redirect/UI/rate limit

## 2. Prompt 6 khối (copy đưa cho AI)

```markdown
# Khối 1: CONTEXT
Dự án BeShort — rút gọn URL. Stack: TS + Fastify + Prisma + Postgres (xem docs/_meta/PROJECT_CONTEXT.md).
Đọc docs/03_SPEC/SPEC-001_RutGonURL.md. Pattern tham khảo: src/routes/health.ts (Fastify route chuẩn).

# Khối 2: YÊU CẦU
Implement POST /api/links — nhận {url} → validate bằng CreateLinkSchema → check blacklist (mảng rỗng tạm) → tạo slug 6 ký tự bằng nanoid → retry 3 lần nếu trùng → lưu Prisma → trả 201 {slug, shortUrl: "https://beshort.ly/${slug}"}.
Không làm GET redirect, không làm UI.

# Khối 3: FILES
Tạo: src/schemas/link.ts (chứa CreateLinkSchema), src/lib/slug.ts (generateUniqueSlug)
Sửa: src/routes/links.ts, prisma/schema.prisma
Test: src/routes/links.test.ts, src/lib/slug.test.ts
Không chạm: src/routes/auth.ts, src/components/*

# Khối 4: VÍ DỤ
Input {url: "https://example.com"} → 201 {slug: "aB3x9Q", shortUrl: "https://beshort.ly/aB3x9Q"} (slug 6 ký tự a-zA-Z0-9)
Input {url: "not-a-url"} → 400 {error: "URL không hợp lệ", code: "INVALID_URL"}
Input {} → 400 {code: "MISSING_URL"}
Input {url: "https://phishing.com/bad"} (nếu blacklist chứa phishing.com) → 400 {code: "DOMAIN_BLOCKED"}

# Khối 5: RÀNG BUỘC
- Dùng zod ở boundary, không tự regex URL
- Slug nanoid(6), retry 3 lần, nếu vẫn trùng → 500 SLUG_FAILED
- Dùng AppError {code, status}, không throw string
- File ≤300 dòng, hàm ≤50 dòng

# Khối 6: VERIFY
- Viết test RED trước (2 test: 201 và 400), rồi code cho xanh
- Chạy: npm test + npx tsc --noEmit + npm run build phải xanh
```

## 3. Self-check

- [x] Context <2000 dòng (chỉ 1 spec + 1 pattern)
- [x] Có 3 ví dụ (pass + 2 fail)
- [x] Files IN/OUT rõ
- [x] Có verify đo được

## 4. Sau khi AI xong

- [ ] Chạy verify khối 6
- [ ] Review 5-axis (`docs/06_REVIEW/_TEMPLATE.md`)
- [ ] Ghi worklog
- [ ] Gợi ý next: A) TASK-003 GET redirect (khuyên — để demo end-to-end) B) Rate limit C) Auth → user chọn

---
*Học: Prompt này là “đề thi” — AI là “thợ”. Đề rõ thì thợ làm chuẩn, không phải đoán.*
