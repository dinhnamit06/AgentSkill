# PROJECT_CONTEXT — Template (copy khi tạo dự án mới)

> Điền file này rồi copy thành `PROJECT_CONTEXT.md`. Mọi agent sẽ đọc nó đầu tiên.

## 1. Project Info
- **Tên dự án:** {{PROJECT_NAME}}
- **One-liner:** {{ONE_LINER}} — mô tả 1 câu dự án làm gì
- **Mục tiêu chính:** {{GOAL}}
- **Đối tượng:** {{AUDIENCE}}

## 2. Tech Stack

- **Stack mode:** LOCKED — agent must not change the stack without explicit user approval

- **Frontend:** {{FRONTEND}} — recommended: TypeScript 5 + React 18 + Vite
- **Backend:** {{BACKEND}} — recommended: TypeScript + Node.js 22 + Express
- **Database:** {{DATABASE}} — recommended: PostgreSQL 16 + Prisma
- **Mobile:** {{MOBILE}} — vd: Dart + Flutter 3.x / hoặc N/A
- **Auth/Storage:** {{AUTH_STORAGE}}
- **Test:** {{TEST}}
- **Deploy:** {{DEPLOY}}

> Gợi ý: copy 1 preset từ `STACK_PRESETS/` cho nhanh.

## 3. Constraints & Quy ước

- {{CONSTRAINT_1}}
- Mỗi lần chỉ làm 1 chức năng nhỏ
- Không làm UI khi logic chưa pass
- Không tự ý đổi framework, database, ORM, language hoặc deployment provider khi `Stack mode` là `LOCKED`
- Nếu cần thêm dependency, giải thích lý do, trade-off, bundle/security impact và chờ user duyệt

## 4. Liên kết

- Workflow: `docs/00_WORKFLOW.md`
- Tech chi tiết: `docs/01_TECH_STACK.md`
- Learning map: `docs/LEARNING_MAP.md`
