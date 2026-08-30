# TASK-001: DB schema links + migration — Ví dụ slice đầu tiên

> **Slice đầu tiên — foundation.** Xong slice này mới làm API được.
> Học: DB là “móng nhà” — móng sai, nhà sập.

## 1. Meta

- **Mã:** TASK-001 (BIZ-001 / SPEC-001 / PROMPT-001 phần DB)
- **Trạng thái:** Todo → Doing → Review → Done
- **Estimate:** 0.5 ngày

## 2. Mục tiêu

Tạo bảng `links` trong Postgres qua Prisma, có migration, có index, test được.

## 3. Scope

| IN | OUT |
|----|-----|
| `prisma/schema.prisma` model Link | API endpoint (TASK-002) |
| `prisma/migrations/*` | UI |
| Test: `prisma --validate` + `npm run build` pass | Seed data (để TASK-002) |

## 4. Files

- Sửa: `prisma/schema.prisma`
- Tạo: `prisma/migrations/xxxx_create_links/migration.sql`
- Không chạm: `src/*`

## 5. Prompt

Không cần prompt AI phức tạp — chỉ cần:

```
Tạo model Link trong prisma/schema.prisma theo SPEC-001:3 (slug unique, originalUrl 2048, ownerId?, clicks, createdAt, expiresAt, index slug+ownerId). Chạy npx prisma migrate dev --name create_links. Verify npx prisma validate + npm run build.
```

## 6. Verify

- [ ] `npx prisma validate` pass
- [ ] `npx prisma migrate dev` tạo migration file
- [ ] `npx tsc --noEmit` pass
- [ ] `npm run build` pass

## 7. Gợi ý next (AI điền khi Done, user chọn)

- **A (khuyên):** TASK-002 POST /api/links — có DB rồi, làm API ngay để test được
- **B:** Viết seed script — nếu muốn có data mẫu để demo
- **C:** Làm luôn redirect — nhưng chưa có data nên chưa test được

**User chọn: ___**

---
*Sau TASK-001 Done → cập nhật BOARD.md:1 → làm TASK-002.*
