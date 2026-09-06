# PROMPT-002 — Thực hành độc lập khi dùng AI

> Author: AI (Codex). WHY: liên kết skill với yêu cầu internship và bằng chứng thực hành. Scope: một slice nâng cấp bộ skill, không đổi ứng dụng.

## 1. Context

Người dùng cần hiểu kiến trúc, giải thích code AI, tự debug, tự thay đổi feature và tự viết code. Đã yêu cầu hoàn chỉnh bộ skill và push Git trong hội thoại hiện tại.

## 2. Yêu cầu

Thêm internship-coach với explain-back, debug-first, code-first và feature-change drill. Gắn vào coordinator và hoc-tap để dành phần thực hành cho người dùng, theo dõi trợ giúp và không tự nhận người dùng đã thành thạo.

## 3. Scope

Skills trong `.opencode/skills/`, các quy tắc và tài liệu learning liên quan; cài skill mới tại thư mục Codex cá nhân. Sửa UTF-8 của bảy tài liệu đã phát hiện hỏng encoding. Giữ nguyên ba thay đổi có sẵn ở BACKLOG, BOARD và DECISIONS. Không sửa runtime, database, dependency hay release target.

## 4. Ví dụ chấp nhận

- Người dùng trả lời “OK”: bài tập còn pending, không đánh dấu đã biết.
- Người dùng đang tự viết: đưa hint nếu cần, không điền phần dành cho họ.
- Yêu cầu ship ngay: ship phần đã được ủy quyền, ghi việc thực hành còn chờ.
- Kế hoạch đổi feature đúng: chỉ xác nhận kế hoạch; cần code và test mới chứng minh tự sửa được.

## 5. Ràng buộc

UTF-8; header 3 Biết; ≤300 dòng/file, ≤50 dòng/hàm nếu tạo code; tên rõ, DRY/YAGNI, tách trách nhiệm. Mỗi lần chỉ một câu hỏi học tập. Không bịa bằng chứng hay tuyên bố đã pass kiểm tra chưa chạy.

## 6. Verify và giao hàng

Validate skill, review đường dẫn và tình huống hành vi, diff check. Dùng kết quả test/build/type check/audit của lần kiểm tra hiện tại; ghi lint thiếu ESLint là giới hạn sẵn có. Commit có attribution PROMPT-002 rồi push origin/master theo ủy quyền; không đưa thay đổi riêng của người dùng vào commit.
