# PROJECT_CONTEXT — Điền 1 lần khi tạo dự án

> File duy nhất BẮT BUỘC điền khi copy kit sang dự án mới. Mọi spec/prompt đều đọc từ đây.
> Để trống → agent phải hỏi user (không được tự bịa) — theo `context-engineering` MISSING REQUIREMENT.

## 1. Project Info
- **Tên dự án:** BeShort
- **One-liner (1 câu mô tả):** Rút gọn URL + quản lý link ngắn có thống kê click (kiểu bit.ly)
- **Mục tiêu chính:** Cho phép user tạo link ngắn, quản lý, xem analytics, chia sẻ
- **Đối tượng:** Người dùng cá nhân + team marketing

## 2. Tech Stack (chọn 1 preset trong STACK_PRESETS/ hoặc tự điền)

- **Stack mode:** LOCKED — không đổi stack nếu chưa được user duyệt

- **Frontend:** TypeScript 5, React 18 (Vite), Tailwind CSS 4, shadcn/ui
- **Backend:** TypeScript, Node.js 22, Express
- **Database:** PostgreSQL 16 + Prisma
- **Mobile (nếu có):** Dart + Flutter 3.x
- **Auth/Storage:** Supabase Auth + S3-compatible
- **Test:** Vitest + Testing Library + Supertest
- **Deploy:** Vercel (FE) + Railway/Fly (BE) / Supabase

## 3. Constraints & Quy ước

- Mỗi lần chỉ làm 1 chức năng nhỏ (1 slice = DB+API+test)
- Không làm UI khi logic chưa pass test
- Không tự ý đổi framework, database, ORM, language hoặc deployment provider
- Mọi thay đổi DB phải có migration + review
- Ngôn ngữ docs: Tiếng Việt (nghiệp vụ/worklog), code/spec: Tiếng Anh

## 4. Liên kết

- Workflow: `docs/00_WORKFLOW.md`
- Tech chi tiết: `docs/01_TECH_STACK.md`
- Backlog: `docs/02_BUSINESS/BACKLOG.md`

---
*Cách dùng ở dự án mới: copy file này từ `PROJECT_CONTEXT.template.md` và điền. Xem `STACK_PRESETS/` để chọn nhanh.*
