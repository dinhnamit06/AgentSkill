# PROJECT_CONTEXT — Template (copy khi tạo dự án mới)

> Điền file này rồi copy thành `PROJECT_CONTEXT.md`. Mọi agent sẽ đọc nó đầu tiên.

## 1. Project Info
- **Tên dự án:** {{PROJECT_NAME}}
- **One-liner:** {{ONE_LINER}} — mô tả 1 câu dự án làm gì
- **Mục tiêu chính:** {{GOAL}}
- **Đối tượng:** {{AUDIENCE}}

## 2. Tech Stack

- **Frontend:** {{FRONTEND}} — vd: TypeScript 5, React 18 (Vite), Tailwind 4, shadcn/ui
- **Backend:** {{BACKEND}} — vd: TypeScript, Node 22, Fastify
- **Database:** TBD — chon sau khi co BIZ/SPEC (ERD) — vd: PostgreSQL 16 + Prisma (xem 01_TECH_STACK.md)
- **Mobile:** {{MOBILE}} — vd: Dart + Flutter 3.x / hoặc N/A
- **Auth/Storage:** {{AUTH_STORAGE}}
- **Test:** {{TEST}}
- **Deploy:** {{DEPLOY}}

> Gợi ý: copy 1 preset từ `STACK_PRESETS/` cho nhanh.

## 3. Constraints & Quy ước

- {{CONSTRAINT_1}}
- Mỗi lần chỉ làm 1 chức năng nhỏ
- Không làm UI khi logic chưa pass

## 4. Liên kết

- Workflow: `docs/00_WORKFLOW.md`
- Tech chi tiết: `docs/01_TECH_STACK.md`
