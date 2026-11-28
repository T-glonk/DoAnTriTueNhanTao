# -*- coding: utf-8 -*-
"""
Hệ thống AI Gợi Ý Món Ăn Theo Nguyên Liệu (FoodAI)
Bộ Slide Thuyết Trình 20 Trang Chuẩn Khoa Học & Trực Quan
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

def add_fitted_picture(slide, img_path, left, top, max_w, max_h, bg_card=True, caption=None):
    """Thêm hình ảnh vào slide với tỷ lệ chuẩn không méo, kèm khung card bo góc viền tinh tế."""
    if not os.path.exists(img_path):
        print(f"Warning: image path not found: {img_path}")
        return None

    with Image.open(img_path) as im:
        img_w, img_h = im.size
    aspect = img_w / img_h

    # Dành chỗ cho caption nếu có
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
        p.font.size = Pt(10.5)
        p.font.italic = True
        p.font.color.rgb = RGBColor(100, 116, 139)
        p.alignment = PP_ALIGN.CENTER

    return pic

def create_presentation():
    prs = Presentation()
    prs.slide_width = Inches(13.333)
    prs.slide_height = Inches(7.5)
    blank_layout = prs.slide_layouts[6]

    # Bảng màu nhận diện giao diện FoodAI
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

    # Đường dẫn tài nguyên ảnh
    IMG_LOGO = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/assets/dau-logo.png"
    FIG_RAG_FLOW = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/figs/seq_goi_y_mon_an.png"
    FIG_SEQ_FAV = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/figs/seq_quan_ly_yeu_thich.png"
    FIG_UI_DASHBOARD = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/figs/ui_trang_chu_dashboard.jpg"
    FIG_UI_MODAL = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/figs/ui_modal_chi_tiet_mon.jpg"
    FIG_UI_ADMIN_OVERVIEW = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/figs/ui_admin_tong_quan.jpg"
    FIG_UI_ADMIN_USERS = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/figs/ui_admin_quan_ly_nguoi_dung.jpg"
    FIG_UI_ADMIN_RECIPES = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/figs/ui_admin_kho_mon_an.jpg"
    FIG_UI_FAVORITES = "BaoCaoDoAnTriTueNhanTao-main/template-do-an-ttnt/figs/ui_mon_an_yeu_thich.jpg"
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
            "notes": "Kính thưa quý Thầy Cô trong Hội đồng chấm đồ án và các bạn sinh viên. Hôm nay, nhóm chúng em gồm Phạm Tấn Hào và Trần Quốc Trung, dưới sự hướng dẫn của TS. Đỗ Phúc Hảo, xin được báo cáo đồ án Trí tuệ Nhân tạo với đề tài: 'Hệ thống AI gợi ý món ăn theo nguyên liệu - FoodAI'."
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
            "notes": "Bài thuyết trình của nhóm em gồm 5 phần chính: từ lý do chọn đề tài, cơ sở công nghệ, giải thuật cốt lõi giải quyết bài toán ảo giác của AI, kết quả thực nghiệm hệ thống và định hướng phát triển."
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
                ("Câu hỏi thường trực", "Người nội trợ, sinh viên bối rối mỗi ngày: 'Hôm nay ăn gì?', 'Tủ lạnh còn những gì nấu được món gì ngon?'."),
                ("Lãng phí thực phẩm", "Lượng lớn rau củ, thịt cá tươi sống bị bỏ phí hằng tuần do thiếu kỹ năng kết hợp nguyên liệu sẵn có."),
                ("Hạn chế tra cứu truyền thống", "Buộc người dùng phải biết trước tên món ăn (ví dụ: 'thịt kho tàu') mới tìm được; tra cứu từ khóa máy móc và thiếu định lượng dinh dưỡng.")
            ],
            "img_path": FIG_UI_DASHBOARD,
            "img_caption": "Giao diện gợi ý thông minh của FoodAI - Giải pháp nấu ăn theo nguyên liệu có sẵn",
            "notes": "Xuất phát từ thực tế đời sống, người nội trợ hay sinh viên thường mở tủ lạnh và bối rối vì không biết những nguyên liệu còn lại có thể nấu được món gì. Các website tra cứu hiện nay đều đòi hỏi người dùng phải biết sẵn tên món mới tìm được, dẫn đến việc nguyên liệu thừa bị bỏ phí."
        },

        # ==========================================
        # SLIDE 4: THÁCH THỨC LLM & GROUNDED RAG
        # ==========================================
        {
            "type": "split_text_image",
            "badge": "GIẢI PHÁP ĐỀ XUẤT",
            "title": "Thách Thức Ảo Giác Của LLM & Đột Phá Grounded RAG",
            "subtitle": "Khắc phục triệt để hiện tượng bịa đặt nguyên liệu đắt tiền của các mô hình ngôn ngữ lớn",
            "cards": [
                ("Ảo giác của LLM thuần túy (Hallucination)", "Khi người dùng chỉ có [Trứng, Cà chua], LLM tự ý thêm thịt bò phi-lê, tôm sú, nấm đắt tiền để món ăn hấp dẫn hơn -> Gợi ý phi thực tế, gây thất vọng."),
                ("Giải pháp Grounded RAG của FoodAI", "Khóa chặt AI vào kho tri thức CSDL ẩm thực Việt Nam có sẵn làm mỏ neo ngữ cảnh vững chắc. CSDL lọc món thật trước, AI tuyệt đối không được tự bịa món mới."),
                ("Phân vai AI Chef & Chuyên gia dinh dưỡng", "Gemini AI chỉ tập trung tính toán định lượng gram, 8 chỉ số dinh dưỡng (calo, đạm, béo, xơ...) và viết mẹo ẩm thực.")
            ],
            "img_path": FIG_RAG_FLOW,
            "img_caption": "Sơ đồ kiến trúc Grounded RAG - Khóa chặt dữ liệu đầu ra của Gemini AI",
            "notes": "Nếu chỉ dùng AI thuần túy, AI sẽ thường xuyên bị 'ảo giác' - tự bịa thêm thịt bò, tôm đắt tiền mà người dùng không hề có. Giải pháp của nhóm em là khóa chặt AI bằng kỹ thuật Grounded RAG: CSDL nội bộ lọc ra món thật trước, AI chỉ tính toán dinh dưỡng và thời gian nấu."
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
            "notes": "Đề tài đặt ra 4 mục tiêu cụ thể: xây dựng kho dữ liệu 552 món Cookpad, tích hợp Gemini AI phân tích dinh dưỡng khoa học, xử lý triệt để bất đồng ngữ nghĩa tiếng Việt và xây dựng cơ chế Fallback đảm bảo hệ thống luôn sẵn sàng 100%."
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
            "notes": "Về mặt công nghệ, hệ thống áp dụng toàn diện hệ sinh thái JavaScript/TypeScript hiện đại với React 18 ở Frontend, Node.js Express ở Backend, CSDL quan hệ MySQL và Google Gemini AI làm động cơ trí tuệ nhân tạo."
        },

        # ==========================================
        # SLIDE 7: KIẾN TRÚC HỆ THỐNG 3 TẦNG
        # ==========================================
        {
            "type": "split_text_image",
            "badge": "KIẾN TRÚC HỆ THỐNG",
            "title": "Kiến Trúc Hệ Thống 3 Tầng (Three-Tier Architecture)",
            "subtitle": "Phân tách trách nhiệm độc lập giữa Giao diện, Xử lý nghiệp vụ và Tầng dữ liệu",
            "cards": [
                ("Tầng Giao Diện (Presentation Layer)", "React SPA đa phân hệ: User Dashboard (nhập nguyên liệu tag màu, xem chi tiết món) & Admin Panel (quản lý user, kho món, log AI)."),
                ("Tầng Ứng Dụng (Application Layer)", "Node.js Express Controller & Services: bóc tách độc lập GeminiService, RecipeService, ImageService và AuthService."),
                ("Tầng Dữ Liệu & AI (Data & AI Layer)", "Hệ thống CSDL MySQL 8.0 lưu trữ quan hệ 3NF kết hợp dịch vụ đám mây Google Gemini AI Cloud.")
            ],
            "img_path": FIG_SEQ_FAV,
            "img_caption": "Sơ đồ tương tác luồng dữ liệu chuẩn hóa qua các tầng kiến trúc",
            "notes": "Kiến trúc hệ thống được phân lớp nghiêm ngặt thành 3 tầng rõ ràng. Tầng ứng dụng bóc tách các Service độc lập, giúp mã nguồn đạt tính gắn kết cao, dễ bảo trì, mở rộng và kiểm thử đơn vị."
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
            "img_path": FIG_RAG_FLOW,
            "img_caption": "Biểu đồ tuần tự (Sequence Diagram) chi tiết luồng Gợi ý Món ăn Grounded RAG",
            "notes": "Đây là trọng tâm kỹ thuật của đồ án: Luồng Grounded RAG 4 bước. Thay vì để AI tự do sáng tạo tên món, CSDL đóng vai trò mỏ neo định hướng danh sách món thật, AI chỉ tính toán dinh dưỡng và định lượng, sau đó dữ liệu được cập nhật ngược về CSDL."
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
            "notes": "Xử lý tiếng Việt là bài toán cực kỳ dễ sai lệch nếu chỉ so chuỗi đơn thuần. Ví dụ người dùng gõ 'cà chua', nếu không có bộ lọc loại trừ, thuật toán sẽ nhầm thành nguyên liệu 'cá'. Nhóm đã cài đặt ma trận từ điển đồng nghĩa và danh sách Negative Excludes để loại trừ triệt để lỗi này."
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
            "notes": "Hệ thống áp dụng công thức chấm điểm đa tiêu chí: ưu tiên món khớp nhiều nguyên liệu nhất, tên món chứa từ khóa chính và đúng loại đạm. Các món phụ chỉ khớp 1 nguyên liệu sẽ bị điểm thấp và tự động bị đẩy xuống hoặc loại bỏ."
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
            "notes": "Cơ sở dữ liệu được thiết kế chuẩn hóa 3NF với 9 bảng. Đặc biệt hệ thống có tính năng Auto-Seed: bất kỳ ai tải dự án về chỉ cần tạo CSDL rỗng, khi backend chạy sẽ tự động nạp toàn bộ 552 món và ảnh vào MySQL."
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
            "notes": "Để giải quyết triệt để vấn đề hình ảnh không khớp với món ăn, nhóm xây dựng bộ lọc tự động kiểm tra slug của URL ảnh, và đồng thời cung cấp giao diện Admin cho phép thay thế link ảnh thủ công mọi lúc."
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
            "notes": "Giao diện người dùng được thiết kế hiện đại, thân thiện. Điểm nhấn là Modal chi tiết 3 Tab vừa hiển thị công thức, vừa định lượng gram nguyên liệu và hiển thị biểu đồ dinh dưỡng khoa học."
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
            "notes": "Phân hệ Admin Panel cung cấp đầy đủ công cụ quản trị dữ liệu, giám sát hoạt động của Gemini AI và cho phép quản lý vòng đời tài khoản người dùng an toàn."
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
            "notes": "Hệ thống được thiết kế theo tư duy chịu lỗi công nghiệp: nếu Google Gemini gặp sự cố mạng hoặc hết hạn mức, tầng Fallback nội bộ sẽ tự động phản hồi chỉ trong 0,21 giây từ CSDL MySQL, trải nghiệm người dùng không bao giờ bị gián đoạn."
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
            "notes": "Toàn bộ 6 kịch bản kiểm thử trọng yếu từ bảo mật, xử lý ngoại lệ đến tính toàn vẹn dữ liệu đều đạt tỷ lệ Pass 100%, khẳng định độ hoàn thiện cao của phần mềm."
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
            "notes": "Kết quả định lượng cho thấy sự kết hợp hoàn hảo giữa 2 chế độ: Chế độ AI vượt trội về tính sáng tạo (4,8 sao) và tỷ lệ bám sát nguyên liệu (97,8%), trong khi chế độ Fallback tối ưu về tốc độ (0,21 giây) và độ chuẩn xác hình ảnh (98,2%)."
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
            "img_path": FIG_UI_FAVORITES,
            "img_caption": "Món ăn sau khi gợi ý có thể lưu vào sổ tay Yêu thích với 1 lần chạm",
            "notes": "Trên màn hình là hai kịch bản điển hình: Dù người dùng chỉ có trứng cà chua hay có thịt bò, hệ thống đều đưa ra các món ăn thân thuộc, chuẩn vị Việt Nam, đúng định lượng và hình ảnh chân thực 100%."
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
            "notes": "Đề tài đã hoàn thành xuất sắc các mục tiêu đề ra. Trong tương lai, nhóm sẽ mở rộng thêm tính năng nhận diện thực phẩm qua camera AI và lập thực đơn dinh dưỡng theo tuần cho gia đình."
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
            "notes": "Em xin chân thành cảm ơn quý Thầy Cô trong Hội đồng đã chú ý lắng nghe bài báo cáo của nhóm. Chúng em rất mong nhận được những lời nhận xét, góp ý quý báu của quý Thầy Cô để hoàn thiện đề tài hơn nữa. Nhóm chúng em xin sẵn sàng trả lời các câu hỏi của Hội đồng ạ!"
        }
    ]

    for idx, data in enumerate(slides_data):
        slide = prs.slides.add_slide(blank_layout)

        # 1. Nền slide phẳng thanh lịch
        bg = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, 0, 0, prs.slide_width, prs.slide_height)
        bg.fill.solid()
        bg.fill.fore_color.rgb = LIGHT_BG
        bg.line.fill.background()

        # 2. Speaker notes
        if "notes" in data:
            notes_slide = slide.notes_slide
            tf_notes = notes_slide.notes_text_frame
            tf_notes.text = data["notes"]

        # ==========================================
        # RENDER TỪNG LOẠI SLIDE
        # ==========================================
        if data["type"] == "title":
            # Thanh trang trí trên cùng
            top_bar = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(0), Inches(0), Inches(13.333), Inches(0.2))
            top_bar.fill.solid()
            top_bar.fill.fore_color.rgb = BRAND_ORANGE
            top_bar.line.fill.background()

            # Thẻ trung tâm chính
            card = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(1.2), Inches(0.7), Inches(10.933), Inches(6.1))
            card.fill.solid()
            card.fill.fore_color.rgb = WHITE
            card.line.color.rgb = CARD_BORDER
            card.line.width = Pt(1.5)

            # Logo trường ĐH Kiến trúc Đà Nẵng
            if os.path.exists(IMG_LOGO):
                slide.shapes.add_picture(IMG_LOGO, Inches(1.6), Inches(1.0), Inches(1.0), Inches(1.0))

            # Header trường & khoa
            txSchool = slide.shapes.add_textbox(Inches(2.8), Inches(1.0), Inches(8.8), Inches(0.9))
            tf = txSchool.text_frame
            tf.word_wrap = True
            p0 = tf.paragraphs[0]
            p0.text = "TRƯỜNG ĐẠI HỌC KIẾN TRÚC ĐÀ NẴNG — KHOA CÔNG NGHỆ THÔNG TIN"
            p0.font.size = Pt(13)
            p0.font.bold = True
            p0.font.color.rgb = BRAND_BLUE

            p_badge = tf.add_paragraph()
            p_badge.text = "BÁO CÁO ĐỒ ÁN MÔN HỌC: TRÍ TUỆ NHÂN TẠO (AIP202)"
            p_badge.font.size = Pt(12)
            p_badge.font.bold = True
            p_badge.font.color.rgb = BRAND_ORANGE

            # Đường phân cách
            line = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(1.6), Inches(2.1), Inches(10.1), Inches(0.04))
            line.fill.solid()
            line.fill.fore_color.rgb = CARD_BORDER
            line.line.fill.background()

            # Tên đề tài nổi bật
            txTitle = slide.shapes.add_textbox(Inches(1.6), Inches(2.3), Inches(10.1), Inches(1.5))
            tf = txTitle.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = data["title"]
            p.font.size = Pt(27)
            p.font.bold = True
            p.font.color.rgb = BRAND_ORANGE
            p.alignment = PP_ALIGN.CENTER

            p_sub = tf.add_paragraph()
            p_sub.text = data["subtitle"]
            p_sub.font.size = Pt(13.5)
            p_sub.font.color.rgb = SLATE
            p_sub.alignment = PP_ALIGN.CENTER
            p_sub.space_before = Pt(8)

            # Khối thông tin sinh viên & giảng viên
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
            p1.font.size = Pt(14)
            p1.font.bold = True
            p1.font.color.rgb = NAVY
            p1.alignment = PP_ALIGN.CENTER

            p2 = tf.add_paragraph()
            p2.text = data["advisor"]
            p2.font.size = Pt(13.5)
            p2.font.bold = True
            p2.font.color.rgb = BRAND_BLUE
            p2.alignment = PP_ALIGN.CENTER
            p2.space_before = Pt(6)

            p3 = tf.add_paragraph()
            p3.text = data["dept"]
            p3.font.size = Pt(11.5)
            p3.font.color.rgb = SLATE
            p3.alignment = PP_ALIGN.CENTER
            p3.space_before = Pt(6)

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
            p.font.size = Pt(28)
            p.font.bold = True
            p.font.color.rgb = BRAND_ORANGE
            p.alignment = PP_ALIGN.CENTER

            p_sub = tf.add_paragraph()
            p_sub.text = data["subtitle"]
            p_sub.font.size = Pt(15)
            p_sub.font.bold = True
            p_sub.font.color.rgb = BRAND_BLUE
            p_sub.alignment = PP_ALIGN.CENTER
            p_sub.space_before = Pt(6)

            txBox2 = slide.shapes.add_textbox(Inches(2.0), Inches(3.4), Inches(9.333), Inches(0.8))
            tf = txBox2.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = data["advisor"]
            p.font.size = Pt(13.5)
            p.font.italic = True
            p.font.color.rgb = SLATE
            p.alignment = PP_ALIGN.CENTER

            # Khối Q&A nổi bật
            qa_box = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(2.5), Inches(4.3), Inches(8.333), Inches(0.85))
            qa_box.fill.solid()
            qa_box.fill.fore_color.rgb = RGBColor(238, 242, 255)
            qa_box.line.color.rgb = RGBColor(99, 102, 241)
            qa_box.line.width = Pt(1.5)
            tf = qa_box.text_frame
            p = tf.paragraphs[0]
            p.text = "💬 " + data["qa"]
            p.font.size = Pt(16)
            p.font.bold = True
            p.font.color.rgb = BRAND_BLUE
            p.alignment = PP_ALIGN.CENTER

            txBox3 = slide.shapes.add_textbox(Inches(2.0), Inches(5.35), Inches(9.333), Inches(1.1))
            tf = txBox3.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = data["links"]
            p.font.size = Pt(13)
            p.font.color.rgb = SLATE
            p.alignment = PP_ALIGN.CENTER

        else:
            # ==========================================
            # TIÊU ĐỀ CHUNG CHO CÁC SLIDE NỘI DUNG (3-19)
            # ==========================================
            top_bar = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(0), Inches(0), Inches(13.333), Inches(0.08))
            top_bar.fill.solid()
            top_bar.fill.fore_color.rgb = BRAND_ORANGE
            top_bar.line.fill.background()

            # Huy hiệu chuyên mục (Badge)
            badge = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), Inches(0.32), Inches(3.0), Inches(0.35))
            badge.fill.solid()
            badge.fill.fore_color.rgb = RGBColor(254, 237, 232)
            badge.line.fill.background()
            tf = badge.text_frame
            p = tf.paragraphs[0]
            p.text = data.get("badge", "FOODAI")
            p.font.size = Pt(11)
            p.font.bold = True
            p.font.color.rgb = BRAND_ORANGE
            p.alignment = PP_ALIGN.CENTER

            # Tiêu đề & phụ đề slide
            txHead = slide.shapes.add_textbox(Inches(0.8), Inches(0.7), Inches(11.0), Inches(0.8))
            tf = txHead.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = data["title"]
            p.font.size = Pt(21)
            p.font.bold = True
            p.font.color.rgb = NAVY

            p_sub = tf.add_paragraph()
            p_sub.text = data.get("subtitle", "")
            p_sub.font.size = Pt(11.5)
            p_sub.font.color.rgb = SLATE

            # Số trang slide
            numBox = slide.shapes.add_textbox(Inches(11.8), Inches(0.35), Inches(0.9), Inches(0.4))
            tf = numBox.text_frame
            p = tf.paragraphs[0]
            p.text = f"{idx + 1} / 20"
            p.font.size = Pt(12)
            p.font.bold = True
            p.font.color.rgb = RGBColor(148, 163, 184)
            p.alignment = PP_ALIGN.RIGHT

            # ==========================================
            # LAYOUT: AGENDA
            # ==========================================
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
                    p.font.size = Pt(14)
                    p.font.bold = True
                    p.font.color.rgb = WHITE
                    p.alignment = PP_ALIGN.CENTER

                    tx = slide.shapes.add_textbox(Inches(1.8), Inches(y + 0.08), Inches(10.5), Inches(0.75))
                    tf = tx.text_frame
                    tf.word_wrap = True
                    p1 = tf.paragraphs[0]
                    p1.text = item_title
                    p1.font.size = Pt(14)
                    p1.font.bold = True
                    p1.font.color.rgb = NAVY

                    p2 = tf.add_paragraph()
                    p2.text = item_desc
                    p2.font.size = Pt(11.5)
                    p2.font.color.rgb = SLATE

                    y += 1.02

            # ==========================================
            # LAYOUT: SPLIT TEXT & IMAGE (CHỮ TRÁI - ẢNH PHẢI)
            # ==========================================
            elif data["type"] == "split_text_image":
                text_w = Inches(5.6)
                img_w = Inches(5.9)
                content_h = Inches(5.3)

                # Cột trái: Các thẻ điểm nhấn súc tích
                cards = data.get("cards", [])
                card_h = (content_h - Inches(0.18 * (len(cards) - 1))) / len(cards)
                cur_y = Inches(1.6)

                for c_idx, (card_title, card_desc) in enumerate(cards):
                    c_shape = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), cur_y, text_w, card_h)
                    c_shape.fill.solid()
                    c_shape.fill.fore_color.rgb = WHITE
                    c_shape.line.color.rgb = CARD_BORDER
                    c_shape.line.width = Pt(1)

                    # Accent bar
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
                    p1.font.size = Pt(13.5)
                    p1.font.bold = True
                    p1.font.color.rgb = acc_colors[c_idx % len(acc_colors)]

                    p2 = tf.add_paragraph()
                    p2.text = card_desc
                    p2.font.size = Pt(11)
                    p2.font.color.rgb = NAVY
                    p2.space_before = Pt(4)

                    cur_y += card_h + Inches(0.18)

                # Cột phải: Hình ảnh minh họa chất lượng cao có khung và chú thích
                add_fitted_picture(slide, data["img_path"], Inches(6.6), Inches(1.6), img_w, content_h, bg_card=True, caption=data.get("img_caption"))

            # ==========================================
            # LAYOUT: TWO IMAGES (2 ẢNH SO SÁNH / GIAO DIỆN)
            # ==========================================
            elif data["type"] == "two_images":
                w = Inches(5.7)
                h = Inches(5.3)

                # Khối ảnh 1 (Trái)
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
                p.font.size = Pt(13)
                p.font.bold = True
                p.font.color.rgb = BRAND_ORANGE

                p_sub = tf1.add_paragraph()
                p_sub.text = data["img1_desc"]
                p_sub.font.size = Pt(10.5)
                p_sub.font.color.rgb = SLATE
                p_sub.space_before = Pt(4)

                # Khối ảnh 2 (Phải)
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
                p.font.size = Pt(13)
                p.font.bold = True
                p.font.color.rgb = BRAND_BLUE

                p_sub = tf2.add_paragraph()
                p_sub.text = data["img2_desc"]
                p_sub.font.size = Pt(10.5)
                p_sub.font.color.rgb = SLATE
                p_sub.space_before = Pt(4)

            # ==========================================
            # LAYOUT: FOUR CARDS (LƯỚI 2x2 ĐỒNG ĐỀU)
            # ==========================================
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
                    p_head.font.size = Pt(15)
                    p_head.font.bold = True
                    p_head.font.color.rgb = color

                    p_body = tf.add_paragraph()
                    p_body.text = cdesc
                    p_body.font.size = Pt(12)
                    p_body.font.color.rgb = NAVY
                    p_body.space_before = Pt(8)

            # ==========================================
            # LAYOUT: THREE COLUMNS (3 CỘT CÔNG NGHỆ)
            # ==========================================
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

                    # Top accent bar của cột
                    bar = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, x, Inches(1.6), w, Inches(0.5))
                    bar.fill.solid()
                    bar.fill.fore_color.rgb = col_color
                    bar.line.fill.background()
                    tf = bar.text_frame
                    p = tf.paragraphs[0]
                    p.text = col_title
                    p.font.size = Pt(13.5)
                    p.font.bold = True
                    p.font.color.rgb = WHITE
                    p.alignment = PP_ALIGN.CENTER

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
                        p1.font.size = Pt(12)
                        p1.font.bold = True
                        p1.font.color.rgb = col_color

                        p2 = tf.add_paragraph()
                        p2.text = item_detail
                        p2.font.size = Pt(10.5)
                        p2.font.color.rgb = NAVY
                        p2.space_before = Pt(3)

                        cur_item_y += Inches(1.48)

            # ==========================================
            # LAYOUT: TWO COLUMNS (2 CỘT TỔNG KẾT)
            # ==========================================
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
                p.font.size = Pt(14)
                p.font.bold = True
                p.font.color.rgb = WHITE
                p.alignment = PP_ALIGN.CENTER

                tx1 = slide.shapes.add_textbox(Inches(1.0), Inches(2.3), w - Inches(0.4), h - Inches(0.8))
                tf1 = tx1.text_frame
                tf1.word_wrap = True
                for b_idx, bullet in enumerate(data["col1_bullets"]):
                    p = tf1.paragraphs[0] if b_idx == 0 else tf1.add_paragraph()
                    p.text = "✓ " + bullet
                    p.font.size = Pt(12.5)
                    p.font.color.rgb = NAVY
                    p.space_before = Pt(10)

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
                p.font.size = Pt(14)
                p.font.bold = True
                p.font.color.rgb = WHITE
                p.alignment = PP_ALIGN.CENTER

                tx2 = slide.shapes.add_textbox(Inches(7.0), Inches(2.3), w - Inches(0.4), h - Inches(0.8))
                tf2 = tx2.text_frame
                tf2.word_wrap = True
                for b_idx, bullet in enumerate(data["col2_bullets"]):
                    p = tf2.paragraphs[0] if b_idx == 0 else tf2.add_paragraph()
                    p.text = "★ " + bullet
                    p.font.size = Pt(12.5)
                    p.font.color.rgb = NAVY
                    p.space_before = Pt(12)

            # ==========================================
            # LAYOUT: TABLE (BẢNG KIỂM THỬ)
            # ==========================================
            elif data["type"] == "table":
                rows = len(data["rows"]) + 1
                cols = len(data["headers"])
                table_shape = slide.shapes.add_table(rows, cols, Inches(0.8), Inches(1.6), Inches(11.733), Inches(5.1))
                table = table_shape.table

                # Độ rộng từng cột
                table.columns[0].width = Inches(1.4)
                table.columns[1].width = Inches(3.8)
                table.columns[2].width = Inches(4.7)
                table.columns[3].width = Inches(1.833)

                # Header row
                for c_idx, head_text in enumerate(data["headers"]):
                    cell = table.cell(0, c_idx)
                    cell.text = head_text
                    cell.fill.solid()
                    cell.fill.fore_color.rgb = BRAND_BLUE
                    for p in cell.text_frame.paragraphs:
                        p.font.size = Pt(12)
                        p.font.bold = True
                        p.font.color.rgb = WHITE
                        p.alignment = PP_ALIGN.CENTER

                # Data rows
                for r_idx, row_data in enumerate(data["rows"]):
                    for c_idx, val in enumerate(row_data):
                        cell = table.cell(r_idx + 1, c_idx)
                        cell.text = val
                        cell.fill.solid()
                        cell.fill.fore_color.rgb = WHITE if r_idx % 2 == 0 else RGBColor(241, 245, 249)
                        for p in cell.text_frame.paragraphs:
                            p.font.size = Pt(11)
                            p.font.color.rgb = NAVY
                            if c_idx == 0:
                                p.font.bold = True
                                p.alignment = PP_ALIGN.CENTER
                            elif c_idx == 3:
                                p.font.bold = True
                                p.font.color.rgb = GREEN
                                p.alignment = PP_ALIGN.CENTER

            # ==========================================
            # LAYOUT: KPI METRICS + TABLE (ĐÁNH GIÁ ĐỊNH LƯỢNG)
            # ==========================================
            elif data["type"] == "kpi_metrics_table":
                # 3 Thẻ KPI số liệu ở trên
                kpi_w = Inches(3.7)
                kpi_h = Inches(1.3)
                kpi_xs = [Inches(0.8), Inches(4.82), Inches(8.84)]

                for kx, (k_val, k_title, k_desc, k_col) in zip(kpi_xs, data["kpis"]):
                    k_card = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, kx, Inches(1.6), kpi_w, kpi_h)
                    k_card.fill.solid()
                    k_card.fill.fore_color.rgb = WHITE
                    k_card.line.color.rgb = CARD_BORDER
                    k_card.line.width = Pt(1)

                    # Top accent bar
                    k_bar = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, kx, Inches(1.6), kpi_w, Inches(0.08))
                    k_bar.fill.solid()
                    k_bar.fill.fore_color.rgb = k_col
                    k_bar.line.fill.background()

                    tx = slide.shapes.add_textbox(kx + Inches(0.15), Inches(1.72), kpi_w - Inches(0.3), kpi_h - Inches(0.2))
                    tf = tx.text_frame
                    tf.word_wrap = True
                    p_val = tf.paragraphs[0]
                    p_val.text = k_val
                    p_val.font.size = Pt(20)
                    p_val.font.bold = True
                    p_val.font.color.rgb = k_col
                    p_val.alignment = PP_ALIGN.CENTER

                    p_tit = tf.add_paragraph()
                    p_tit.text = k_title
                    p_tit.font.size = Pt(11)
                    p_tit.font.bold = True
                    p_tit.font.color.rgb = NAVY
                    p_tit.alignment = PP_ALIGN.CENTER

                    p_d = tf.add_paragraph()
                    p_d.text = k_desc
                    p_d.font.size = Pt(9.5)
                    p_d.font.color.rgb = SLATE
                    p_d.alignment = PP_ALIGN.CENTER

                # Bảng chi tiết so sánh ở dưới
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
                        p.font.size = Pt(11.5)
                        p.font.bold = True
                        p.font.color.rgb = WHITE
                        p.alignment = PP_ALIGN.CENTER

                for r_idx, row_data in enumerate(data["rows"]):
                    for c_idx, val in enumerate(row_data):
                        cell = table.cell(r_idx + 1, c_idx)
                        cell.text = val
                        cell.fill.solid()
                        cell.fill.fore_color.rgb = WHITE if r_idx % 2 == 0 else RGBColor(241, 245, 249)
                        for p in cell.text_frame.paragraphs:
                            p.font.size = Pt(10.5)
                            p.font.color.rgb = NAVY
                            if c_idx in [1, 2]:
                                p.font.bold = True
                                p.alignment = PP_ALIGN.CENTER
                                if "⭐" in val or "0,21" in val or "98," in val or "100%" in val:
                                    p.font.color.rgb = GREEN

    output_path = "FoodAI_Slide_Thuyet_Trinh_20_Slides.pptx"
    prs.save(output_path)
    print(f"✅ Đã tạo thành công file PowerPoint 20 slides chất lượng cao: {output_path}")

if __name__ == "__main__":
    create_presentation()
