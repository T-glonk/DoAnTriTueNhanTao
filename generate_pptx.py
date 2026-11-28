# -*- coding: utf-8 -*-
"""
Hệ thống AI Gợi Ý Món Ăn Theo Nguyên Liệu (FoodAI)
Bộ Slide Thuyết Trình 20 Trang Chuẩn Khoa Học & Trực Quan
- Font chữ: Times New Roman toàn diện (100% slide và speaker notes)
- Lời thoại thuyết trình: 1-2 câu súc tích, tự nhiên, thay vì đọc slide
- Không sử dụng sơ đồ tuần tự
Đồ án Trí Tuệ Nhân Tạo (AIP202) - ĐH Kiến trúc Đà Nẵng
"""
import sys
import os
from PIL import Image
from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.dml.color import RGBColor
from pptx.enum.text import PP_ALIGN, MSO_ANCHOR
from pptx.enum.shapes import MSO_SHAPE

FONT_FAMILY = "Times New Roman"

def set_font(paragraph, size=None, bold=None, italic=None, color=None, alignment=None, space_before=None):
    """Cài đặt thông số font chữ Times New Roman đồng bộ cho paragraph."""
    paragraph.font.name = FONT_FAMILY
    if size is not None:
        paragraph.font.size = size
    if bold is not None:
        paragraph.font.bold = bold
    if italic is not None:
        paragraph.font.italic = italic
    if color is not None:
        paragraph.font.color.rgb = color
    if alignment is not None:
        paragraph.alignment = alignment
    if space_before is not None:
        paragraph.space_before = space_before

def add_fitted_picture(slide, img_path, left, top, max_w, max_h, bg_card=True, caption=None):
    """Thêm hình ảnh vào slide với tỷ lệ chuẩn không méo, kèm khung card bo góc viền tinh tế."""
    if not os.path.exists(img_path):
        print(f"Warning: image path not found: {img_path}")
        return None

    with Image.open(img_path) as im:
        img_w, img_h = im.size
    aspect = img_w / img_h

    avail_h = max_h - (Inches(0.4) if caption else Inches(0))
    target_w = max_w
    target_h = target_w / aspect

    if target_h > avail_h:
        target_h = avail_h
        target_w = target_h * aspect

    pos_x = left + (max_w - target_w) / 2
    pos_y = top + (avail_h - target_h) / 2

    if bg_card:
        card = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, left, top, max_w, max_h)
        card.fill.solid()
        card.fill.fore_color.rgb = RGBColor(255, 255, 255)
        card.line.color.rgb = RGBColor(226, 232, 240)
        card.line.width = Pt(1)

    pic = slide.shapes.add_picture(img_path, pos_x, pos_y, target_w, target_h)

    if caption:
        cap_box = slide.shapes.add_textbox(left, top + max_h - Inches(0.38), max_w, Inches(0.35))
        tf = cap_box.text_frame
        tf.word_wrap = True
        p = tf.paragraphs[0]
        p.text = caption
        set_font(p, size=Pt(11), italic=True, color=RGBColor(100, 116, 139), alignment=PP_ALIGN.CENTER)

    return pic

def apply_font_to_presentation(prs, font_name=FONT_FAMILY):
    """Duyệt đệ quy toàn bộ shape, textbox, table, cell, paragraph, run để ép font Times New Roman."""
    for slide in prs.slides:
        for shape in slide.shapes:
            if shape.has_text_frame:
                for p in shape.text_frame.paragraphs:
                    p.font.name = font_name
                    for r in p.runs:
                        r.font.name = font_name
            if shape.has_table:
                for row in shape.table.rows:
                    for cell in row.cells:
                        for p in cell.text_frame.paragraphs:
                            p.font.name = font_name
                            for r in p.runs:
                                r.font.name = font_name
        if slide.has_notes_slide:
            notes_tf = slide.notes_slide.notes_text_frame
            for p in notes_tf.paragraphs:
                p.font.name = font_name
                for r in p.runs:
                    r.font.name = font_name

def create_presentation():
    prs = Presentation()
    prs.slide_width = Inches(13.333)
    prs.slide_height = Inches(7.5)
    blank_layout = prs.slide_layouts[6]

    # Bảng màu giao diện FoodAI
    NAVY = RGBColor(15, 23, 42)          # #0F172A
    BRAND_ORANGE = RGBColor(234, 88, 12) # #EA580C
    BRAND_BLUE = RGBColor(30, 58, 138)   # #1E3A8A
    SLATE = RGBColor(71, 85, 105)         # #475569
    LIGHT_BG = RGBColor(248, 250, 252)   # #F8FAFC
    WHITE = RGBColor(255, 255, 255)
    CARD_BORDER = RGBColor(226, 232, 240) # #E2E8F0
    GREEN = RGBColor(22, 163, 74)        # #16A34A
    RED = RGBColor(220, 38, 38)          # #DC2626
    AMBER = RGBColor(217, 119, 6)        # #D97706
    PURPLE = RGBColor(126, 34, 206)      # #7E22CE

    # Tài nguyên ảnh
    IMG_LOGO = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/assets/dau-logo.png"
    FIG_UI_DASHBOARD = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/figs/ui_trang_chu_dashboard.jpg"
    FIG_UI_MODAL = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/figs/ui_modal_chi_tiet_mon.jpg"
    FIG_UI_ADMIN_OVERVIEW = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/figs/ui_admin_tong_quan.jpg"
    FIG_UI_ADMIN_USERS = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/figs/ui_admin_quan_ly_nguoi_dung.jpg"
    FIG_UI_ADMIN_RECIPES = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/figs/ui_admin_kho_mon_an.jpg"
    FIG_UI_FAVORITES = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/figs/ui_mon_an_yeu_thich.jpg"
    FIG_UI_SEARCH_HISTORY = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/figs/ui_lich_su_tim_kiem.jpg"
    FIG_UI_ADMIN_SETTINGS = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/figs/ui_admin_cai_dat_he_thong.jpg"

    slides_data = [
        # ==========================================
        # SLIDE 1: TRANG TIÊU ĐỀ
        # ==========================================
        {
            "type": "title",
            "title": "HỆ THỐNG AI GỢI Ý MÓN ĂN THEO NGUYÊN LIỆU",
            "subtitle": "ĐỒ ÁN MÔN HỌC: TRÍ TUỆ NHÂN TẠO (AIP202)\nỨng dụng Mô hình Ngôn ngữ Lớn Google Gemini AI kết hợp Kiến trúc Grounded RAG và CSDL Ẩm thực Việt Nam",
            "students": "Sinh viên thực hiện: Phạm Tấn Hào (2351220282) — Trần Quốc Trung (2351220096)",
            "advisor": "Giảng viên hướng dẫn: TS. Đỗ Phúc Hảo",
            "dept": "Trường Đại học Kiến trúc Đà Nẵng — Khoa Công nghệ Thông tin — Lớp: 23CT2 (Năm học: 2025 – 2026)",
            "notes": "Kính thưa quý Thầy Cô trong Hội đồng, hôm nay nhóm chúng em xin được báo cáo đề tài 'Hệ thống AI gợi ý món ăn theo nguyên liệu - FoodAI' dưới sự hướng dẫn của TS. Đỗ Phúc Hảo. Đề tài tập trung giải quyết bài toán gợi ý món ăn thực tế từ nguyên liệu sẵn có bằng cách kết hợp Google Gemini AI và kiến trúc Grounded RAG."
        },

        # ==========================================
        # SLIDE 2: NỘI DUNG THUYẾT TRÌNH (AGENDA)
        # ==========================================
        {
            "type": "agenda",
            "badge": "TỔNG QUAN",
            "title": "Nội Dung Báo Cáo Đề Tài",
            "subtitle": "Bố cục báo cáo được cấu trúc thành 5 phần mạch lạc từ lý thuyết đến thực nghiệm",
            "items": [
                ("1. Đặt Vấn Đề & Mục Tiêu Nghiên Cứu", "Bối cảnh đời sống, bài toán lãng phí thực phẩm, hạn chế của LLM và mục tiêu đề tài."),
                ("2. Cơ Sở Lý Thuyết & Nền Tảng Công Nghệ", "Google Gemini AI, kỹ thuật Grounded RAG, xử lý NLP tiếng Việt và Full-stack Web."),
                ("3. Phân Tích Thiết Kế & Giải Thuật Cốt Lõi", "Kiến trúc 3 tầng, luồng RAG 4 bước, thuật toán lọc ràng buộc ngữ nghĩa và CSDL 3NF."),
                ("4. Cài Đặt Thực Nghiệm & Đánh Giá Định Lượng", "Giao diện Client/Admin, kết quả kiểm thử chức năng và đo đạc hiệu năng thực tế."),
                ("5. Kết Luận & Hướng Phát Triển Tương Lai", "Tổng kết đóng góp, bài học rút ra và kế hoạch mở rộng thị giác máy tính YOLOv8.")
            ],
            "notes": "Báo cáo của nhóm gồm 5 phần chính, đi từ bài toán thực tế, cơ sở công nghệ, giải thuật cốt lõi chống ảo giác cho AI, cho đến kết quả thực nghiệm hệ thống và hướng phát triển tương lai."
        },

        # ==========================================
        # SLIDE 3: BỐI CẢNH THỰC TẾ & VẤN ĐỀ
        # ==========================================
        {
            "type": "split_text_image",
            "badge": "ĐẶT VẤN ĐỀ",
            "title": "Bối Cảnh Thực Tế & Nỗi Băn Khoăn Nội Trợ",
            "subtitle": "Bài toán tối ưu hóa nguyên liệu tồn đọng trong tủ lạnh và giảm thiểu lãng phí thực phẩm",
            "cards": [
                ("Câu hỏi thường trực mỗi ngày", "Người nội trợ, sinh viên bối rối: 'Hôm nay ăn gì?', 'Tủ lạnh còn những gì nấu được món gì ngon?'."),
                ("Vấn nạn lãng phí thực phẩm", "Lượng lớn rau củ, thịt cá tươi sống bị bỏ phí hằng tuần do thiếu kỹ năng kết hợp nguyên liệu sẵn có."),
                ("Hạn chế tra cứu truyền thống", "Buộc người dùng phải biết trước tên món ăn mới tìm được; tra cứu từ khóa máy móc và thiếu định lượng dinh dưỡng.")
            ],
            "img_path": FIG_UI_DASHBOARD,
            "img_caption": "Giao diện gợi ý thông minh của FoodAI - Giải pháp nấu ăn theo nguyên liệu có sẵn",
            "notes": "Xuất phát từ thực tế người nội trợ mỗi ngày đều bối rối với câu hỏi 'Hôm nay ăn gì' khi tủ lạnh còn nguyên liệu rải rác, dẫn đến lãng phí thực phẩm rất lớn. Các ứng dụng hiện nay đều bắt buộc phải biết trước tên món mới tìm được, hoàn toàn chưa hỗ trợ nấu ăn linh hoạt theo những gì đang có sẵn."
        },

        # ==========================================
        # SLIDE 4: THÁCH THỨC LLM & SO SÁNH GIẢI PHÁP
        # ==========================================
        {
            "type": "comparison_columns",
            "badge": "GIẢI PHÁP ĐỀ XUẤT",
            "title": "Thách Thức Ảo Giác Của LLM & Đột Phá Grounded RAG",
            "subtitle": "So sánh trực quan giữa Mô hình AI thuần túy và Hệ thống FoodAI kết hợp Grounded RAG",
            "col1_title": "Mô Hình AI Thuần Túy (Không RAG)",
            "col1_badge": "⚠️ NGUY CƠ ẢO GIÁC (HALLUCINATION)",
            "col1_color": RED,
            "col1_bg": RGBColor(254, 242, 242),
            "col1_items": [
                ("Tự ý bịa đặt nguyên liệu đắt tiền", "Khi người dùng chỉ nhập [Trứng, Cà chua], AI tự động thêm thịt bò Úc, tôm hùm, nấm đắt đỏ để món ăn thêm phần hấp dẫn."),
                ("Xa rời hoàn cảnh thực tế", "Gợi ý những món ăn bất khả thi với nguyên liệu sẵn có trong gian bếp gia đình."),
                ("Mất niềm tin người dùng", "Người nội trợ cảm thấy thất vọng và nhanh chóng rời bỏ ứng dụng vì kết quả phi thực tế.")
            ],
            "col2_title": "Hệ Thống FoodAI (Grounded RAG)",
            "col2_badge": "🛡️ KIỂM SOÁT DỮ LIỆU CHÍNH XÁC 100%",
            "col2_color": GREEN,
            "col2_bg": RGBColor(240, 253, 244),
            "col2_items": [
                ("Khóa chặt vào kho 552 món thật", "CSDL Cookpad Việt Nam làm mỏ neo ngữ cảnh vững chắc. AI tuyệt đối bị cấm sáng tạo thêm tên món mới ngoài kho tri thức."),
                ("Phân vai AI Chef & Chuyên gia dinh dưỡng", "Gemini AI chỉ tập trung tính toán định lượng gram, thời gian nấu và 8 chỉ số dinh dưỡng (calo, đạm, béo, xơ, vitamin...)."),
                ("Tỷ lệ bám sát nguyên liệu 97,8%", "Món ăn đề xuất thân thuộc, chuẩn vị Việt Nam và có thể chế biến ngay lập tức.")
            ],
            "notes": "Nếu chỉ dùng AI thuần túy, mô hình rất dễ bị 'ảo giác' tự bịa thêm các nguyên liệu đắt tiền như thịt bò hay tôm hùm dù người dùng chỉ có trứng và cà chua. Đột phá của đề tài là ứng dụng Grounded RAG, khóa chặt AI vào kho món ăn Việt Nam có thật làm mỏ neo, triệt tiêu hoàn toàn hiện tượng bịa đặt này."
        },

        # ==========================================
        # SLIDE 5: MỤC TIÊU & PHẠM VI
        # ==========================================
        {
            "type": "four_cards",
            "badge": "MỤC TIÊU & PHẠM VI",
            "title": "Mục Tiêu Nghiên Cứu & Phạm Vi Đề Tài",
            "subtitle": "Xây dựng hệ thống ứng dụng Web hoàn chỉnh phục vụ nhu cầu ẩm thực thực tế",
            "cards": [
                ("Kho Tri Thức Ẩm Thực Chuẩn Hóa", "Thu thập, làm sạch và chuẩn hóa hơn 550 món ăn thực tế Việt Nam cùng hơn 2.000 link ảnh sắc nét từ Cookpad CDN.", BRAND_ORANGE),
                ("Tích Hợp Google Gemini AI", "Ứng dụng mô hình Gemini Flash qua Prompt Engineering chuyên sâu, tính toán chính xác 8 chỉ số dinh dưỡng và khẩu phần.", BRAND_BLUE),
                ("Xử Lý Ngôn Ngữ Tự Nhiên (NLP)", "Xây dựng thuật toán NLP tiếng Việt khử triệt để hiện tượng dính chữ (cà chua != cá, mắm tôm != tôm, bơ tỏi != bò).", GREEN),
                ("Kiến Trúc Web & Fallback Chịu Lỗi", "Hoàn thiện Web SPA full-stack, phân quyền JWT và cơ chế dự phòng tự động phản hồi tức thì < 300ms khi mất kết nối AI.", PURPLE)
            ],
            "notes": "Mục tiêu cốt lõi của nhóm là xây dựng kho 552 món ăn Việt Nam chuẩn hóa, tích hợp Gemini AI phân tích chính xác 8 chỉ số dinh dưỡng, và hoàn thiện một ứng dụng Web có cơ chế dự phòng hoạt động bền bỉ."
        },

        # ==========================================
        # SLIDE 6: HỆ THỐNG CÔNG NGHỆ (TECH STACK)
        # ==========================================
        {
            "type": "three_columns",
            "badge": "CÔNG NGHỆ",
            "title": "Hệ Thống Công Nghệ Sử Dụng (Tech Stack)",
            "subtitle": "Nền tảng công nghệ full-stack JavaScript/TypeScript hiện đại, tốc độ cao và an toàn",
            "cols": [
                ("Frontend (Client)", BRAND_ORANGE, [
                    ("React 18 & TypeScript", "Kiểm soát kiểu dữ liệu an toàn, Single Page Application mượt mà."),
                    ("Vite & Tailwind CSS", "Tối ưu tốc độ tải trang, giao diện Responsive tương thích mọi thiết bị."),
                    ("Lucide Icons & Recharts", "Hệ thống biểu đồ trực quan hóa dữ liệu dinh dưỡng và quản trị.")
                ]),
                ("Backend (Server)", BRAND_BLUE, [
                    ("Node.js & Express", "Kiến trúc RESTful API bất đồng bộ hiệu năng cao, non-blocking I/O."),
                    ("JWT & Bcrypt", "Xác thực phiên bảo mật cao, mã hóa mật khẩu 10 salt rounds an toàn."),
                    ("Rate Limiter & CORS", "Phòng chống tấn công brute-force, DoS và bảo vệ tài nguyên API.")
                ]),
                ("AI Engine & Database", GREEN, [
                    ("Google Gemini AI", "Mô hình gemini-1.5-flash / gemini-2.0 phân tích vi chất và thời gian."),
                    ("MySQL 8.0 (Chuẩn 3NF)", "Lưu trữ 9 bảng quan hệ chặt chẽ, tối ưu truy vấn có Index."),
                    ("Cookpad CDN Image", "Kho ảnh món ăn thực tế sắc nét, độ phân giải cao 1200x630.")
                ])
            ],
            "notes": "Hệ thống được xây dựng trên nền tảng Full-stack JavaScript hiện đại: React 18 và TypeScript ở Frontend cho trải nghiệm mượt mà, Node.js Express bảo mật ở Backend, cùng động cơ Google Gemini AI và CSDL quan hệ MySQL 8.0."
        },

        # ==========================================
        # SLIDE 7: KIẾN TRÚC HỆ THỐNG 3 TẦNG (THREE-TIER)
        # ==========================================
        {
            "type": "three_tiers",
            "badge": "KIẾN TRÚC HỆ THỐNG",
            "title": "Kiến Trúc Hệ Thống 3 Tầng (Three-Tier Architecture)",
            "subtitle": "Phân tách trách nhiệm độc lập giữa Giao diện, Xử lý nghiệp vụ ứng dụng và Tầng dữ liệu & AI",
            "tiers": [
                {
                    "name": "TẦNG 1: GIAO DIỆN NGƯỜI DÙNG (PRESENTATION LAYER - CLIENT SPA)",
                    "color": BRAND_ORANGE,
                    "bg": RGBColor(255, 247, 237),
                    "tech": "React 18 • TypeScript • Tailwind CSS • Vite • Lucide Icons • Recharts",
                    "components": [
                        "User Dashboard: Nhập nguyên liệu tag màu động, phân trang 3 món, Modal chi tiết 3 tab, lưu sổ tay yêu thích.",
                        "Admin Dashboard: Bảng điều khiển KPI, quản lý người dùng, kho 552 món ăn, giám sát nhật ký AI Query Logs."
                    ]
                },
                {
                    "name": "TẦNG 2: XỬ LÝ NGHIỆP VỤ ỨNG DỤNG (APPLICATION & BUSINESS LAYER - SERVER)",
                    "color": BRAND_BLUE,
                    "bg": RGBColor(239, 246, 255),
                    "tech": "Node.js • Express.js • TypeScript • JWT Auth • Bcrypt • Express Rate Limit",
                    "components": [
                        "Dịch vụ độc lập: GeminiService (Prompt Engineering), RecipeService (Lọc Heuristic), ImageService (Kiểm soát ảnh).",
                        "Middleware an ninh: Kiểm tra Bearer Token JWT, phân quyền Admin/User, kiểm soát định ngạch và chặn lỗi XSS."
                    ]
                },
                {
                    "name": "TẦNG 3: DỮ LIỆU & TRÍ TUỆ NHÂN TẠO (DATA & AI LAYER)",
                    "color": GREEN,
                    "bg": RGBColor(240, 253, 244),
                    "tech": "MySQL 8.0 (Chuẩn 3NF) • Google Gemini Cloud AI • Cookpad CDN Storage",
                    "components": [
                        "Cơ sở dữ liệu MySQL: 9 bảng quan hệ chặt chẽ, cơ chế Auto-Migration và Auto-Seed 552 món ăn mẫu.",
                        "Google Gemini AI & Cookpad CDN: Động cơ AI phân tích dinh dưỡng vi chất và kho hơn 2.000 link ảnh chất lượng cao."
                    ]
                }
            ],
            "notes": "Kiến trúc phần mềm được phân tách chặt chẽ thành 3 tầng: Giao diện Client SPA, Tầng nghiệp vụ xử lý phân quyền và lọc ràng buộc, kết nối với Tầng dữ liệu MySQL và dịch vụ đám mây Gemini AI qua RESTful API an toàn."
        },

        # ==========================================
        # SLIDE 8: LUỒNG GỢI Ý GROUNDED RAG
        # ==========================================
        {
            "type": "split_text_image",
            "badge": "QUY TRÌNH CỐT LÕI",
            "title": "Quy Trình Gợi Ý Grounded RAG 4 Bước",
            "subtitle": "Trọng tâm thuật toán kiểm soát tuyệt đối dữ liệu đầu vào và đầu ra của trí tuệ nhân tạo",
            "cards": [
                ("Bước 1: Lọc Ứng Viên CSDL", "Truy vấn MySQL lấy trước 6-8 món ăn thực tế khớp từ khóa và có sẵn ảnh Cookpad làm mỏ neo."),
                ("Bước 2: Nạp Ngữ Cảnh Vào Prompt", "Đưa danh sách món thật vào System Prompt của Gemini, áp lệnh cấm tuyệt đối: Không bịa món mới ngoài CSDL."),
                ("Bước 3: AI Enrichment (Làm Giàu Dữ Liệu)", "Gemini AI tính toán 8 chỉ số dinh dưỡng, thời gian nấu, định lượng khẩu phần và viết mẹo ẩm thực ai_reasoning."),
                ("Bước 4: Đồng Bộ Ngược CSDL", "Tự động cập nhật công thức và kết quả phân tích AI vào MySQL để tái sử dụng lâu dài.")
            ],
            "img_path": FIG_UI_MODAL,
            "img_caption": "Kết quả thực tế sau khi xử lý Grounded RAG: Đầy đủ định lượng nguyên liệu và 8 chỉ số dinh dưỡng",
            "notes": "Đây là trái tim của hệ thống: CSDL MySQL sẽ lọc trước 6 đến 8 món thật khớp nguyên liệu, sau đó Gemini AI mới đóng vai trò đầu bếp tính toán định lượng gram, calo và mẹo chế biến rồi đồng bộ ngược lại vào CSDL."
        },

        # ==========================================
        # SLIDE 9: XỬ LÝ NLP TIẾNG VIỆT
        # ==========================================
        {
            "type": "split_text_image",
            "badge": "XỬ LÝ NGÔN NGỮ TỰ NHIÊN",
            "title": "Xử Lý Tiếng Việt & Ngăn Chặn Nhầm Lẫn Ngữ Nghĩa",
            "subtitle": "Giải quyết bài toán từ ghép, đồng nghĩa vùng miền và hiện tượng dính chữ nguy hiểm",
            "cards": [
                ("Thách thức dính chữ nguy hiểm", "Chuỗi con gây nhầm lẫn: 'cà chua' dính chữ 'cá', 'mắm tôm' dính chữ 'tôm', 'bơ tỏi' dính chữ 'bò', 'nấm đùi gà' dính chữ 'gà'."),
                ("Chuẩn hóa Unicode NFD & NFC", "Loại bỏ hoàn toàn lỗi gõ dấu thanh khác nhau giữa các bộ gõ Unikey (NFC vs NFD) trước khi so khớp."),
                ("Ranh giới từ nguyên vẹn (Whole-word Boundary)", "Áp dụng biểu thức Regex `(^|[^a-z0-9])target([^a-z0-9]|$)` cùng danh sách loại trừ (Negative Excludes) để tách biệt hoàn toàn từ khóa.")
            ],
            "img_path": FIG_UI_DASHBOARD,
            "img_caption": "Gợi ý nguyên liệu tự động nhận diện từ khóa chính xác không bị dính chữ",
            "notes": "Để giải quyết triệt để các lỗi dính chữ nguy hiểm trong tiếng Việt như 'cà chua' bị nhận nhầm thành 'cá', nhóm đã xây dựng thuật toán kiểm tra ranh giới từ nguyên vẹn kết hợp ma trận loại trừ Negative Excludes để đảm bảo độ chính xác tuyệt đối."
        },

        # ==========================================
        # SLIDE 10: THUẬT TOÁN LỌC RÀNG BUỘC & CHẤM ĐIỂM
        # ==========================================
        {
            "type": "split_text_image",
            "badge": "THUẬT TOÁN GỢI Ý",
            "title": "Thuật Toán Lọc Ràng Buộc & Chấm Điểm Đa Tiêu Chí",
            "subtitle": "Đảm bảo món ăn được đề xuất bám sát tối đa nguyên liệu người dùng đang có",
            "cards": [
                ("Bộ Lọc Loại Trừ Cứng (Hard Constraints)", "• Bảo vệ Protein: Không nhập thịt/cá -> Loại 100% món chứa đạm động vật.\n• Bảo vệ đơn lẻ: Chỉ có Thịt bò -> Loại trừ món có thịt heo xay, tôm cua."),
                ("Công Thức Chấm Điểm Ưu Tiên", "Score = (Số nguyên liệu khớp x 100) + (Tên món chứa nguyên liệu x 50) + (Khớp đúng loại đạm x 150)."),
                ("Tỷ Lệ Khớp Nguyên Liệu", "M(U, R) = min(100, (|U ∩ R| / min(|U|, 3)) x 100). Món khớp nhiều nguyên liệu nhất và chứa tên nguyên liệu luôn xếp Top 1.")
            ],
            "img_path": FIG_UI_MODAL,
            "img_caption": "Món ăn đề xuất có độ tương đồng nguyên liệu cao nhất được xếp vị trí ưu tiên",
            "notes": "Hệ thống áp dụng bộ lọc loại trừ cứng để bảo vệ nhóm chất đạm - ví dụ nếu người dùng không nhập thịt cá thì loại bỏ 100% món mặn, đồng thời chấm điểm đa tiêu chí để luôn đẩy món ăn phù hợp nhất lên vị trí Top 1."
        },

        # ==========================================
        # SLIDE 11: THIẾT KẾ CƠ SỞ DỮ LIỆU
        # ==========================================
        {
            "type": "split_text_image",
            "badge": "CƠ SỞ DỮ LIỆU",
            "title": "Thiết Kế CSDL Chuẩn 3NF & Cơ Chế Auto-Seed",
            "subtitle": "Quản lý 9 bảng dữ liệu quan hệ chặt chẽ và tự động nạp dữ liệu không cần thao tác tay",
            "cards": [
                ("9 Bảng Quan Hệ Chuẩn 3NF", "Bao gồm `users`, `recipes` (552 món có Index), `recipe_ingredients`, `recipe_steps`, `recipe_nutrition` (8 chỉ số), `favorite_recipes`, `search_history`, `cookpad_dish_images`."),
                ("Cơ Chế Tự Động Khởi Tạo (Auto-Migration)", "Backend tự động kiểm tra và tạo toàn bộ cấu trúc bảng khi khởi động, không cần gõ lệnh SQL thủ công."),
                ("Auto-Seed 552 Món Cookpad", "Tự động nạp toàn bộ dữ liệu ẩm thực mẫu vào MySQL nếu CSDL đang trống, sẵn sàng chạy ngay lập tức trên máy mới.")
            ],
            "img_path": FIG_UI_ADMIN_RECIPES,
            "img_caption": "Giao diện quản lý kho 552 món ăn lưu trữ trong CSDL MySQL",
            "notes": "CSDL được thiết kế chuẩn hóa 3NF gồm 9 bảng quan hệ chặt chẽ. Đặc biệt, hệ thống tích hợp cơ chế Auto-Seed tự động nạp toàn bộ 552 món ăn mẫu vào MySQL ngay khi khởi động mà không cần can thiệp thủ công."
        },

        # ==========================================
        # SLIDE 12: KIỂM SOÁT HÌNH ẢNH THỰC TẾ
        # ==========================================
        {
            "type": "split_text_image",
            "badge": "KIỂM SOÁT HÌNH ẢNH",
            "title": "Kiểm Soát Hình Ảnh Thực Tế & Chống Sai Lệch",
            "subtitle": "Đảm bảo hình ảnh thành phẩm 100% khớp đúng món ăn và đạt chuẩn thẩm mỹ cao",
            "cards": [
                ("Lớp 1: Thuật Toán isImageUrlConflicting", "Giải mã slug URL từ CDN Cookpad. Nếu tên món là 'Thịt bò' nhưng URL chứa slug 'ga' hay 'heo' -> Hệ thống tự động loại bỏ ngay lập tức."),
                ("Lọc Bỏ Ảnh Không Phù Hợp", "Tự động phạt điểm (-100) và loại trừ ảnh cơm hộp bento trẻ em, ảnh thức ăn dặm hoặc ảnh mâm cơm hỗn hợp nhiều món."),
                ("Lớp 2: Can Thiệp Thủ Công Từ Admin", "Trang Admin Kho Món Ăn tích hợp nút Chỉnh sửa cho phép quản trị viên dán link ảnh mới ưng ý nhất từ Google hoặc ảnh thực tế.")
            ],
            "img_path": FIG_UI_ADMIN_SETTINGS,
            "img_caption": "Bảng điều khiển cho phép kiểm tra trạng thái API và cấu hình hình ảnh trực tiếp",
            "notes": "Để thành phẩm luôn đạt chuẩn thẩm mỹ cao, thuật toán sẽ tự động phân tích slug URL ảnh nhằm loại trừ các ảnh mâm cơm hỗn hợp hoặc ảnh lệch món, đồng thời cung cấp giao diện Admin cho phép cập nhật link ảnh thủ công mọi lúc."
        },

        # ==========================================
        # SLIDE 13: GIAO DIỆN CLIENT APP
        # ==========================================
        {
            "type": "two_images",
            "badge": "GIAO DIỆN NGƯỜI DÙNG",
            "title": "Trải Nghiệm Giao Diện Người Dùng (Client Web Application)",
            "subtitle": "Thiết kế hiện đại, responsive đa thiết bị, tối ưu trải nghiệm tương tác với phong cách màu ấm áp",
            "img1_path": FIG_UI_DASHBOARD,
            "img1_title": "Trang Chủ: Tìm Kiếm & Gợi Ý Món Ăn",
            "img1_desc": "Nhập nguyên liệu dạng tag màu động, hỗ trợ 1-click chọn nhanh combo phổ biến; phân trang 3 món/trang chuyển cuộn mượt mà.",
            "img2_path": FIG_UI_MODAL,
            "img2_title": "Modal Chi Tiết Món Ăn 3 Tab",
            "img2_desc": "Tab 1: Công thức 4 bước nấu chuẩn; Tab 2: Định lượng nguyên liệu chi tiết (gram, thìa); Tab 3: Bảng 8 chỉ số dinh dưỡng & mẹo AI Chef.",
            "notes": "Giao diện người dùng được thiết kế hiện đại và tiện lợi: hỗ trợ chọn nguyên liệu nhanh bằng tag màu động, phân trang 3 món cuộn mượt mà, cùng Modal chi tiết 3 tab hiển thị đầy đủ công thức và biểu đồ dinh dưỡng."
        },

        # ==========================================
        # SLIDE 14: PHÂN HỆ ADMIN PANEL
        # ==========================================
        {
            "type": "two_images",
            "badge": "GIAO DIỆN QUẢN TRỊ",
            "title": "Phân Hệ Quản Trị Hệ Thống (Admin Dashboard)",
            "subtitle": "Bảng điều khiển toàn diện phục vụ giám sát vận hành, kiểm soát dữ liệu và người dùng",
            "img1_path": FIG_UI_ADMIN_OVERVIEW,
            "img1_title": "Tổng Quan & Thống Kê KPI Thời Gian Thực",
            "img1_desc": "Biểu đồ cột Top 10 nguyên liệu được tìm kiếm nhiều nhất, số lượng người dùng đang hoạt động và tổng số món trong kho dữ liệu.",
            "img2_path": FIG_UI_ADMIN_USERS,
            "img2_title": "Quản Lý Người Dùng & Phân Quyền An Toàn",
            "img2_desc": "Bảng dữ liệu phân trang, tìm kiếm email/tên, kích hoạt/khóa tài khoản kèm chốt an toàn không cho phép Admin tự khóa chính mình.",
            "notes": "Phân hệ quản trị cung cấp bức tranh vận hành toàn diện với biểu đồ thống kê KPI thời gian thực, quản lý tài khoản người dùng an toàn và công cụ giám sát trực tiếp nhật ký truy vấn của Gemini AI."
        },

        # ==========================================
        # SLIDE 15: CƠ CHẾ DỰ PHÒNG FALLBACK
        # ==========================================
        {
            "type": "split_text_image",
            "badge": "TÍNH SẴN SÀNG CAO",
            "title": "Cơ Chế Dự Phòng Chịu Lỗi Bền Vững (Fallback Layer)",
            "subtitle": "Đảm bảo hệ thống hoạt động liên tục ngay cả khi mất kết nối Internet hoặc lỗi API",
            "cards": [
                ("Nguy Cơ Trong Môi Trường Thực Tế", "Mất kết nối mạng tới máy chủ Google AI, cạn hạn mức định ngạch (Quota Exceeded) hoặc độ trễ mạng quốc tế quá lớn."),
                ("Chuyển Mạch Tự Động Trong Try-Catch", "Backend bắt lỗi ngoại lệ tức thì mà không làm sập tiến trình, tự động chuyển hướng sang hàm `suggestRecipesFromDatabase()`."),
                ("Tốc Độ Phản Hồi Vượt Trội (< 300ms)", "Chỉ mất 0,21 giây để tra cứu và trả kết quả từ CSDL MySQL nội bộ; cam kết người dùng không bao giờ gặp màn hình trắng hay thông báo lỗi sập ứng dụng.")
            ],
            "img_path": FIG_UI_FAVORITES,
            "img_caption": "Người dùng vẫn xem được gợi ý, công thức và lưu món ăn yêu thích bình thường ở chế độ dự phòng",
            "notes": "Hệ thống sở hữu cơ chế chịu lỗi công nghiệp: khi mất mạng hoặc Google AI bị nghẽn hạn mức, tầng Fallback sẽ tự động phản hồi từ CSDL MySQL nội bộ chỉ trong 0,21 giây, cam kết người dùng không bao giờ gặp lỗi gián đoạn."
        },

        # ==========================================
        # SLIDE 16: KẾT QUẢ KIỂM THỬ (TESTING)
        # ==========================================
        {
            "type": "table",
            "badge": "KIỂM THỬ HỆ THỐNG",
            "title": "Kết Quả Kiểm Thử Chức Năng & Xử Lý Ngoại Lệ",
            "subtitle": "Kiểm thử toàn diện 6 ca thử nghiệm cốt lõi đạt tỷ lệ thành công tuyệt đối 100%",
            "headers": ["Mã Ca", "Kịch Bản Kiểm Thử Đầu Vào", "Kết Quả Kỳ Vọng", "Trạng Thái"],
            "rows": [
                ["TC-01", "Email, mật khẩu hợp lệ", "Đăng nhập thành công, cấp mã JWT an toàn", "ĐẠT (Pass 100%)"],
                ["TC-02", "Nguyên liệu: [Thịt bò, Cà chua, Hành tây]", "Gợi ý 6-8 món bò chuẩn vị, tính toán đủ 8 chỉ số dinh dưỡng", "ĐẠT (Pass 100%)"],
                ["TC-03", "Nguyên liệu chay: [Trứng, Đậu phụ, Nấm]", "100% món không có thịt cá lạ, triệt tiêu hoàn toàn ảo giác", "ĐẠT (Pass 100%)"],
                ["TC-04", "Ngắt kết nối Internet / Khóa API Key", "Tự động Fallback sang CSDL MySQL nội bộ, phản hồi < 300ms", "ĐẠT (Pass 100%)"],
                ["TC-05", "Tài khoản User thường truy cập /admin", "Bị chặn bởi AuthMiddleware và nhận mã lỗi HTTP 403 Forbidden", "ĐẠT (Pass 100%)"],
                ["TC-06", "Nhập chuỗi rỗng / Ký tự đặc biệt XSS", "Bắt lỗi validation, thông báo lỗi tiếng Việt thân thiện", "ĐẠT (Pass 100%)"]
            ],
            "notes": "Nhóm đã thực hiện kiểm thử nghiêm ngặt trên 6 ca thử nghiệm cốt lõi từ bảo mật JWT, kịch bản ăn chay, xử lý chuỗi rỗng đến ngắt mạng đột ngột - toàn bộ đều đạt tỷ lệ Pass tuyệt đối 100%."
        },

        # ==========================================
        # SLIDE 17: ĐÁNH GIÁ ĐỊNH LƯỢNG HIỆU NĂNG
        # ==========================================
        {
            "type": "kpi_metrics_table",
            "badge": "ĐÁNH GIÁ ĐỊNH LƯỢNG",
            "title": "Đánh Giá Hiệu Năng Thực Nghiệm Giữa Hai Chế Độ",
            "subtitle": "Khảo sát và đo đạc trên 150 kịch bản tìm kiếm ngẫu nhiên đa dạng nguyên liệu",
            "kpis": [
                ("0,21 giây", "Tốc Độ Fallback CSDL", "Nhanh gấp 16 lần chế độ AI", BRAND_ORANGE),
                ("97,8%", "Độ Bám Sát Nguyên Liệu", "Khử hoàn toàn ảo giác nguyên liệu lạ", BRAND_BLUE),
                ("4,8 / 5,0 ⭐", "Độ Hài Lòng Người Dùng", "Khảo sát thực tế 150 kịch bản nấu ăn", GREEN)
            ],
            "headers": ["Tiêu Chí Đánh Giá Thực Nghiệm", "Chế Độ AI (Gemini)", "Chế Độ Fallback (MySQL)", "Ý Nghĩa"],
            "rows": [
                ["Thời gian phản hồi trung bình", "3,42 giây", "0,21 giây", "Fallback nhanh vượt trội (< 300ms)"],
                ["Tỷ lệ phân tích cú pháp JSON hợp lệ", "100%", "100%", "Cú pháp dữ liệu ổn định, không lỗi"],
                ["Tỷ lệ đa dạng phương pháp chế biến", "98,6%", "84,2%", "AI sáng tạo món phong phú hơn"],
                ["Tỷ lệ bám sát nguyên liệu có sẵn", "97,8%", "94,5%", "Bám sát chặt chẽ yêu cầu người dùng"],
                ["Tỷ lệ gán hình ảnh chính xác", "94,6%", "98,2%", "Kho ảnh Cookpad khớp chuẩn thành phẩm"],
                ["Mức độ hài lòng của người dùng", "4,8 / 5,0 ⭐", "4,2 / 5,0 ⭐", "Cả 2 chế độ đều được đánh giá cao"]
            ],
            "notes": "Đo đạc trên 150 kịch bản thực tế cho thấy chế độ Fallback phản hồi cực nhanh 0,21 giây, trong khi chế độ AI đạt tỷ lệ bám sát nguyên liệu 97,8% và nhận được điểm hài lòng rất cao 4,8 trên 5 sao từ người dùng."
        },

        # ==========================================
        # SLIDE 18: KỊCH BẢN THỰC TẾ
        # ==========================================
        {
            "type": "split_text_image",
            "badge": "KỊCH BẢN THỰC TẾ",
            "title": "Minh Họa Kịch Bản Kiểm Thử Thực Tế Điển Hình",
            "subtitle": "Chứng minh tính chính xác, thực tế và loại trừ hoàn toàn nguyên liệu xung đột",
            "cards": [
                ("Kịch Bản 1: [Trứng, Cà chua, Hành lá]", "• Đề xuất chính xác: Trứng sốt cà chua, Canh cà chua trứng, Trứng chiên hành lá, Cơm chiên trứng.\n• Cam kết: 100% không xuất hiện thịt bò, heo, gà hay cá lạ.\n• Dinh dưỡng: Năng lượng chuẩn (~220 kcal), ảnh Cookpad sắc nét."),
                ("Kịch Bản 2: [Thịt bò]", "• Đề xuất phong phú: Thịt bò xào hành tây, Bò lúc lắc, Canh dưa chua bắp bò, Măng tây xào thịt bò...\n• Đủ số lượng: Gợi ý đủ 8 món ngon nhất trong kho 67 món bò.\n• Trải nghiệm: Phân trang 3 trang mượt mà (3 món - 3 món - 2 món).")
            ],
            "img_path": FIG_UI_SEARCH_HISTORY,
            "img_caption": "Lịch sử tìm kiếm lưu trữ chính xác các lần tra cứu thực tế của người dùng",
            "notes": "Minh chứng rõ nhất là dù người dùng chỉ có nguyên liệu đơn giản như trứng và cà chua hay có thịt bò, hệ thống đều đưa ra đúng các món ăn thân thuộc, chuẩn vị và tự động lưu lại vào lịch sử tìm kiếm."
        },

        # ==========================================
        # SLIDE 19: KẾT LUẬN & HƯỚNG PHÁT TRIỂN
        # ==========================================
        {
            "type": "two_columns",
            "badge": "TỔNG KẾT",
            "title": "Kết Luận & Hướng Phát Triển Tương Lai",
            "subtitle": "Đóng góp chính của đề tài và lộ trình nâng cấp sản phẩm ứng dụng trong giai đoạn tiếp theo",
            "col1_title": "Những Đóng Góp Chính Của Đề Tài",
            "col1_color": BRAND_ORANGE,
            "col1_bullets": [
                "Đề xuất thành công kiến trúc Grounded RAG giải quyết triệt để bài toán ảo giác nguyên liệu của LLM.",
                "Hiện thực hóa ứng dụng Web hoàn chỉnh 2 phân hệ (Client & Admin) sẵn sàng đưa vào sử dụng thực tế.",
                "Xây dựng kho dữ liệu 552 món ăn và hơn 2.000 hình ảnh Cookpad Việt Nam chất lượng cao.",
                "Đã triển khai thực tế trên Cloud (Vercel & Render) với tên miền hoạt động ổn định."
            ],
            "col2_title": "Hướng Phát Triển Tương Lai",
            "col2_color": BRAND_BLUE,
            "col2_bullets": [
                "Thị giác máy tính (Computer Vision): Tích hợp mô hình YOLOv8 chụp ảnh khay tủ lạnh tự nhận diện nguyên liệu.",
                "Lập thực đơn tuần thông minh (Weekly Meal Planner): Tự động phân bổ calo 7 ngày theo thể trạng (Keto, giảm cân, tiểu đường).",
                "Phát triển ứng dụng di động đa nền tảng (React Native) và mạng xã hội chia sẻ công thức ẩm thực cá nhân."
            ],
            "notes": "Đề tài đã hoàn thành trọn vẹn mục tiêu đề ra và triển khai thực tế trên môi trường đám mây; trong giai đoạn tiếp theo, nhóm sẽ tích hợp mô hình thị giác YOLOv8 để tự nhận diện thực phẩm qua camera tủ lạnh."
        },

        # ==========================================
        # SLIDE 20: CẢM ƠN & HỎI ĐÁP (Q&A)
        # ==========================================
        {
            "type": "closing",
            "title": "CHÂN THÀNH CẢM ƠN QUÝ THẦY CÔ VÀ CÁC BẠN!",
            "subtitle": "HỆ THỐNG AI GỢI Ý MÓN ĂN THEO NGUYÊN LIỆU (FoodAI)",
            "advisor": "Trân trọng cảm ơn TS. Đỗ Phúc Hảo đã tận tình hướng dẫn khoa học trong suốt quá trình thực hiện đồ án.",
            "links": "🌐 Live Web App: https://do-an-tri-tue-nhan-tao-nu.vercel.app\n💻 GitHub: https://github.com/T-glonk/DoAnTriTueNhanTao.git",
            "qa": "KÍNH MỜI QUÝ THẦY CÔ TRONG HỘI ĐỒNG ĐẶT CÂU HỎI (Q&A)",
            "notes": "Nhóm chúng em xin chân thành cảm ơn TS. Đỗ Phúc Hảo và quý Thầy Cô trong Hội đồng đã lắng nghe; chúng em rất mong nhận được những góp ý quý báu và xin sẵn sàng trả lời các câu hỏi của Thầy Cô ạ!"
        }
    ]

    for idx, data in enumerate(slides_data):
        slide = prs.slides.add_slide(blank_layout)

        # 1. Nền slide
        bg = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, 0, 0, prs.slide_width, prs.slide_height)
        bg.fill.solid()
        bg.fill.fore_color.rgb = LIGHT_BG
        bg.line.fill.background()

        # 2. Speaker notes (Lời thoại 1-2 câu để thuyết trình)
        if "notes" in data:
            notes_slide = slide.notes_slide
            tf_notes = notes_slide.notes_text_frame
            tf_notes.text = data["notes"]
            for p in tf_notes.paragraphs:
                set_font(p, size=Pt(13), color=NAVY)

        # ==========================================
        # RENDER CÁC LOẠI SLIDE
        # ==========================================
        if data["type"] == "title":
            top_bar = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(0), Inches(0), Inches(13.333), Inches(0.2))
            top_bar.fill.solid()
            top_bar.fill.fore_color.rgb = BRAND_ORANGE
            top_bar.line.fill.background()

            card = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(1.2), Inches(0.7), Inches(10.933), Inches(6.1))
            card.fill.solid()
            card.fill.fore_color.rgb = WHITE
            card.line.color.rgb = CARD_BORDER
            card.line.width = Pt(1.5)

            if os.path.exists(IMG_LOGO):
                slide.shapes.add_picture(IMG_LOGO, Inches(1.6), Inches(1.0), Inches(1.0), Inches(1.0))

            txSchool = slide.shapes.add_textbox(Inches(2.8), Inches(1.0), Inches(8.8), Inches(0.9))
            tf = txSchool.text_frame
            tf.word_wrap = True
            p0 = tf.paragraphs[0]
            p0.text = "TRƯỜNG ĐẠI HỌC KIẾN TRÚC ĐÀ NẴNG — KHOA CÔNG NGHỆ THÔNG TIN"
            set_font(p0, size=Pt(13.5), bold=True, color=BRAND_BLUE)

            p_badge = tf.add_paragraph()
            p_badge.text = "BÁO CÁO ĐỒ ÁN MÔN HỌC: TRÍ TUỆ NHÂN TẠO (AIP202)"
            set_font(p_badge, size=Pt(12), bold=True, color=BRAND_ORANGE)

            line = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(1.6), Inches(2.1), Inches(10.1), Inches(0.04))
            line.fill.solid()
            line.fill.fore_color.rgb = CARD_BORDER
            line.line.fill.background()

            txTitle = slide.shapes.add_textbox(Inches(1.6), Inches(2.3), Inches(10.1), Inches(1.5))
            tf = txTitle.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = data["title"]
            set_font(p, size=Pt(28), bold=True, color=BRAND_ORANGE, alignment=PP_ALIGN.CENTER)

            p_sub = tf.add_paragraph()
            p_sub.text = data["subtitle"]
            set_font(p_sub, size=Pt(14), color=SLATE, alignment=PP_ALIGN.CENTER, space_before=Pt(8))

            info_card = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(1.8), Inches(4.3), Inches(9.7), Inches(2.1))
            info_card.fill.solid()
            info_card.fill.fore_color.rgb = RGBColor(248, 250, 252)
            info_card.line.color.rgb = CARD_BORDER
            info_card.line.width = Pt(1)

            txInfo = slide.shapes.add_textbox(Inches(2.0), Inches(4.4), Inches(9.3), Inches(1.9))
            tf = txInfo.text_frame
            tf.word_wrap = True

            p1 = tf.paragraphs[0]
            p1.text = data["students"]
            set_font(p1, size=Pt(14.5), bold=True, color=NAVY, alignment=PP_ALIGN.CENTER)

            p2 = tf.add_paragraph()
            p2.text = data["advisor"]
            set_font(p2, size=Pt(14), bold=True, color=BRAND_BLUE, alignment=PP_ALIGN.CENTER, space_before=Pt(6))

            p3 = tf.add_paragraph()
            p3.text = data["dept"]
            set_font(p3, size=Pt(12), color=SLATE, alignment=PP_ALIGN.CENTER, space_before=Pt(6))

        elif data["type"] == "closing":
            top_bar = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(0), Inches(0), Inches(13.333), Inches(0.2))
            top_bar.fill.solid()
            top_bar.fill.fore_color.rgb = BRAND_ORANGE
            top_bar.line.fill.background()

            card = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(1.2), Inches(0.7), Inches(10.933), Inches(6.1))
            card.fill.solid()
            card.fill.fore_color.rgb = WHITE
            card.line.color.rgb = CARD_BORDER
            card.line.width = Pt(1.5)

            if os.path.exists(IMG_LOGO):
                slide.shapes.add_picture(IMG_LOGO, Inches(6.166), Inches(1.1), Inches(1.0), Inches(1.0))

            txBox = slide.shapes.add_textbox(Inches(1.6), Inches(2.2), Inches(10.1), Inches(1.1))
            tf = txBox.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = data["title"]
            set_font(p, size=Pt(28), bold=True, color=BRAND_ORANGE, alignment=PP_ALIGN.CENTER)

            p_sub = tf.add_paragraph()
            p_sub.text = data["subtitle"]
            set_font(p_sub, size=Pt(15), bold=True, color=BRAND_BLUE, alignment=PP_ALIGN.CENTER, space_before=Pt(6))

            txBox2 = slide.shapes.add_textbox(Inches(2.0), Inches(3.4), Inches(9.333), Inches(0.8))
            tf = txBox2.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = data["advisor"]
            set_font(p, size=Pt(14), italic=True, color=SLATE, alignment=PP_ALIGN.CENTER)

            qa_box = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(2.5), Inches(4.3), Inches(8.333), Inches(0.85))
            qa_box.fill.solid()
            qa_box.fill.fore_color.rgb = RGBColor(238, 242, 255)
            qa_box.line.color.rgb = RGBColor(99, 102, 241)
            qa_box.line.width = Pt(1.5)
            tf = qa_box.text_frame
            p = tf.paragraphs[0]
            p.text = "💬 " + data["qa"]
            set_font(p, size=Pt(16), bold=True, color=BRAND_BLUE, alignment=PP_ALIGN.CENTER)

            txBox3 = slide.shapes.add_textbox(Inches(2.0), Inches(5.35), Inches(9.333), Inches(1.1))
            tf = txBox3.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = data["links"]
            set_font(p, size=Pt(13.5), color=SLATE, alignment=PP_ALIGN.CENTER)

        else:
            top_bar = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(0), Inches(0), Inches(13.333), Inches(0.08))
            top_bar.fill.solid()
            top_bar.fill.fore_color.rgb = BRAND_ORANGE
            top_bar.line.fill.background()

            badge = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), Inches(0.32), Inches(3.2), Inches(0.36))
            badge.fill.solid()
            badge.fill.fore_color.rgb = RGBColor(254, 237, 232)
            badge.line.fill.background()
            tf = badge.text_frame
            p = tf.paragraphs[0]
            p.text = data.get("badge", "FOODAI")
            set_font(p, size=Pt(11.5), bold=True, color=BRAND_ORANGE, alignment=PP_ALIGN.CENTER)

            txHead = slide.shapes.add_textbox(Inches(0.8), Inches(0.7), Inches(11.0), Inches(0.8))
            tf = txHead.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = data["title"]
            set_font(p, size=Pt(22), bold=True, color=NAVY)

            p_sub = tf.add_paragraph()
            p_sub.text = data.get("subtitle", "")
            set_font(p_sub, size=Pt(12), color=SLATE)

            numBox = slide.shapes.add_textbox(Inches(11.8), Inches(0.35), Inches(0.9), Inches(0.4))
            tf = numBox.text_frame
            p = tf.paragraphs[0]
            p.text = f"{idx + 1} / 20"
            set_font(p, size=Pt(12.5), bold=True, color=RGBColor(148, 163, 184), alignment=PP_ALIGN.RIGHT)

            # ------------------------------------------
            # AGENDA
            # ------------------------------------------
            if data["type"] == "agenda":
                y = 1.65
                for item_title, item_desc in data["items"]:
                    card = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), Inches(y), Inches(11.733), Inches(0.9))
                    card.fill.solid()
                    card.fill.fore_color.rgb = WHITE
                    card.line.color.rgb = CARD_BORDER
                    card.line.width = Pt(1)

                    num_badge = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(1.0), Inches(y + 0.15), Inches(0.6), Inches(0.6))
                    num_badge.fill.solid()
                    num_badge.fill.fore_color.rgb = BRAND_ORANGE
                    num_badge.line.fill.background()
                    tf = num_badge.text_frame
                    p = tf.paragraphs[0]
                    p.text = item_title.split('.')[0]
                    set_font(p, size=Pt(14), bold=True, color=WHITE, alignment=PP_ALIGN.CENTER)

                    tx = slide.shapes.add_textbox(Inches(1.8), Inches(y + 0.08), Inches(10.5), Inches(0.75))
                    tf = tx.text_frame
                    tf.word_wrap = True
                    p1 = tf.paragraphs[0]
                    p1.text = item_title
                    set_font(p1, size=Pt(14.5), bold=True, color=NAVY)

                    p2 = tf.add_paragraph()
                    p2.text = item_desc
                    set_font(p2, size=Pt(12), color=SLATE)

                    y += 1.02

            # ------------------------------------------
            # COMPARISON COLUMNS
            # ------------------------------------------
            elif data["type"] == "comparison_columns":
                w = Inches(5.7)
                h = Inches(5.3)

                # Cột 1: Vấn đề / Nguy cơ
                card1 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), Inches(1.6), w, h)
                card1.fill.solid()
                card1.fill.fore_color.rgb = WHITE
                card1.line.color.rgb = data["col1_color"]
                card1.line.width = Pt(1.5)

                top_bar1 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), Inches(1.6), w, Inches(0.65))
                top_bar1.fill.solid()
                top_bar1.fill.fore_color.rgb = data["col1_color"]
                top_bar1.line.fill.background()
                tf1 = top_bar1.text_frame
                p = tf1.paragraphs[0]
                p.text = data["col1_title"]
                set_font(p, size=Pt(14.5), bold=True, color=WHITE, alignment=PP_ALIGN.CENTER)

                badge1 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(1.1), Inches(2.38), w - Inches(0.6), Inches(0.38))
                badge1.fill.solid()
                badge1.fill.fore_color.rgb = data["col1_bg"]
                badge1.line.color.rgb = data["col1_color"]
                badge1.line.width = Pt(1)
                tf_b1 = badge1.text_frame
                p = tf_b1.paragraphs[0]
                p.text = data["col1_badge"]
                set_font(p, size=Pt(11.5), bold=True, color=data["col1_color"], alignment=PP_ALIGN.CENTER)

                cur_y1 = Inches(2.9)
                for item_head, item_desc in data["col1_items"]:
                    box = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(1.1), cur_y1, w - Inches(0.6), Inches(1.18))
                    box.fill.solid()
                    box.fill.fore_color.rgb = RGBColor(254, 242, 242)
                    box.line.color.rgb = RGBColor(254, 202, 202)
                    box.line.width = Pt(1)

                    tx = slide.shapes.add_textbox(Inches(1.25), cur_y1 + Inches(0.06), w - Inches(0.9), Inches(1.05))
                    tf = tx.text_frame
                    tf.word_wrap = True
                    p1 = tf.paragraphs[0]
                    p1.text = "✗ " + item_head
                    set_font(p1, size=Pt(12.5), bold=True, color=data["col1_color"])

                    p2 = tf.add_paragraph()
                    p2.text = item_desc
                    set_font(p2, size=Pt(11), color=NAVY, space_before=Pt(3))

                    cur_y1 += Inches(1.28)

                # Cột 2: Giải pháp FoodAI Grounded RAG
                card2 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(6.8), Inches(1.6), w, h)
                card2.fill.solid()
                card2.fill.fore_color.rgb = WHITE
                card2.line.color.rgb = data["col2_color"]
                card2.line.width = Pt(1.5)

                top_bar2 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(6.8), Inches(1.6), w, Inches(0.65))
                top_bar2.fill.solid()
                top_bar2.fill.fore_color.rgb = data["col2_color"]
                top_bar2.line.fill.background()
                tf2 = top_bar2.text_frame
                p = tf2.paragraphs[0]
                p.text = data["col2_title"]
                set_font(p, size=Pt(14.5), bold=True, color=WHITE, alignment=PP_ALIGN.CENTER)

                badge2 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(7.1), Inches(2.38), w - Inches(0.6), Inches(0.38))
                badge2.fill.solid()
                badge2.fill.fore_color.rgb = data["col2_bg"]
                badge2.line.color.rgb = data["col2_color"]
                badge2.line.width = Pt(1)
                tf_b2 = badge2.text_frame
                p = tf_b2.paragraphs[0]
                p.text = data["col2_badge"]
                set_font(p, size=Pt(11.5), bold=True, color=data["col2_color"], alignment=PP_ALIGN.CENTER)

                cur_y2 = Inches(2.9)
                for item_head, item_desc in data["col2_items"]:
                    box = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(7.1), cur_y2, w - Inches(0.6), Inches(1.18))
                    box.fill.solid()
                    box.fill.fore_color.rgb = RGBColor(240, 253, 244)
                    box.line.color.rgb = RGBColor(187, 247, 208)
                    box.line.width = Pt(1)

                    tx = slide.shapes.add_textbox(Inches(7.25), cur_y2 + Inches(0.06), w - Inches(0.9), Inches(1.05))
                    tf = tx.text_frame
                    tf.word_wrap = True
                    p1 = tf.paragraphs[0]
                    p1.text = "✓ " + item_head
                    set_font(p1, size=Pt(12.5), bold=True, color=data["col2_color"])

                    p2 = tf.add_paragraph()
                    p2.text = item_desc
                    set_font(p2, size=Pt(11), color=NAVY, space_before=Pt(3))

                    cur_y2 += Inches(1.28)

            # ------------------------------------------
            # THREE TIERS ARCHITECTURE
            # ------------------------------------------
            elif data["type"] == "three_tiers":
                w = Inches(11.733)
                tier_h = Inches(1.5)
                y_positions = [Inches(1.6), Inches(3.45), Inches(5.3)]

                for t_idx, tier in enumerate(data["tiers"]):
                    y = y_positions[t_idx]
                    card = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), y, w, tier_h)
                    card.fill.solid()
                    card.fill.fore_color.rgb = WHITE
                    card.line.color.rgb = tier["color"]
                    card.line.width = Pt(1.5)

                    bar = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), y, w, Inches(0.42))
                    bar.fill.solid()
                    bar.fill.fore_color.rgb = tier["color"]
                    bar.line.fill.background()
                    tf = bar.text_frame
                    p = tf.paragraphs[0]
                    p.text = tier["name"]
                    set_font(p, size=Pt(12.5), bold=True, color=WHITE, alignment=PP_ALIGN.LEFT)

                    tx = slide.shapes.add_textbox(Inches(1.0), y + Inches(0.44), w - Inches(0.4), tier_h - Inches(0.48))
                    tf = tx.text_frame
                    tf.word_wrap = True

                    p_tech = tf.paragraphs[0]
                    p_tech.text = "Công nghệ: " + tier["tech"]
                    set_font(p_tech, size=Pt(11.5), bold=True, color=BRAND_BLUE)

                    for comp in tier["components"]:
                        p = tf.add_paragraph()
                        p.text = "• " + comp
                        set_font(p, size=Pt(11), color=NAVY, space_before=Pt(2))

                    if t_idx < 2:
                        arrow_bar = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(5.2), y + tier_h + Inches(0.04), Inches(2.9), Inches(0.26))
                        arrow_bar.fill.solid()
                        arrow_bar.fill.fore_color.rgb = RGBColor(241, 245, 249)
                        arrow_bar.line.color.rgb = CARD_BORDER
                        arrow_bar.line.width = Pt(1)
                        tf_a = arrow_bar.text_frame
                        p_a = tf_a.paragraphs[0]
                        p_a.text = "↕ RESTful API (JSON / Axios)" if t_idx == 0 else "↕ SQL Queries / Gemini SDK"
                        set_font(p_a, size=Pt(10), bold=True, color=SLATE, alignment=PP_ALIGN.CENTER)

            # ------------------------------------------
            # SPLIT TEXT & IMAGE
            # ------------------------------------------
            elif data["type"] == "split_text_image":
                text_w = Inches(5.6)
                img_w = Inches(5.9)
                content_h = Inches(5.3)

                cards = data.get("cards", [])
                card_h = (content_h - Inches(0.18 * (len(cards) - 1))) / len(cards)
                cur_y = Inches(1.6)

                for c_idx, (card_title, card_desc) in enumerate(cards):
                    c_shape = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), cur_y, text_w, card_h)
                    c_shape.fill.solid()
                    c_shape.fill.fore_color.rgb = WHITE
                    c_shape.line.color.rgb = CARD_BORDER
                    c_shape.line.width = Pt(1)

                    acc_colors = [BRAND_ORANGE, BRAND_BLUE, GREEN, PURPLE]
                    acc = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), cur_y, Inches(0.12), card_h)
                    acc.fill.solid()
                    acc.fill.fore_color.rgb = acc_colors[c_idx % len(acc_colors)]
                    acc.line.fill.background()

                    tx = slide.shapes.add_textbox(Inches(1.1), cur_y + Inches(0.1), text_w - Inches(0.4), card_h - Inches(0.15))
                    tf = tx.text_frame
                    tf.word_wrap = True
                    p1 = tf.paragraphs[0]
                    p1.text = card_title
                    set_font(p1, size=Pt(14), bold=True, color=acc_colors[c_idx % len(acc_colors)])

                    p2 = tf.add_paragraph()
                    p2.text = card_desc
                    set_font(p2, size=Pt(11.5), color=NAVY, space_before=Pt(4))

                    cur_y += card_h + Inches(0.18)

                add_fitted_picture(slide, data["img_path"], Inches(6.6), Inches(1.6), img_w, content_h, bg_card=True, caption=data.get("img_caption"))

            # ------------------------------------------
            # TWO IMAGES
            # ------------------------------------------
            elif data["type"] == "two_images":
                w = Inches(5.7)

                add_fitted_picture(slide, data["img1_path"], Inches(0.8), Inches(1.6), w, Inches(3.6), bg_card=True)
                desc1 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), Inches(5.35), w, Inches(1.55))
                desc1.fill.solid()
                desc1.fill.fore_color.rgb = WHITE
                desc1.line.color.rgb = CARD_BORDER
                desc1.line.width = Pt(1)

                tx1 = slide.shapes.add_textbox(Inches(0.95), Inches(5.42), w - Inches(0.3), Inches(1.4))
                tf1 = tx1.text_frame
                tf1.word_wrap = True
                p = tf1.paragraphs[0]
                p.text = data["img1_title"]
                set_font(p, size=Pt(13.5), bold=True, color=BRAND_ORANGE)

                p_sub = tf1.add_paragraph()
                p_sub.text = data["img1_desc"]
                set_font(p_sub, size=Pt(11), color=SLATE, space_before=Pt(4))

                add_fitted_picture(slide, data["img2_path"], Inches(6.8), Inches(1.6), w, Inches(3.6), bg_card=True)
                desc2 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(6.8), Inches(5.35), w, Inches(1.55))
                desc2.fill.solid()
                desc2.fill.fore_color.rgb = WHITE
                desc2.line.color.rgb = CARD_BORDER
                desc2.line.width = Pt(1)

                tx2 = slide.shapes.add_textbox(Inches(6.95), Inches(5.42), w - Inches(0.3), Inches(1.4))
                tf2 = tx2.text_frame
                tf2.word_wrap = True
                p = tf2.paragraphs[0]
                p.text = data["img2_title"]
                set_font(p, size=Pt(13.5), bold=True, color=BRAND_BLUE)

                p_sub = tf2.add_paragraph()
                p_sub.text = data["img2_desc"]
                set_font(p_sub, size=Pt(11), color=SLATE, space_before=Pt(4))

            # ------------------------------------------
            # FOUR CARDS
            # ------------------------------------------
            elif data["type"] == "four_cards":
                w = Inches(5.7)
                h = Inches(2.45)
                coords = [
                    (Inches(0.8), Inches(1.6)),
                    (Inches(6.8), Inches(1.6)),
                    (Inches(0.8), Inches(4.35)),
                    (Inches(6.8), Inches(4.35))
                ]

                for (cx, cy), (ctitle, cdesc, color) in zip(coords, data["cards"]):
                    card = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, cx, cy, w, h)
                    card.fill.solid()
                    card.fill.fore_color.rgb = WHITE
                    card.line.color.rgb = CARD_BORDER
                    card.line.width = Pt(1)

                    left_bar = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, cx, cy, Inches(0.14), h)
                    left_bar.fill.solid()
                    left_bar.fill.fore_color.rgb = color
                    left_bar.line.fill.background()

                    tx = slide.shapes.add_textbox(cx + Inches(0.35), cy + Inches(0.2), w - Inches(0.55), h - Inches(0.35))
                    tf = tx.text_frame
                    tf.word_wrap = True
                    p_head = tf.paragraphs[0]
                    p_head.text = ctitle
                    set_font(p_head, size=Pt(15.5), bold=True, color=color)

                    p_body = tf.add_paragraph()
                    p_body.text = cdesc
                    set_font(p_body, size=Pt(12.5), color=NAVY, space_before=Pt(8))

            # ------------------------------------------
            # THREE COLUMNS
            # ------------------------------------------
            elif data["type"] == "three_columns":
                w = Inches(3.7)
                h = Inches(5.3)
                xs = [Inches(0.8), Inches(4.82), Inches(8.84)]

                for x, (col_title, col_color, items) in zip(xs, data["cols"]):
                    card = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, x, Inches(1.6), w, h)
                    card.fill.solid()
                    card.fill.fore_color.rgb = WHITE
                    card.line.color.rgb = CARD_BORDER
                    card.line.width = Pt(1)

                    bar = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, x, Inches(1.6), w, Inches(0.5))
                    bar.fill.solid()
                    bar.fill.fore_color.rgb = col_color
                    bar.line.fill.background()
                    tf = bar.text_frame
                    p = tf.paragraphs[0]
                    p.text = col_title
                    set_font(p, size=Pt(14), bold=True, color=WHITE, alignment=PP_ALIGN.CENTER)

                    cur_item_y = Inches(2.25)
                    for item_head, item_detail in items:
                        item_box = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, x + Inches(0.2), cur_item_y, w - Inches(0.4), Inches(1.35))
                        item_box.fill.solid()
                        item_box.fill.fore_color.rgb = RGBColor(248, 250, 252)
                        item_box.line.color.rgb = CARD_BORDER
                        item_box.line.width = Pt(1)

                        tx = slide.shapes.add_textbox(x + Inches(0.3), cur_item_y + Inches(0.08), w - Inches(0.6), Inches(1.2))
                        tf = tx.text_frame
                        tf.word_wrap = True
                        p1 = tf.paragraphs[0]
                        p1.text = item_head
                        set_font(p1, size=Pt(12.5), bold=True, color=col_color)

                        p2 = tf.add_paragraph()
                        p2.text = item_detail
                        set_font(p2, size=Pt(11), color=NAVY, space_before=Pt(3))

                        cur_item_y += Inches(1.48)

            # ------------------------------------------
            # TWO COLUMNS
            # ------------------------------------------
            elif data["type"] == "two_columns":
                w = Inches(5.7)
                h = Inches(5.3)

                # Cột 1
                card1 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), Inches(1.6), w, h)
                card1.fill.solid()
                card1.fill.fore_color.rgb = WHITE
                card1.line.color.rgb = CARD_BORDER
                card1.line.width = Pt(1)

                bar1 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), Inches(1.6), w, Inches(0.55))
                bar1.fill.solid()
                bar1.fill.fore_color.rgb = data.get("col1_color", BRAND_ORANGE)
                bar1.line.fill.background()
                tf = bar1.text_frame
                p = tf.paragraphs[0]
                p.text = data["col1_title"]
                set_font(p, size=Pt(14.5), bold=True, color=WHITE, alignment=PP_ALIGN.CENTER)

                tx1 = slide.shapes.add_textbox(Inches(1.0), Inches(2.3), w - Inches(0.4), h - Inches(0.8))
                tf1 = tx1.text_frame
                tf1.word_wrap = True
                for b_idx, bullet in enumerate(data["col1_bullets"]):
                    p = tf1.paragraphs[0] if b_idx == 0 else tf1.add_paragraph()
                    p.text = "✓ " + bullet
                    set_font(p, size=Pt(13), color=NAVY, space_before=Pt(10))

                # Cột 2
                card2 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(6.8), Inches(1.6), w, h)
                card2.fill.solid()
                card2.fill.fore_color.rgb = WHITE
                card2.line.color.rgb = CARD_BORDER
                card2.line.width = Pt(1)

                bar2 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(6.8), Inches(1.6), w, Inches(0.55))
                bar2.fill.solid()
                bar2.fill.fore_color.rgb = data.get("col2_color", BRAND_BLUE)
                bar2.line.fill.background()
                tf = bar2.text_frame
                p = tf.paragraphs[0]
                p.text = data["col2_title"]
                set_font(p, size=Pt(14.5), bold=True, color=WHITE, alignment=PP_ALIGN.CENTER)

                tx2 = slide.shapes.add_textbox(Inches(7.0), Inches(2.3), w - Inches(0.4), h - Inches(0.8))
                tf2 = tx2.text_frame
                tf2.word_wrap = True
                for b_idx, bullet in enumerate(data["col2_bullets"]):
                    p = tf2.paragraphs[0] if b_idx == 0 else tf2.add_paragraph()
                    p.text = "★ " + bullet
                    set_font(p, size=Pt(13), color=NAVY, space_before=Pt(12))

            # ------------------------------------------
            # TABLE
            # ------------------------------------------
            elif data["type"] == "table":
                rows = len(data["rows"]) + 1
                cols = len(data["headers"])
                table_shape = slide.shapes.add_table(rows, cols, Inches(0.8), Inches(1.6), Inches(11.733), Inches(5.1))
                table = table_shape.table

                table.columns[0].width = Inches(1.4)
                table.columns[1].width = Inches(3.8)
                table.columns[2].width = Inches(4.7)
                table.columns[3].width = Inches(1.833)

                for c_idx, head_text in enumerate(data["headers"]):
                    cell = table.cell(0, c_idx)
                    cell.text = head_text
                    cell.fill.solid()
                    cell.fill.fore_color.rgb = BRAND_BLUE
                    for p in cell.text_frame.paragraphs:
                        set_font(p, size=Pt(12.5), bold=True, color=WHITE, alignment=PP_ALIGN.CENTER)

                for r_idx, row_data in enumerate(data["rows"]):
                    for c_idx, val in enumerate(row_data):
                        cell = table.cell(r_idx + 1, c_idx)
                        cell.text = val
                        cell.fill.solid()
                        cell.fill.fore_color.rgb = WHITE if r_idx % 2 == 0 else RGBColor(241, 245, 249)
                        for p in cell.text_frame.paragraphs:
                            align = PP_ALIGN.CENTER if c_idx in [0, 3] else PP_ALIGN.LEFT
                            font_color = GREEN if c_idx == 3 else NAVY
                            bold = True if c_idx in [0, 3] else False
                            set_font(p, size=Pt(11.5), bold=bold, color=font_color, alignment=align)

            # ------------------------------------------
            # KPI METRICS + TABLE
            # ------------------------------------------
            elif data["type"] == "kpi_metrics_table":
                kpi_w = Inches(3.7)
                kpi_h = Inches(1.3)
                kpi_xs = [Inches(0.8), Inches(4.82), Inches(8.84)]

                for kx, (k_val, k_title, k_desc, k_col) in zip(kpi_xs, data["kpis"]):
                    k_card = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, kx, Inches(1.6), kpi_w, kpi_h)
                    k_card.fill.solid()
                    k_card.fill.fore_color.rgb = WHITE
                    k_card.line.color.rgb = CARD_BORDER
                    k_card.line.width = Pt(1)

                    k_bar = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, kx, Inches(1.6), kpi_w, Inches(0.08))
                    k_bar.fill.solid()
                    k_bar.fill.fore_color.rgb = k_col
                    k_bar.line.fill.background()

                    tx = slide.shapes.add_textbox(kx + Inches(0.15), Inches(1.72), kpi_w - Inches(0.3), kpi_h - Inches(0.2))
                    tf = tx.text_frame
                    tf.word_wrap = True
                    p_val = tf.paragraphs[0]
                    p_val.text = k_val
                    set_font(p_val, size=Pt(21), bold=True, color=k_col, alignment=PP_ALIGN.CENTER)

                    p_tit = tf.add_paragraph()
                    p_tit.text = k_title
                    set_font(p_tit, size=Pt(11.5), bold=True, color=NAVY, alignment=PP_ALIGN.CENTER)

                    p_d = tf.add_paragraph()
                    p_d.text = k_desc
                    set_font(p_d, size=Pt(10), color=SLATE, alignment=PP_ALIGN.CENTER)

                rows = len(data["rows"]) + 1
                cols = len(data["headers"])
                table_shape = slide.shapes.add_table(rows, cols, Inches(0.8), Inches(3.1), Inches(11.733), Inches(3.8))
                table = table_shape.table

                table.columns[0].width = Inches(3.8)
                table.columns[1].width = Inches(2.2)
                table.columns[2].width = Inches(2.4)
                table.columns[3].width = Inches(3.333)

                for c_idx, head_text in enumerate(data["headers"]):
                    cell = table.cell(0, c_idx)
                    cell.text = head_text
                    cell.fill.solid()
                    cell.fill.fore_color.rgb = BRAND_BLUE
                    for p in cell.text_frame.paragraphs:
                        set_font(p, size=Pt(12), bold=True, color=WHITE, alignment=PP_ALIGN.CENTER)

                for r_idx, row_data in enumerate(data["rows"]):
                    for c_idx, val in enumerate(row_data):
                        cell = table.cell(r_idx + 1, c_idx)
                        cell.text = val
                        cell.fill.solid()
                        cell.fill.fore_color.rgb = WHITE if r_idx % 2 == 0 else RGBColor(241, 245, 249)
                        for p in cell.text_frame.paragraphs:
                            align = PP_ALIGN.CENTER if c_idx in [1, 2] else PP_ALIGN.LEFT
                            font_color = GREEN if ("⭐" in val or "0,21" in val or "98," in val or "100%" in val) else NAVY
                            bold = True if c_idx in [1, 2] else False
                            set_font(p, size=Pt(11), bold=bold, color=font_color, alignment=align)

    # Ép triệt để font Times New Roman trên mọi element
    apply_font_to_presentation(prs, FONT_FAMILY)

    output_path = "FoodAI_Slide_Thuyet_Trinh_20_Slides.pptx"
    prs.save(output_path)
    print(f"✅ Đã tạo thành công file PowerPoint 20 slides với font {FONT_FAMILY}: {output_path}")

if __name__ == "__main__":
    create_presentation()
