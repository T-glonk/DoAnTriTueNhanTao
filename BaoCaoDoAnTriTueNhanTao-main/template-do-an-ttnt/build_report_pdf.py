import os
from reportlab.lib.pagesizes import A4
from reportlab.lib import colors
from reportlab.pdfgen import canvas
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from PIL import Image
from pypdf import PdfReader, PdfWriter

# 1. Đăng ký fonts Unicode
pdfmetrics.registerFont(TTFont('Arial', 'C:/Windows/Fonts/arial.ttf'))
pdfmetrics.registerFont(TTFont('Arial-Bold', 'C:/Windows/Fonts/arialbd.ttf'))
pdfmetrics.registerFont(TTFont('Arial-Italic', 'C:/Windows/Fonts/ariali.ttf'))

PAGE_WIDTH, PAGE_HEIGHT = A4  # 595.28 x 841.89 pt
LEFT_MARGIN = 50
RIGHT_MARGIN = 50
CONTENT_WIDTH = PAGE_WIDTH - LEFT_MARGIN - RIGHT_MARGIN

COLOR_NAVY = colors.HexColor('#1A2B49')
COLOR_MAROON = colors.HexColor('#8B1E1E')
COLOR_GRAY = colors.HexColor('#555555')
COLOR_LINE = colors.HexColor('#CCCCCC')
COLOR_DARK = colors.HexColor('#222222')

def draw_header_footer(c, page_num):
    # Header
    c.setFont('Arial-Italic', 9)
    c.setFillColor(COLOR_GRAY)
    c.drawString(LEFT_MARGIN, PAGE_HEIGHT - 36, "Chương 4. Cài đặt và thử nghiệm")
    
    c.setFont('Arial-Bold', 8.5)
    c.setFillColor(COLOR_NAVY)
    c.drawRightString(PAGE_WIDTH - RIGHT_MARGIN, PAGE_HEIGHT - 36, "BÁO CÁO ĐỒ ÁN TRÍ TUỆ NHÂN TẠO")
    
    c.setStrokeColor(COLOR_LINE)
    c.setLineWidth(0.6)
    c.line(LEFT_MARGIN, PAGE_HEIGHT - 42, PAGE_WIDTH - RIGHT_MARGIN, PAGE_HEIGHT - 42)
    
    # Footer
    c.line(LEFT_MARGIN, 44, PAGE_WIDTH - RIGHT_MARGIN, 44)
    c.setFont('Arial', 8.5)
    c.setFillColor(COLOR_GRAY)
    c.drawString(LEFT_MARGIN, 32, "Phạm Tấn Hào (2351220282) · Trần Quốc Trung (2351220096)")
    c.drawRightString(PAGE_WIDTH - RIGHT_MARGIN, 32, str(page_num))

figs_dir = os.path.join(os.path.dirname(__file__), 'figs')
temp_ui_pdf = os.path.join(os.path.dirname(__file__), 'temp_ui_pages.pdf')

c = canvas.Canvas(temp_ui_pdf, pagesize=A4)

# Danh sách nội dung từng trang
# =========================================================================
# TRANG 1: Giới thiệu mục 4.3 + 4.3.1 + Hình 4.1 + Hình 4.2
# =========================================================================
draw_header_footer(c, 39)
y = PAGE_HEIGHT - 65

# Tiêu đề mục 4.3
c.setFont('Arial-Bold', 14)
c.setFillColor(COLOR_NAVY)
c.drawString(LEFT_MARGIN, y, "4.3. Cài đặt phía Frontend và Giao diện người dùng")
y -= 20

# Giới thiệu
c.setFont('Arial', 9.5)
c.setFillColor(COLOR_DARK)
intro_text = "Ứng dụng Frontend của hệ thống FoodAI được xây dựng dựa trên nền tảng React 18, Vite và TailwindCSS,"
c.drawString(LEFT_MARGIN, y, intro_text)
y -= 14
intro_text2 = "tối ưu hóa giao diện người dùng theo phong cách hiện đại, trực quan và đáp ứng trên nhiều kích thước màn hình."
c.drawString(LEFT_MARGIN, y, intro_text2)
y -= 22

# Tiêu đề mục 4.3.1
c.setFont('Arial-Bold', 11.5)
c.setFillColor(COLOR_MAROON)
c.drawString(LEFT_MARGIN, y, "4.3.1. Giao diện phân hệ Khách hàng (Client Web Application)")
y -= 18

# Hình 4.1: Đăng ký
img1_path = os.path.join(figs_dir, 'ui_dang_ky.jpg')
img_w = 380
img_h = img_w * (768 / 1366)
img_x = LEFT_MARGIN + (CONTENT_WIDTH - img_w) / 2
c.drawImage(img1_path, img_x, y - img_h, width=img_w, height=img_h)
y -= (img_h + 14)

c.setFont('Arial-Bold', 9)
c.setFillColor(COLOR_NAVY)
c.drawCentredString(PAGE_WIDTH / 2, y, "Hình 4.1. Giao diện Đăng ký tài khoản người dùng mới trên FoodAI.")
y -= 22

# Hình 4.2: Đăng nhập
img2_path = os.path.join(figs_dir, 'ui_dang_nhap.jpg')
c.drawImage(img2_path, img_x, y - img_h, width=img_w, height=img_h)
y -= (img_h + 14)

c.setFont('Arial-Bold', 9)
c.setFillColor(COLOR_NAVY)
c.drawCentredString(PAGE_WIDTH / 2, y, "Hình 4.2. Giao diện Đăng nhập hệ thống (tích hợp phím tắt tài khoản Demo).")

c.showPage()

# =========================================================================
# TRANG 2: Hình 4.3 (Dashboard) + Hình 4.4 (Modal Chi tiết)
# =========================================================================
draw_header_footer(c, 40)
y = PAGE_HEIGHT - 65

# Hình 4.3: Dashboard
img3_path = os.path.join(figs_dir, 'ui_trang_chu_dashboard.jpg')
img_w3 = 450
img_h3 = img_w3 * (768 / 1366)
img_x3 = LEFT_MARGIN + (CONTENT_WIDTH - img_w3) / 2
c.drawImage(img3_path, img_x3, y - img_h3, width=img_w3, height=img_h3)
y -= (img_h3 + 14)

c.setFont('Arial-Bold', 9)
c.setFillColor(COLOR_NAVY)
c.drawCentredString(PAGE_WIDTH / 2, y, "Hình 4.3. Giao diện Bảng điều khiển Gợi ý món ăn thông minh (Home Dashboard).")
y -= 15

c.setFont('Arial', 9)
c.setFillColor(COLOR_DARK)
desc3 = "Giao diện hỗ trợ nhập nguyên liệu dạng Tag động, chọn nhanh các nguyên liệu phổ biến và combo gợi ý sẵn có."
c.drawCentredString(PAGE_WIDTH / 2, y, desc3)
y -= 26

# Hình 4.4: Modal Chi tiết
img4_path = os.path.join(figs_dir, 'ui_modal_chi_tiet_mon.jpg')
img_w4 = 370
img_h4 = img_w4 * (768 / 1366)
img_x4 = LEFT_MARGIN + (CONTENT_WIDTH - img_w4) / 2
c.drawImage(img4_path, img_x4, y - img_h4, width=img_w4, height=img_h4)
y -= (img_h4 + 14)

c.setFont('Arial-Bold', 9)
c.setFillColor(COLOR_NAVY)
c.drawCentredString(PAGE_WIDTH / 2, y, "Hình 4.4. Giao diện Modal Chi tiết Công thức nấu và Phân tích dinh dưỡng từ AI Chef.")
y -= 15

c.setFont('Arial', 9)
c.setFillColor(COLOR_DARK)
desc4 = "Modal 3 Tab tương tác gồm: Lời khuyên đầu bếp (AI Chef Insights), Cách làm từng bước, Nguyên liệu và Dinh dưỡng."
c.drawCentredString(PAGE_WIDTH / 2, y, desc4)

c.showPage()

# =========================================================================
# TRANG 3: Hình 4.5 (Yêu thích) + Hình 4.6 (Lịch sử tìm kiếm)
# =========================================================================
draw_header_footer(c, 41)
y = PAGE_HEIGHT - 65

# Hình 4.5: Yêu thích
img5_path = os.path.join(figs_dir, 'ui_mon_an_yeu_thich.jpg')
c.drawImage(img5_path, img_x3, y - img_h3, width=img_w3, height=img_h3)
y -= (img_h3 + 14)

c.setFont('Arial-Bold', 9)
c.setFillColor(COLOR_NAVY)
c.drawCentredString(PAGE_WIDTH / 2, y, "Hình 4.5. Giao diện Quản lý Danh sách Món ăn yêu thích của người dùng.")
y -= 15

c.setFont('Arial', 9)
c.setFillColor(COLOR_DARK)
desc5 = "Lưu trữ bộ sưu tập món ăn tâm đắc kèm thông tin khẩu phần, lượng calo, lời khuyên đầu bếp và thao tác xóa."
c.drawCentredString(PAGE_WIDTH / 2, y, desc5)
y -= 26

# Hình 4.6: Lịch sử tìm kiếm
img6_path = os.path.join(figs_dir, 'ui_lich_su_tim_kiem.jpg')
c.drawImage(img6_path, img_x3, y - img_h3, width=img_w3, height=img_h3)
y -= (img_h3 + 14)

c.setFont('Arial-Bold', 9)
c.setFillColor(COLOR_NAVY)
c.drawCentredString(PAGE_WIDTH / 2, y, "Hình 4.6. Giao diện Lịch sử tìm kiếm nguyên liệu và Tính năng tái sử dụng (Dùng lại).")
y -= 15

c.setFont('Arial', 9)
c.setFillColor(COLOR_DARK)
desc6 = "Tự động ghi nhận 20 lần tìm kiếm gần nhất; hỗ trợ 1-click 'Dùng lại' để nạp lại combo nguyên liệu nhanh chóng."
c.drawCentredString(PAGE_WIDTH / 2, y, desc6)

c.showPage()

# =========================================================================
# TRANG 4: Hình 4.7 (Profile) + Mục 4.3.2 + Hình 4.8 (Admin Overview)
# =========================================================================
draw_header_footer(c, 42)
y = PAGE_HEIGHT - 65

# Hình 4.7: Profile
img7_path = os.path.join(figs_dir, 'ui_thong_tin_tai_khoan.jpg')
img_w7 = 400
img_h7 = img_w7 * (768 / 1366)
img_x7 = LEFT_MARGIN + (CONTENT_WIDTH - img_w7) / 2
c.drawImage(img7_path, img_x7, y - img_h7, width=img_w7, height=img_h7)
y -= (img_h7 + 14)

c.setFont('Arial-Bold', 9)
c.setFillColor(COLOR_NAVY)
c.drawCentredString(PAGE_WIDTH / 2, y, "Hình 4.7. Giao diện Quản lý Thông tin tài khoản cá nhân và Đổi mật khẩu.")
y -= 24

# Tiêu đề mục 4.3.2 Admin Panel
c.setFont('Arial-Bold', 11.5)
c.setFillColor(COLOR_MAROON)
c.drawString(LEFT_MARGIN, y, "4.3.2. Giao diện phân hệ Quản trị viên (Admin Panel)")
y -= 18

# Hình 4.8: Admin Tổng quan
img8_path = os.path.join(figs_dir, 'ui_admin_tong_quan.jpg')
c.drawImage(img8_path, img_x3, y - img_h3, width=img_w3, height=img_h3)
y -= (img_h3 + 14)

c.setFont('Arial-Bold', 9)
c.setFillColor(COLOR_NAVY)
c.drawCentredString(PAGE_WIDTH / 2, y, "Hình 4.8. Giao diện Bảng điều khiển Tổng quan Quản trị và Thống kê thời gian thực.")
y -= 15

c.setFont('Arial', 9)
c.setFillColor(COLOR_DARK)
desc8 = "Trực quan hóa các chỉ số KPI hệ thống, biểu đồ cột Recharts Top nguyên liệu và tỷ lệ trạng thái tài khoản."
c.drawCentredString(PAGE_WIDTH / 2, y, desc8)

c.showPage()

# =========================================================================
# TRANG 5: Hình 4.9 (Admin Users) + Hình 4.10 (Admin Kho Món Ăn)
# =========================================================================
draw_header_footer(c, 43)
y = PAGE_HEIGHT - 65

# Hình 4.9: Quản lý người dùng
img9_path = os.path.join(figs_dir, 'ui_admin_quan_ly_nguoi_dung.jpg')
c.drawImage(img9_path, img_x3, y - img_h3, width=img_w3, height=img_h3)
y -= (img_h3 + 14)

c.setFont('Arial-Bold', 9)
c.setFillColor(COLOR_NAVY)
c.drawCentredString(PAGE_WIDTH / 2, y, "Hình 4.9. Giao diện Quản lý danh sách Người dùng và Phân quyền tài khoản.")
y -= 15

c.setFont('Arial', 9)
c.setFillColor(COLOR_DARK)
desc9 = "Quản lý toàn bộ tài khoản với tìm kiếm thời gian thực, phân quyền, đặt lại mật khẩu và khóa/kích hoạt tài khoản."
c.drawCentredString(PAGE_WIDTH / 2, y, desc9)
y -= 26

# Hình 4.10: Kho Món Ăn Cookpad
img10_path = os.path.join(figs_dir, 'ui_admin_kho_mon_an.jpg')
c.drawImage(img10_path, img_x3, y - img_h3, width=img_w3, height=img_h3)
y -= (img_h3 + 14)

c.setFont('Arial-Bold', 9)
c.setFillColor(COLOR_NAVY)
c.drawCentredString(PAGE_WIDTH / 2, y, "Hình 4.10. Giao diện Quản lý Kho Món Ăn và Hình ảnh Cookpad CDN (MySQL).")
y -= 15

c.setFont('Arial', 9)
c.setFillColor(COLOR_DARK)
desc10 = "Lưu trữ hơn 218 món ăn chuẩn mực, bộ lọc 7 danh mục ẩm thực, ảnh Cookpad CDN 100% khớp và thao tác CRUD công thức."
c.drawCentredString(PAGE_WIDTH / 2, y, desc10)

c.showPage()

# =========================================================================
# TRANG 6: Hình 4.11 (AI Query Logs) + Hình 4.12 (Cấu hình hệ thống)
# =========================================================================
draw_header_footer(c, 44)
y = PAGE_HEIGHT - 65

# Hình 4.11: AI Query Logs
img11_path = os.path.join(figs_dir, 'ui_admin_lich_su_ai_logs.jpg')
c.drawImage(img11_path, img_x3, y - img_h3, width=img_w3, height=img_h3)
y -= (img_h3 + 14)

c.setFont('Arial-Bold', 9)
c.setFillColor(COLOR_NAVY)
c.drawCentredString(PAGE_WIDTH / 2, y, "Hình 4.11. Giao diện Giám sát Lịch sử Tìm kiếm và Nhật ký AI Query Logs.")
y -= 15

c.setFont('Arial', 9)
c.setFillColor(COLOR_DARK)
desc11 = "Giám sát trực tiếp các lượt gọi AI gợi ý món ăn theo thời gian thực (thời gian, người dùng, nguyên liệu tag màu)."
c.drawCentredString(PAGE_WIDTH / 2, y, desc11)
y -= 26

# Hình 4.12: Cấu hình hệ thống
img12_path = os.path.join(figs_dir, 'ui_admin_cai_dat_he_thong.jpg')
c.drawImage(img12_path, img_x3, y - img_h3, width=img_w3, height=img_h3)
y -= (img_h3 + 14)

c.setFont('Arial-Bold', 9)
c.setFillColor(COLOR_NAVY)
c.drawCentredString(PAGE_WIDTH / 2, y, "Hình 4.12. Giao diện Cấu hình Hệ thống, Giám sát Mô hình AI Gemini và CSDL MySQL.")
y -= 15

c.setFont('Arial', 9)
c.setFillColor(COLOR_DARK)
desc12 = "Theo dõi trạng thái AI Engine Gemini (gemini-3.6-flash), kết nối MySQL, Uptime và bộ nhớ máy chủ Node.js runtime."
c.drawCentredString(PAGE_WIDTH / 2, y, desc12)

c.showPage()
c.save()

print('Generated temp_ui_pages.pdf successfully!')

# 2. GHÉP VÀO FILE DO-AN.PDF GỐC
base_pdf_path = os.path.join(os.path.dirname(__file__), 'do-an.pdf')
out_pdf_path = os.path.join(os.path.dirname(__file__), 'do-an-cap-nhat.pdf')
root_out_pdf = os.path.join(os.getcwd(), 'do-an-cap-nhat.pdf')

base_reader = PdfReader(base_pdf_path)
ui_reader = PdfReader(temp_ui_pdf)

writer = PdfWriter()

# Lấy trang 0 đến 37 (tức trang 1 đến 38 của tài liệu cũ: từ bìa đến hết code Backend của Chương 4)
for i in range(38):
    writer.add_page(base_reader.pages[i])

# Thêm 6 trang giao diện mới (thay thế cho trang 39 cũ chỉ có hình vẽ mô phỏng TikZ)
for page in ui_reader.pages:
    writer.add_page(page)

# Thêm tiếp từ trang 39 cũ trở đi (trang 40 đến trang 50 cũ: Bảng kiểm thử, Chương 5, Chương 6, Phụ lục)
for i in range(39, len(base_reader.pages)):
    writer.add_page(base_reader.pages[i])

with open(out_pdf_path, 'wb') as f:
    writer.write(f)

print(f'Created updated PDF: {out_pdf_path} (Total pages: {len(writer.pages)})')

# Copy ra thư mục gốc
with open(root_out_pdf, 'wb') as f:
    writer.write(f)
print(f'Copied to root directory: {root_out_pdf}')

# Xóa file tạm
if os.path.exists(temp_ui_pdf):
    os.remove(temp_ui_pdf)
