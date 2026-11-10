HUỲNH CẢNH PC – QUOTATION PRO V3 ONLINE
=======================================

BỘ NÀY ĐÃ TÍCH HỢP KẾT NỐI SUPABASE:
- Đăng ký / đăng nhập email, mật khẩu.
- Đồng bộ báo giá, kho cấu hình PC và thông tin cửa hàng.
- Dữ liệu local vẫn được giữ trên thiết bị.
- Dùng chung dữ liệu cho các tài khoản đã đăng nhập cùng một Supabase project.

CẦN THIẾT LẬP MỘT LẦN:
1. Tạo tài khoản tại https://supabase.com và tạo project.
2. Mở SQL Editor, dán toàn bộ nội dung SUPABASE_SETUP.sql rồi Run.
3. Vào Project Settings > API (hoặc Data API / API Keys), sao chép Project URL
   và public anon/publishable key. TUYỆT ĐỐI KHÔNG dùng service_role/secret key.
4. Đưa TOÀN BỘ file trong gói lên hosting HTTPS (GitHub Pages, Netlify hoặc hosting khác).
5. Mở website, điền Project URL, public key, email và mật khẩu.
6. Tạo tài khoản cho từng nhân viên hoặc đăng ký từ màn hình ứng dụng.
   Nếu bật xác nhận email trong Supabase, xác nhận email trước khi đăng nhập.
7. Sau khi đăng nhập, nhấn “Đồng bộ ngay” trên từng thiết bị.

LƯU Ý QUAN TRỌNG:
- Đây là bản đồng bộ thủ công qua nút “Đồng bộ ngay”, không phải realtime tức thì.
- Bản hiện tại hợp nhất danh sách theo ID; nếu hai người cùng sửa một báo giá/cấu hình
  ở hai máy cùng lúc, cần thống nhất người chỉnh sửa để tránh ghi đè.
- Các tài khoản đã đăng nhập cùng project được quyền đọc/ghi dữ liệu chung.
  Chỉ tạo tài khoản cho nhân viên tin cậy. Chưa có phân quyền admin/nhân viên.
- Supabase free tier có giới hạn dung lượng và có thể tạm dừng project ít hoạt động.
- Dữ liệu cục bộ không tự biến mất; nên sao lưu JSON trước khi triển khai.
- Service worker đã đổi cache version để trình duyệt nhận bản mới.
