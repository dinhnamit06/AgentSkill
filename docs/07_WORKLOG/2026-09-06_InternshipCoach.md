# Worklog — Internship coach

> Author: AI (Codex). WHY: lưu scope, kiểm chứng và giới hạn thực tế. Prompt: ../04_PROMPTS/PROMPT-002_InternshipCoach.md.

## Phạm vi và gate

- DRAFT: đối chiếu bộ skill với năm năng lực internship trong hội thoại.
- APPROVED: người dùng yêu cầu “hoàn chỉnh bộ skill và push lên git”.
- PLANNED: một slice thêm coach, kết nối workflow, kiểm tra và push; đã công bố kế hoạch trong hội thoại.
- IMPLEMENTING: thêm skill và cập nhật quy tắc, learning docs; sửa encoding bảy tài liệu.
- VERIFIED cho scope Markdown: skill validation và diff check pass. Kiểm tra runtime tham khảo bên dưới; lint chưa khả dụng.
- REVIEWED: review độc lập chỉ ra ba khoảng trống (quá nhiều câu hỏi, chỉ lập kế hoạch đổi feature, suy diễn từ giải thích sang tự code); đã sửa đủ ba. Kết quả push được ghi trong Git và phản hồi cuối.

## Bằng chứng kiểm tra

- `npm test`: 2 file, 5 test pass.
- `npx tsc --noEmit` và `npm run build`: pass.
- `npm run lint -- --fix`: không chạy được vì ESLint không được cài/khai báo, đã xác nhận lỗi có sẵn ở HEAD; không có file runtime thay đổi.
- Security audit: script trả PASS; npm audit báo 4 high. Script hiện chỉ cảnh báo, nên PASS của script không có nghĩa không còn lỗ hổng. Chưa thay dependencies.
- Skill validator chạy với Python UTF-8: ba skill đã kiểm tra hợp lệ; bản cập nhật cuối được validate trước commit.
- Không có thay đổi DB, deploy hoặc runtime. Rollback: revert commit của slice này.

## Học và thực hành

- Khái niệm: skill hướng dẫn hành vi AI; bằng chứng người học cần đến từ câu trả lời/code/test thật.
- Phân vai: hoc-tap giải thích ngắn; internship-coach dành phần tự làm và kiểm tra mức trợ giúp.
- Checkpoint: pending; chưa có bài làm để đánh giá năng lực của người dùng. Yêu cầu hiện tại là hoàn chỉnh và ship bộ skill.
- Bài tiếp theo: tự lần theo luồng một request của BeShort và giải thích vì sao validation nằm ở boundary.

## Giữ nguyên thay đổi của người dùng

`docs/02_BUSINESS/BACKLOG.md`, `docs/05_TASKS/BOARD.md`, `docs/07_WORKLOG/DECISIONS.md` không thuộc commit này.
