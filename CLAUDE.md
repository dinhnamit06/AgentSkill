# Project: {{PROJECT_NAME}} — Vibe Coding Kit (Claude mirror)

> Mirror của `AGENTS.md`. Claude Code đọc file này. Mọi thay đổi ở AGENTS.md hãy đồng bộ sang đây.

## Tech Stack
Nguồn chân lý là `docs/_meta/PROJECT_CONTEXT.md` và `docs/01_TECH_STACK.md`. Tôn trọng `Stack mode: LOCKED`; không tự đổi framework, database, ORM, ngôn ngữ hoặc deploy provider.

## Commands
- `npm run dev` | `npm test` | `npm run build` | `npm run lint --fix` | `npx tsc --noEmit`

## Workflow 5 pha (bắt buộc)
1. Chọn công nghệ → User Review
2. Nghiệp vụ → lay-yeu-cau → Spec → User Review
3. tao-prompt → Prompt → Code 1 slice → TDD
4. Review 5-axis → Worklog
5. UI/UX (chỉ sau khi logic pass)

## Boundaries — Consent bắt buộc
Không tự tiện lấy GitHub/API/thông tin cá nhân — phải hỏi consent trước, chờ user cấp mới fetch/dùng. Xem `docs/12_BAO_MAT.md:1`.

## Response Style
Trả lời ngắn, trực tiếp, không lặp context hoặc dump file. Ưu tiên: kết luận → việc làm → verify → bước tiếp theo. Chí giải thích dài khi user yêu cầu.

## Skills
- `/lay-yeu-cau` — lấy nhu cầu, sinh spec
- `/tao-prompt` — spec → prompt thi công
- `/hoc-tap` → `/internship-coach` — giải thích phần vừa làm, rồi luyện tự giải thích, debug, thay đổi hoặc viết một phần code

Xem chi tiết: `AGENTS.md` và `docs/00_WORKFLOW.md`.

---
*Portable kit v1.0 — Cài vào dự án mới: `.\install.ps1`*

