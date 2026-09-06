# SKILL GUIDE — 3 lệnh tiếng Việt dễ nhớ

> Gõ `/` trong OpenCode/Cursor là thấy gợi ý — tên tiếng Việt, không dấu, dễ nhớ.

## 3 lệnh chính

| Lệnh mới | Tên cũ | Để làm gì | Gõ khi nào | Ví dụ |
|----------|--------|-----------|------------|-------|
| `/lay-yeu-cau` | `mattpocock-requirements` | **Lấy yêu cầu** — hỏi 5 Whys → sinh BIZ + SPEC | Bắt đầu feature mới, ý tưởng còn mơ hồ | `/lay-yeu-cau tôi muốn làm rút gọn link cho Guest` |
| `/tao-prompt` | `prompt-master` | **Tạo prompt chuẩn** — biến SPEC thành prompt 6 khối để giao AI code | SPEC đã duyệt, chuẩn bị code 1 slice | `/tao-prompt SPEC-001` |
| `/internship-coach` | — | **Luyện độc lập** — giải thích, debug, tự viết, hoặc tự đổi feature | Sau một slice, khi debug, hoặc khi muốn luyện phỏng vấn | `/internship-coach kiểm tra tôi hiểu TASK-002` |

**Luồng chuẩn:** `Idea → /lay-yeu-cau → User duyệt → /tao-prompt → Code 1 slice → Test → /hoc-tap → /internship-coach → Review → Worklog → lặp`

## Alias cũ vẫn chạy?

Có — nếu gõ `/mattpocock` hay `/prompt-master` cũ, AI vẫn hiểu (đã ghi `Ten cu:` trong SKILL.md) nhưng nên dùng tên mới để đồng bộ team.

## Gợi ý sau mỗi lệnh (AI tự hỏi, bạn quyết)

* Sau `/lay-yeu-cau`: AI gợi ý `A Redirect, B Auth, C Rate-limit — bạn chọn?`
* Sau `/tao-prompt`: AI hỏi `Bạn hiểu tại sao chọn POST không? Cần giải thích line by line?` (`15_HOC_VIBE.md:C`)
* Sau slice đã verify: `internship-coach` tự kích hoạt một checkpoint nhỏ; bạn có thể gọi trực tiếp để luyện thêm.

---
*Chi tiết: `.opencode/skills/lay-yeu-cau/SKILL.md:1`, `.opencode/skills/tao-prompt/SKILL.md:1`, và `.opencode/skills/internship-coach/SKILL.md:1`.*
