# SKILL GUIDE — 2 lệnh tiếng Việt dễ nhớ

> Gõ `/` trong OpenCode/Cursor là thấy gợi ý — tên tiếng Việt, không dấu, dễ nhớ.

## 2 lệnh chính

| Lệnh mới | Tên cũ | Để làm gì | Gõ khi nào | Ví dụ |
|----------|--------|-----------|------------|-------|
| `/lay-yeu-cau` | `mattpocock-requirements` | **Lấy yêu cầu** — hỏi 5 Whys → sinh BIZ + SPEC | Bắt đầu feature mới, ý tưởng còn mơ hồ | `/lay-yeu-cau tôi muốn làm rút gọn link cho Guest` |
| `/tao-prompt` | `prompt-master` | **Tạo prompt chuẩn** — biến SPEC thành prompt 6 khối để giao AI code | SPEC đã duyệt, chuẩn bị code 1 slice | `/tao-prompt SPEC-001` |

**Luồng chuẩn:** `Idea → /lay-yeu-cau → User duyệt → /tao-prompt → Code 1 slice → Test → Review → Worklog → lặp`

## Alias cũ vẫn chạy?

Có — nếu gõ `/mattpocock` hay `/prompt-master` cũ, AI vẫn hiểu (đã ghi `Ten cu:` trong SKILL.md) nhưng nên dùng tên mới để đồng bộ team.

## Gợi ý sau mỗi lệnh (AI tự hỏi, bạn quyết)

* Sau `/lay-yeu-cau`: AI gợi ý `A Redirect, B Auth, C Rate-limit — bạn chọn?`
* Sau `/tao-prompt`: AI hỏi `Bạn hiểu tại sao chọn POST không? Cần giải thích line by line?` (`15_HOC_VIBE.md:C`)

---
*Chi tiết: `.opencode/skills/lay-yeu-cau/SKILL.md:1` và `.opencode/skills/tao-prompt/SKILL.md:1`*
