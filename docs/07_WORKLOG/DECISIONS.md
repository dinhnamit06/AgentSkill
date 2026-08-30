# DECISIONS — Architecture Decision Records (ADR)

> Ghi mọi quyết định “tại sao chọn X không chọn Y”. Sau này người mới đọc là hiểu, không phải hỏi lại.
> Mẫu: Mỗi ADR 10 dòng, có ngày + người duyệt + trade-off.

## ADR-001: Chọn stack TS + React + Node + Postgres cho BeShort

- **Ngày:** 2026-08-22
- **Trạng thái:** Approved
- **Bối cảnh:** Cần stack phổ biến để AI gen tốt, team dễ tuyển, vibe code nhanh.
- **Quyết định:** TS 5 + React 18 (Vite) + Tailwind 4 + Fastify + Postgres 16 + Prisma
- **Lý do:** Vite nhanh, Fastify schema validation, Prisma type-safe, Supabase Auth sẵn
- **Trade-off:** Không SSR (chấp nhận vì BeShort không cần SEO nặng), nếu sau cần SEO → thêm Next.js BFF
- **Người duyệt:** @tech-lead

## ADR-002: 1 TASK = 1 slice vertical (DB+API+test, chưa UI)

- **Ngày:** 2026-08-22
- **Trạng thái:** Approved
- **Bối cảnh:** Team hay gộp nhiều việc 1 PR → review lâu, khó revert
- **Quyết định:** Mỗi TASK ≤300 dòng, 1 PR, 1 review 5-axis, 1 worklog
- **Lý do:** Incremental-implementation + tips #5 — dễ test, dễ demo, dễ học
- **Trade-off:** Nhiều PR hơn, nhưng mỗi PR review 15p thay vì 2h

## ADR-003: Logic trước UI (Pha 5 sau cùng)

- **Ngày:** 2026-08-22
- **Trạng thái:** Approved
- **Quyết định:** Không làm UI khi logic chưa 100% pass test
- **Lý do:** UI đổi nhiều khi logic đổi — làm UI sớm = làm lại
- **Ngoại lệ:** Có thể làm wireframe low-fi ở pha 2 để lấy feedback UX, nhưng không code UI.

---
*Thêm ADR mới khi có quyết định quan trọng. Đánh số tăng dần.*
