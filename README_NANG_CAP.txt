HUỲNH CẢNH PC – QUOTATION PRO
BẢN NÂNG CẤP ĐĂNG NHẬP ADMIN / SALE + SUPABASE
================================================

THÀNH PHẦN
- index.html: giao diện báo giá cũ, thêm màn hình đăng nhập và kết nối Supabase.
- supabase/01_admin_sale_setup.sql: migration tạo hồ sơ tài khoản và phân quyền RLS.
- supabase/functions/admin-users/index.ts: Edge Function để ADMIN tạo/khóa/mở khóa tài khoản SALE.
- Các file PWA còn lại được giữ từ bản gốc.

QUAN TRỌNG TRƯỚC KHI CÀI
1. Sao lưu báo giá bằng nút “Sao lưu dữ liệu” ở bản đang dùng.
2. Không xóa 3 bảng cũ hcpc_pc_configs, hcpc_quotes, hcpc_store_settings.
3. Không đặt service_role/secret key trong index.html. Chỉ Publishable/anon key mới được đặt phía trình duyệt.

BƯỚC A — CHẠY SQL
1. Vào Supabase Dashboard > SQL Editor > New query.
2. Mở file supabase/01_admin_sale_setup.sql, sao chép toàn bộ nội dung vào SQL Editor.
3. Nhấn RUN.
4. Script tạo bảng hcpc_profiles, trigger tạo profile khi có user mới và thay policy RLS cũ trên 3 bảng. Script không xóa các bảng/bản ghi báo giá.
5. ADMIN được nhận diện theo đúng email: vanlamnguyen147@gmail.com.

BƯỚC B — TẠO / KIỂM TRA TÀI KHOẢN ADMIN
- Nếu email vanlamnguyen147@gmail.com đã có trong Authentication > Users, migration sẽ tạo/cập nhật profile ADMIN.
- Nếu chưa có: sau khi chạy SQL, vào Authentication > Users > Add user, tạo user với email vanlamnguyen147@gmail.com, đặt mật khẩu mạnh và xác nhận email (Auto Confirm).
- Đăng nhập lần đầu bằng email và mật khẩu vừa tạo.
- Không gửi mật khẩu cho người khác.

BƯỚC C — TRIỂN KHAI EDGE FUNCTION ĐỂ ADMIN QUẢN LÝ SALE
Yêu cầu cài Supabase CLI và đăng nhập CLI.
Tại thư mục dự án (nơi có thư mục supabase), chạy:
  supabase link --project-ref qlsgdhwlakujazmlamdi

Đặt service role key trong secrets của Supabase (lấy tại Project Settings > API Keys; tuyệt đối không đưa key này vào index.html):
  supabase secrets set SUPABASE_SERVICE_ROLE_KEY=YOUR_SERVICE_ROLE_SECRET --project-ref qlsgdhwlakujazmlamdi

Triển khai function:
  supabase functions deploy admin-users --project-ref qlsgdhwlakujazmlamdi

Nếu dùng Dashboard thay CLI, tạo Edge Function tên admin-users và dán nội dung file index.ts; cấu hình SUPABASE_SERVICE_ROLE_KEY trong Edge Function Secrets.

BƯỚC D — ĐƯA WEBSITE LÊN HTTPS
- Upload toàn bộ nội dung gói này lên hosting HTTPS.
- Mở website bằng trình duyệt, đăng nhập ADMIN.
- Không mở trực tiếp file index.html bằng file://; PWA cần HTTPS.

QUYỀN ĐƯỢC CẤU HÌNH
- ADMIN: xem toàn bộ báo giá, tạo/khóa/mở khóa SALE, quản lý thông tin cửa hàng.
- SALE: xem báo giá chung; tạo/sửa/xóa báo giá do chính tài khoản mình tạo; không quản lý tài khoản hoặc thông tin cửa hàng.
- Cấu hình PC: nhân viên đang hoạt động xem được; người tạo hoặc ADMIN sửa/xóa.
- Mật khẩu do Supabase Auth quản lý.

LƯU Ý DỮ LIỆU CŨ
- Khi đăng nhập lần đầu trên một trình duyệt có lịch sử localStorage, app sẽ thử tải các báo giá local chưa có trên cloud lên Supabase và gán chủ sở hữu cho tài khoản đăng nhập đầu tiên.
- Vì vậy nên đăng nhập ADMIN trước trên máy đang chứa dữ liệu báo giá cũ.
- App tải tối đa 500 báo giá gần nhất vào danh sách lịch sử. Hãy giữ file backup JSON như bản dự phòng.
- Bản nâng cấp kết nối bảng hcpc_quotes và hcpc_store_settings. Bảng cấu hình hcpc_pc_configs vẫn được giữ và có RLS; giao diện báo giá hiện tại không có màn hình quản lý cấu hình riêng.

KIỂM TRA SAU CÀI ĐẶT
1. Đăng nhập ADMIN.
2. Tạo một tài khoản SALE từ nút “Quản lý SALE”.
3. Đăng xuất, đăng nhập bằng SALE.
4. Thử tạo báo giá; đăng nhập ADMIN để xác nhận báo giá xuất hiện trong lịch sử chung.
5. Kiểm tra SALE không thấy nút quản lý SALE và không được sửa thông tin cửa hàng.

Nếu SQL báo lỗi, dừng lại và gửi ảnh lỗi; không chạy lệnh DROP/RESET khác.
