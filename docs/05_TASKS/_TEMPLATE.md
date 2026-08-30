# TASK-XXX: [Tên slice] — Template (1 slice = 1 PR = 1 ngày)

> Copy thành `TASK-001_TenSlice.md`. Mỗi TASK là 1 vertical slice nhỏ nhất mà vẫn demo được.
> Nguyên tắc: Dev chỉ làm 1 TASK tại 1 thời điểm, xong mới sang TASK mới.

## 1. Meta

- **Mã:** TASK-XXX (map BIZ-XXX / SPEC-XXX / PROMPT-XXX)
- **Tên:** [VD: POST /api/links — tạo link với slug]
- **Trạng thái:** Todo | Doing | Review | Done
- **Người làm:** @dev
- **Estimate:** 0.5–1 ngày (nếu >1 ngày → tách tiếp)
- **Ngày tạo / Done:** YYYY-MM-DD / YYYY-MM-DD

## 2. Mục tiêu (1 câu, đo được)

[VD: Guest có thể POST 1 URL hợp lệ và nhận link ngắn 6 ký tự, có test xanh]

## 3. Scope — IN / OUT (rất quan trọng để AI không làm lố)

| IN (làm) | OUT (không làm — để TASK khác) |
|----------|-------------------------------|
| DB migration links table | Auth, ownerId logic |
| POST /api/links + zod validate | GET redirect, click log |
| Unit test cho slug + API test cho endpoint | UI form, rate limit |

## 4. Files sẽ chạm

- Tạo: `src/schemas/link.ts`, `src/lib/slug.ts`, `prisma/migrations/...`
- Sửa: `src/routes/links.ts`, `prisma/schema.prisma`
- Test: `src/routes/links.test.ts`, `src/lib/slug.test.ts`
- Không chạm: `src/components/*`, `src/routes/auth.ts`

## 5. Prompt link

`docs/04_PROMPTS/PROMPT-XXX.md`

## 6. Test plan (TDD)

- [ ] RED: Viết test `POST /api/links → 201` và `→ 400` trước khi code
- [ ] GREEN: Code cho test xanh
- [ ] REFACTOR: Tách hàm, đặt tên lại, chạy lại test

```typescript
// Ví dụ test RED (phải đỏ trước)
it("POST /api/links với URL hợp lệ → 201", async () => {
  const res = await app.inject({ method: "POST", url: "/api/links", payload: { url: "https://example.com" } });
  expect(res.statusCode).toBe(201);
  expect(JSON.parse(res.body).slug).toMatch(/^[a-zA-Z0-9]{6}$/);
});
```

## 7. Verify checklist (chạy sau khi code)

- [ ] `npm test` xanh
- [ ] `npx tsc --noEmit` không lỗi
- [ ] `npm run build` pass
- [ ] Manual test bằng curl/Postman (ghi lại command)

## 8. Gợi ý bước tiếp theo (AI điền sau khi Done, user quyết)

> Sau khi TASK này Done, AI gợi ý 2-3 hướng đi tiếp, user chọn:
>
> **Gợi ý A (khuyên):** TASK-002 — GET /:slug redirect + click log (hoàn thiện luồng P0, demo được end-to-end)
> **Gợi ý B:** TASK-003 — Rate limit + blacklist (tăng robustness trước khi public)
> **Gợi ý C:** BIZ-003 Auth — nếu muốn làm Member ngay
>
> **Bài học cho bạn:** Thứ tự ưu tiên = P0 trước, vertical trước, hardening sau. Sau này không cần file này bạn vẫn tự sắp xếp được.

## 9. Worklog link

`docs/07_WORKLOG/YYYY-MM-DD.md` — ghi 3 dòng: đã làm, học được, quyết định

---
<!-- EXAMPLE BeShort TASK-001: Điền khối trên cho POST /api/links. Xem BOARD.md:1 để biết vị trí trên kanban -->
