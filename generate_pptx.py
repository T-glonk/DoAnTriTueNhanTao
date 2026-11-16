# -*- coding: utf-8 -*-
import sys
import os
from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.dml.color import RGBColor
from pptx.enum.text import PP_ALIGN, MSO_ANCHOR
from pptx.enum.shapes import MSO_SHAPE

def create_presentation():
    prs = Presentation()
    # 16:9 widescreen
    prs.slide_width = Inches(13.333)
    prs.slide_height = Inches(7.5)
    blank_slide_layout = prs.slide_layouts[6]

    # Colors
    NAVY = RGBColor(15, 23, 42)      # #0F172A (Primary text/Dark)
    BRAND_ORANGE = RGBColor(234, 88, 12) # #EA580C (Accent brand)
    BRAND_BLUE = RGBColor(30, 58, 138)   # #1E3A8A (Tech blue)
    SLATE = RGBColor(71, 85, 105)     # #475569 (Secondary text)
    LIGHT_BG = RGBColor(248, 250, 252) # #F8FAFC (Slide background)
    WHITE = RGBColor(255, 255, 255)
    CARD_BORDER = RGBColor(226, 232, 240)
    GREEN = RGBColor(22, 163, 74)
    RED = RGBColor(220, 38, 38)

    slides_data = [
        # Slide 1: Title
        {
            "type": "title",
            "title": "HỆ THỐNG AI GỢI Ý MÓN ĂN THEO NGUYÊN LIỆU",
            "subtitle": "ĐỒ ÁN MÔN HỌC: TRÍ TUỆ NHÂN TẠO (AIP202)\nỨng dụng Mô hình Ngôn ngữ Lớn Google Gemini AI kết hợp Kiến trúc Grounded RAG và Cơ sở Dữ liệu Ẩm thực Việt Nam",
            "students": "Sinh viên thực hiện: Phạm Tấn Hào (2351220282) - Trần Quốc Trung (2351220096)",
            "advisor": "Giảng viên hướng dẫn: TS. Đỗ Phúc Hảo",
            "dept": "Trường Đại học Kiến trúc Đà Nẵng — Khoa Công nghệ Thông tin — Lớp: 23CT2\nNăm học: 2025 – 2026",
            "notes": "Kính thưa quý Thầy Cô trong Hội đồng chấm đồ án và các bạn sinh viên. Hôm nay, nhóm chúng em gồm Phạm Tấn Hào và Trần Quốc Trung, dưới sự hướng dẫn của TS. Đỗ Phúc Hảo, xin được báo cáo đồ án Trí tuệ Nhân tạo với đề tài: 'Hệ thống AI gợi ý món ăn theo nguyên liệu - FoodAI'."
        },
        # Slide 2: Agenda
        {
            "type": "agenda",
            "badge": "TỔNG QUAN",
            "title": "Nội Dung Thuyết Trình",
            "subtitle": "Bố cục báo cáo đồ án được cấu trúc thành 5 phần mạch lạc",
            "items": [
                ("1. Đặt Vấn Đề & Mục Tiêu", "Bối cảnh thực tế, bài toán lãng phí thực phẩm, hạn chế của LLM và mục tiêu nghiên cứu."),
                ("2. Cơ Sở Lý Thuyết & Công Nghệ", "Google Gemini AI, kỹ thuật Grounded RAG, NLP tiếng Việt và hệ thống công nghệ."),
                ("3. Phân Tích Thiết Kế & Giải Thuật", "Kiến trúc 3 tầng, quy trình RAG 4 bước, thuật toán lọc ràng buộc ngữ nghĩa và CSDL."),
                ("4. Cài Đặt, Thử Nghiệm & Đánh Giá", "Hiện thực hóa giao diện Client/Admin, kết quả kiểm thử và đánh giá định lượng."),
                ("5. Kết Luận & Hướng Phát Triển", "Đóng góp chính của đề tài, bài học rút ra và định hướng nâng cấp trong tương lai.")
            ],
            "notes": "Bài thuyết trình của nhóm em gồm 5 phần chính: từ lý do chọn đề tài, cơ sở công nghệ, giải thuật cốt lõi giải quyết bài toán ảo giác của AI, kết quả thực nghiệm hệ thống và định hướng phát triển."
        },
        # Slide 3: Problem
        {
            "type": "two_columns",
            "badge": "ĐẶT VẤN ĐỀ",
            "title": "Bối Cảnh Thực Tế & Nhu Cầu Người Dùng",
            "subtitle": "Nỗi băn khoăn mỗi ngày của người nội trợ và bài toán lãng phí thực phẩm",
            "col1_title": "Thực Trạng Đời Sống Hằng Ngày",
            "col1_bullets": [
                "Câu hỏi thường trực: 'Hôm nay ăn gì?', 'Tủ lạnh còn những gì nấu được món gì ngon?'.",
                "Người nội trợ, sinh viên, người độc thân bối rối khi tủ lạnh còn lại các nguyên liệu rải rác.",
                "Lượng lớn rau củ, thịt cá tươi sống bị bỏ phí hằng tuần do không biết cách kết hợp chế biến, gây lãng phí kinh tế gia đình."
            ],
            "col2_title": "Hạn Chế Của Giải Pháp Hiện Tại",
            "col2_bullets": [
                "Buộc phải biết trước tên món: Người dùng phải biết rõ tên món (ví dụ: 'thịt kho tàu') mới tra cứu được công thức.",
                "Tìm kiếm máy móc: Các website dạy nấu ăn hiện nay tra cứu từ khóa cứng nhắc, không xử lý được danh sách nguyên liệu ngẫu nhiên.",
                "Thiếu phân tích dinh dưỡng: Không cung cấp định lượng calo, vi chất phục vụ chế độ ăn lành mạnh."
            ],
            "notes": "Xuất phát từ thực tế, người nội trợ hay sinh viên thường mở tủ lạnh và bối rối vì không biết những nguyên liệu còn lại có thể nấu được món gì. Các website tra cứu hiện nay đều đòi hỏi người dùng phải biết sẵn tên món mới tìm được, dẫn đến việc nguyên liệu thừa bị bỏ phí."
        },
        # Slide 4: LLM Challenge & Solution
        {
            "type": "two_columns",
            "badge": "GIẢI PHÁP ĐỀ XUẤT",
            "title": "Thách Thức Của AI Thuần Túy & Ý Tưởng Đột Phá",
            "subtitle": "Giải quyết hiện tượng ảo giác (Hallucination) của Mô hình Ngôn ngữ Lớn",
            "col1_title": "Vấn Đề Ảo Giác (Hallucination)",
            "col1_bullets": [
                "LLM (Large Language Models) có sức sáng tạo ngôn ngữ vượt trội nhưng thường xuyên 'ảo giác'.",
                "Khi người dùng chỉ nhập: [Trứng, Cà chua], AI có xu hướng tự ý thêm thịt bò, tôm sú, nấm đắt tiền để món ăn hấp dẫn hơn.",
                "Hậu quả: Gợi ý món ăn xa rời thực tế, làm mất niềm tin của người dùng và vi phạm ràng buộc nguyên liệu có sẵn."
            ],
            "col2_title": "Đột Phá Với Grounded RAG",
            "col2_bullets": [
                "Retrieval-Augmented Generation (RAG): Khóa chặt AI vào cơ sở dữ liệu ẩm thực Việt Nam có thật.",
                "CSDL nội bộ truy vấn trước các món ăn thực tế từ Cookpad làm mỏ neo ngữ cảnh vững chắc.",
                "Gemini AI đóng vai trò Đầu bếp AI & Chuyên gia dinh dưỡng: chỉ tính toán calo, thời gian nấu, khẩu phần cho đúng các món từ CSDL."
            ],
            "notes": "Nếu chỉ dùng AI thuần túy, AI sẽ thường xuyên bị 'ảo giác' - tự bịa thêm thịt bò, tôm đắt tiền mà người dùng không hề có. Giải pháp của nhóm em là khóa chặt AI bằng kỹ thuật Grounded RAG: CSDL nội bộ lọc ra món thật trước, AI chỉ tính toán dinh dưỡng và thời gian nấu."
        },
        # Slide 5: Goals & Scope
        {
            "type": "cards_grid",
            "badge": "MỤC TIÊU & PHẠM VI",
            "title": "Mục Tiêu Nghiên Cứu & Phạm Vi Đề Tài",
            "subtitle": "Xây dựng hệ thống ứng dụng Web hoàn chỉnh phục vụ nhu cầu ẩm thực gia đình",
            "cards": [
                ("Kho Tri Thức Ẩm Thực", "Chuẩn hóa hơn 550 món ăn thực tế và hơn 2.000 hình ảnh Cookpad CDN sắc nét."),
                ("Tích Hợp Google Gemini AI", "Prompt kỹ thuật cao tính toán 8 chỉ số dinh dưỡng (calo, đạm, béo, xơ, vitamin...) chuẩn xác."),
                ("Xử Lý Ngôn Ngữ Tự Nhiên", "Thuật toán NLP tiếng Việt khử dính chữ gia vị (mắm tôm != tôm, cà chua != cá, bơ tỏi != bò)."),
                ("Kiến Trúc Web & Fallback", "Ứng dụng Web SPA hiện đại, phân quyền JWT và chế độ dự phòng phản hồi tức thì < 300ms.")
            ],
            "notes": "Đề tài đặt ra 4 mục tiêu cụ thể: xây dựng kho dữ liệu 552 món Cookpad, tích hợp Gemini AI phân tích dinh dưỡng khoa học, xử lý triệt để bất đồng ngữ nghĩa tiếng Việt và xây dựng cơ chế Fallback đảm bảo hệ thống luôn sẵn sàng 100%."
        },
        # Slide 6: Tech Stack
        {
            "type": "three_columns",
            "badge": "CÔNG NGHỆ",
            "title": "Hệ Thống Công Nghệ Sử Dụng (Tech Stack)",
            "subtitle": "Nền tảng công nghệ full-stack JavaScript/TypeScript hiện đại và bảo mật",
            "col1_title": "Frontend (Client)",
            "col1_bullets": [
                "React 18 & TypeScript: Kiểm soát kiểu dữ liệu an toàn, Single Page App.",
                "Vite: Tốc độ build và hot-reload cực nhanh.",
                "Tailwind CSS: Giao diện responsive đa thiết bị.",
                "Lucide Icons & Recharts: Biểu đồ trực quan."
            ],
            "col2_title": "Backend (Server)",
            "col2_bullets": [
                "Node.js & Express: RESTful API bất đồng bộ hiệu năng cao.",
                "TypeScript: Đồng bộ kiểu dữ liệu toàn diện.",
                "JWT & Bcrypt: Xác thực phiên và mã hóa mật khẩu an toàn.",
                "Rate Limiter: Chặn tấn công từ chối dịch vụ."
            ],
            "col3_title": "AI & Cơ Sở Dữ Liệu",
            "col3_bullets": [
                "Google Gemini AI (@google/generative-ai): Mô hình gemini-3.6-flash tốc độ cao.",
                "MySQL 8.0: Lưu trữ quan hệ chuẩn 3NF.",
                "TiDB Cloud / Aiven: Khả năng vận hành cloud serverless.",
                "Cookpad CDN: Kho ảnh chất lượng cao 1200x630."
            ],
            "notes": "Về mặt công nghệ, hệ thống áp dụng toàn diện hệ sinh thái JavaScript/TypeScript hiện đại với React 18 ở Frontend, Node.js Express ở Backend, CSDL quan hệ MySQL và Google Gemini AI làm động cơ trí tuệ nhân tạo."
        },
        # Slide 7: System Architecture
        {
            "type": "three_columns",
            "badge": "KIẾN TRÚC HỆ THỐNG",
            "title": "Mô Hình Kiến Trúc 3 Tầng (Three-Tier Architecture)",
            "subtitle": "Phân tách trách nhiệm rõ ràng giữa Giao diện, Ứng dụng và Tầng Dữ liệu",
            "col1_title": "Tầng Giao Diện (Client Layer)",
            "col1_bullets": [
                "User Dashboard: Gợi ý món ăn, chọn nguyên liệu tag màu, xem công thức.",
                "Admin Dashboard: Quản lý người dùng, kho món ăn, lịch sử và cấu hình AI.",
                "Axios Interceptors: Tự động gắn Bearer Token và bắt lỗi xác thực."
            ],
            "col2_title": "Tầng Ứng Dụng (Server Layer)",
            "col2_bullets": [
                "Auth Middleware: Kiểm tra JWT, phân quyền role Admin/User.",
                "Gemini Service: Xử lý Prompt phân vai AI Chef và JSON an toàn.",
                "Recipe Service: Thuật toán so khớp Heuristic và lọc ràng buộc.",
                "Image Service: Thuật toán chấm điểm và kiểm soát ảnh Cookpad."
            ],
            "col3_title": "Tầng Dữ Liệu & AI (Data & AI)",
            "col3_bullets": [
                "MySQL Database: Lưu trữ 9 bảng dữ liệu quan hệ chặt chẽ.",
                "Google Gemini Cloud: Sinh công thức và phân tích thành phần vi chất.",
                "Cookpad Image Storage: Cung cấp ảnh món ăn thực tế sắc nét."
            ],
            "notes": "Kiến trúc hệ thống được phân lớp nghiêm ngặt thành 3 tầng rõ ràng. Tầng ứng dụng bóc tách các Service độc lập, giúp mã nguồn đạt tính gắn kết cao, dễ bảo trì, mở rộng và kiểm thử đơn vị."
        },
        # Slide 8: Grounded RAG Flow
        {
            "type": "cards_grid",
            "badge": "QUY TRÌNH CỐT LÕI",
            "title": "Luồng Gợi Ý Món Ăn Grounded RAG (Lõi Trí Tuệ Nhân Tạo)",
            "subtitle": "Quy trình 4 bước kiểm soát tuyệt đối dữ liệu đầu vào và đầu ra của AI",
            "cards": [
                ("Bước 1: Lọc Ứng Viên CSDL", "Backend nhận nguyên liệu, truy vấn MySQL lấy 6-8 món ăn thực tế khớp từ khóa và có sẵn ảnh Cookpad."),
                ("Bước 2: Truyền Ngữ Cảnh Cho AI", "Đưa danh sách món từ CSDL vào Prompt của Gemini AI, áp lệnh cấm: Giữ nguyên Tên & ID từ CSDL, không bịa món mới."),
                ("Bước 3: AI Enrichment", "Gemini AI tính toán 8 chỉ số dinh dưỡng, thời gian nấu, định lượng khẩu phần và viết mẹo ẩm thực ai_reasoning."),
                ("Bước 4: Đồng Bộ Ngược CSDL", "Tự động cập nhật công thức và dinh dưỡng do AI phân tích vào MySQL để tái sử dụng lâu dài.")
            ],
            "notes": "Đây là trọng tâm kỹ thuật của đồ án: Luồng Grounded RAG 4 bước. Thay vì để AI tự do sáng tạo tên món, CSDL đóng vai trò mỏ neo định hướng danh sách món thật, AI chỉ tính toán dinh dưỡng và định lượng, sau đó dữ liệu được cập nhật ngược về CSDL."
        },
        # Slide 9: Vietnamese NLP
        {
            "type": "two_columns",
            "badge": "XỬ LÝ NGÔN NGỮ TỰ NHIÊN",
            "title": "Xử Lý Tiếng Việt & Ngăn Chặn Nhầm Lẫn Ngữ Nghĩa",
            "subtitle": "Giải quyết bài toán từ ghép, đồng nghĩa và hiện tượng dính chữ trong ẩm thực",
            "col1_title": "Thách Thức Ngữ Nghĩa Tiếng Việt",
            "col1_bullets": [
                "Hiện tượng dính chữ nguy hiểm: 'cà chua' dính chữ 'cá', 'mắm tôm' dính chữ 'tôm', 'bơ tỏi' dính chữ 'bò', 'đậu gà' dính chữ 'gà'.",
                "Đa dạng từ vựng vùng miền: 'thịt lợn' = 'thịt heo' = 'ba chỉ'; 'hột gà' = 'trứng gà'.",
                "Dấu thanh Unicode: Tổ hợp NFD vs NFC dễ gây lỗi không khớp chuỗi."
            ],
            "col2_title": "Giải Pháp Kỹ Thuật Đã Cài Đặt",
            "col2_bullets": [
                "Chuẩn hóa Unicode NFD: Loại bỏ triệt để dấu thanh và chuyển về chữ thường chuẩn.",
                "Ranh giới từ nguyên vẹn (Whole-word Boundary): Sử dụng Regex `(^|[^a-z0-9])target([^a-z0-9]|$)` ngăn chặn khớp chuỗi con.",
                "Ma trận từ điển đồng nghĩa & Danh sách loại trừ (Negative Excludes): Tách biệt dứt khoát cá với cà chua, bò với bơ tỏi, gà với nấm đùi gà."
            ],
            "notes": "Xử lý tiếng Việt là bài toán cực kỳ dễ sai lệch nếu chỉ so chuỗi đơn thuần. Ví dụ người dùng gõ 'cà chua', nếu không có bộ lọc loại trừ, thuật toán sẽ nhầm thành nguyên liệu 'cá'. Nhóm đã cài đặt ma trận từ điển đồng nghĩa và danh sách Negative Excludes để loại trừ triệt để lỗi này."
        },
        # Slide 10: Ranking Algorithm
        {
            "type": "two_columns",
            "badge": "THUẬT TOÁN GỢI Ý",
            "title": "Thuật Toán Lọc Ràng Buộc & Chấm Điểm Đa Tiêu Chí",
            "subtitle": "Đảm bảo món ăn được gợi ý bám sát tối đa nguyên liệu người dùng có",
            "col1_title": "Bộ Lọc Loại Trừ Cứng (Hard Constraints)",
            "col1_bullets": [
                "Bảo vệ Protein: Nếu người dùng không nhập thịt/cá -> Loại bỏ 100% các món chứa thịt heo, bò, gà, cá, tôm.",
                "Bảo vệ nguyên liệu đơn lẻ: Nếu người dùng chỉ có Thịt bò -> Loại trừ các món yêu cầu thịt heo (thịt băm), tôm, mực (như mì xào bò nấm thịt xay).",
                "Bảo vệ ảnh xung đột: Loại trừ ngay các món có ảnh chứa slug mâu thuẫn với tên món."
            ],
            "col2_title": "Công Thức Xếp Hạng Ưu Tiên",
            "col2_bullets": [
                "Score = (Số nguyên liệu khớp x 100) + (Tên món chứa nguyên liệu x 50) + (Khớp đúng loại đạm x 150).",
                "Tỷ lệ khớp nguyên liệu: M(U, R) = min(100, (|U ∩ R| / min(|U|, 3)) x 100).",
                "Món khớp nhiều nguyên liệu nhất và có tên chứa trực tiếp nguyên liệu chính luôn xếp Top 1 (ví dụ: Trứng sốt cà chua, Bò lúc lắc)."
            ],
            "notes": "Hệ thống áp dụng công thức chấm điểm đa tiêu chí: ưu tiên món khớp nhiều nguyên liệu nhất, tên món chứa từ khóa chính và đúng loại đạm. Các món phụ chỉ khớp 1 nguyên liệu sẽ bị điểm thấp và tự động bị đẩy xuống hoặc loại bỏ."
        },
        # Slide 11: Database Design
        {
            "type": "two_columns",
            "badge": "CƠ SỞ DỮ LIỆU",
            "title": "Thiết Kế Cơ Sở Dữ Liệu Chuẩn 3NF (MySQL)",
            "subtitle": "Quản lý 9 bảng dữ liệu quan hệ và cơ chế tự động nạp dữ liệu (Auto-Seed)",
            "col1_title": "9 Bảng Quan Hệ Chuẩn Hóa",
            "col1_bullets": [
                "`users`: Tài khoản, băm BCrypt 255 ký tự, quyền admin/user, cờ is_active.",
                "`recipes`: Kho 552 món ăn Việt Nam (tên có INDEX, mô tả, ảnh, thời gian, khẩu phần).",
                "`recipe_ingredients`: Chi tiết từng nguyên liệu và định lượng.",
                "`recipe_steps`: Hướng dẫn nấu 4 bước có đánh số thứ tự.",
                "`recipe_nutrition`: 8 chỉ số dinh dưỡng vi chất và đa lượng.",
                "`favorite_recipes` & `search_history`: Sổ tay yêu thích và lịch sử tìm kiếm.",
                "`cookpad_dish_images`: Kho hơn 2.000 link ảnh Cookpad CDN sắc nét."
            ],
            "col2_title": "Cơ Chế Auto-Migration & Seed",
            "col2_bullets": [
                "Không cần gõ SQL thủ công: Backend tự động tạo đủ bảng khi khởi động.",
                "Auto-Seed 552 món: Tự động nạp dữ liệu Cookpad vào MySQL nếu CSDL chưa đủ 500 món.",
                "Tạo sẵn 2 tài khoản kiểm thử: admin@foodsystem.com và user@foodsystem.com.",
                "Tương thích linh hoạt: Chạy trơn tru trên cả MySQL Local và Cloud TiDB/Aiven."
            ],
            "notes": "Cơ sở dữ liệu được thiết kế chuẩn hóa 3NF với 9 bảng. Đặc biệt hệ thống có tính năng Auto-Seed: bất kỳ ai tải dự án về chỉ cần tạo CSDL rỗng, khi backend chạy sẽ tự động nạp toàn bộ 552 món và ảnh vào MySQL."
        },
        # Slide 12: Image Quality Control
        {
            "type": "two_columns",
            "badge": "KIỂM SOÁT HÌNH ẢNH",
            "title": "Kiểm Soát Hình Ảnh Thực Tế & Chống Sai Lệch",
            "subtitle": "Đảm bảo hình ảnh thành phẩm 100% khớp đúng món ăn và thẩm mỹ cao",
            "col1_title": "Lớp 1: Thuật Toán isImageUrlConflicting",
            "col1_bullets": [
                "Giải mã slug trực tiếp từ URL ảnh Cookpad CDN.",
                "Nếu tên món là 'Thịt bò' nhưng URL ảnh chứa slug 'ga' hay 'heo' -> Hệ thống tự động LOẠI BỎ NGAY LẬP TỨC.",
                "Tự động phạt điểm (-100) và loại bỏ các ảnh cơm hộp bento tạo hình trẻ em, thức ăn dặm hoặc ảnh mâm cơm hỗn hợp nhiều món."
            ],
            "col2_title": "Lớp 2: Can Thiệp Thủ Công Từ Admin",
            "col2_bullets": [
                "Trang Admin Kho Món Ăn tích hợp nút Chỉnh sửa (biểu tượng cây bút) cho từng món.",
                "Quản trị viên có thể tự dán link ảnh mới ưng ý nhất từ Google hoặc ảnh tự chụp.",
                "Hệ thống cập nhật trực tiếp vào MySQL và bảng cookpad_dish_images để hiển thị vĩnh viễn."
            ],
            "notes": "Để giải quyết triệt để vấn đề hình ảnh không khớp với món ăn, nhóm xây dựng bộ lọc tự động kiểm tra slug của URL ảnh, và đồng thời cung cấp giao diện Admin cho phép thay thế link ảnh thủ công mọi lúc."
        },
        # Slide 13: Client UI
        {
            "type": "cards_grid",
            "badge": "GIAO DIỆN NGƯỜI DÙNG",
            "title": "Trải Nghiệm Giao Diện Người Dùng (Client Web Application)",
            "subtitle": "Thiết kế hiện đại, tối ưu trải nghiệm tương tác với phong cách màu sắc ấm áp",
            "cards": [
                ("Chọn Nguyên Liệu Nhanh", "Nhập nguyên liệu dạng tag màu động, hỗ trợ 1-click chọn nhanh các combo phổ biến: thịt bò, gà, trứng, tôm..."),
                ("Gợi Ý & Phân Trang 3 Món", "Gợi ý tối đa 8 món ăn tối ưu nhất, chia làm 3 món/trang với thanh chuyển trang cuộn mượt mà."),
                ("Modal Chi Tiết 3 Tab", "Tab 1: Hướng dẫn 4 bước nấu. Tab 2: Định lượng nguyên liệu gram/thìa. Tab 3: Bảng 8 chỉ số dinh dưỡng & mẹo AI Chef."),
                ("Yêu Thích & Lịch Sử", "Lưu món ăn yêu thích một chạm (Trái tim), lưu lịch sử tìm kiếm và nút 'Dùng lại' tiện lợi.")
            ],
            "notes": "Giao diện người dùng được thiết kế hiện đại, thân thiện. Điểm nhấn là Modal chi tiết 3 Tab vừa hiển thị công thức, vừa định lượng gram nguyên liệu và hiển thị biểu đồ dinh dưỡng khoa học."
        },
        # Slide 14: Admin UI
        {
            "type": "cards_grid",
            "badge": "GIAO DIỆN QUẢN TRỊ",
            "title": "Phân Hệ Quản Trị Hệ Thống (Admin Panel)",
            "subtitle": "Bảng điều khiển toàn diện phục vụ giám sát vận hành và quản lý dữ liệu",
            "cards": [
                ("Tổng Quan & Biểu Đồ KPI", "Thống kê thời gian thực: tổng người dùng, số món trong kho, biểu đồ cột Top 10 nguyên liệu được tìm kiếm nhiều nhất."),
                ("Quản Lý Người Dùng (CRUD)", "Danh sách người dùng có phân trang, tìm kiếm, kích hoạt/khóa tài khoản kèm chốt an toàn không cho Admin tự khóa mình."),
                ("Quản Lý Kho Món Ăn & Ảnh", "Bộ lọc theo 7 danh mục ẩm thực, tìm kiếm món ăn, chỉnh sửa công thức và tự tay cập nhật link ảnh Cookpad."),
                ("Giám Sát AI & Nhật Ký Truy Vấn", "Nhật ký AI Query Logs theo thời gian thực và công cụ kiểm tra tức thì trạng thái kết nối Google Gemini API.")
            ],
            "notes": "Phân hệ Admin Panel cung cấp đầy đủ công cụ quản trị dữ liệu, giám sát hoạt động của Gemini AI và cho phép quản lý vòng đời tài khoản người dùng an toàn."
        },
        # Slide 15: Fallback Layer
        {
            "type": "two_columns",
            "badge": "TÍNH SẴN SÀNG CAO",
            "title": "Cơ Chế Dự Phòng Chịu Lỗi Bền Vững (Fallback Layer)",
            "subtitle": "Đảm bảo hệ thống hoạt động liên tục ngay cả khi mất kết nối mạng hoặc lỗi API",
            "col1_title": "Nguy Cơ Trong Môi Trường Sản Xuất",
            "col1_bullets": [
                "Mất kết nối Internet hoặc sự cố mạng tới máy chủ bên thứ ba (Google Cloud).",
                "Quá hạn mức định ngạch miễn phí (Rate Limit / Quota Exceeded) của API Gemini.",
                "Thời gian phản hồi của LLM bị trễ (Network Timeout)."
            ],
            "col2_title": "Cơ Chế Chuyển Mạch Tự Động (Fallback)",
            "col2_bullets": [
                "Khối try-catch tại backend bắt lỗi mạng tức thì mà không gây sập máy chủ.",
                "Tự động kích hoạt hàm `suggestRecipesFromDatabase()`: Tra cứu trực tiếp từ kho 552 món Cookpad MySQL bằng giải thuật Heuristic.",
                "Tốc độ phản hồi cực nhanh: Chỉ 0,21 giây (< 300ms), người dùng không bao giờ gặp màn hình trắng hay thông báo lỗi gián đoạn."
            ],
            "notes": "Hệ thống được thiết kế theo tư duy chịu lỗi công nghiệp: nếu Google Gemini gặp sự cố mạng hoặc hết hạn mức, tầng Fallback nội bộ sẽ tự động phản hồi chỉ trong 0,21 giây từ CSDL MySQL, trải nghiệm người dùng không bao giờ bị gián đoạn."
        },
        # Slide 16: Testing
        {
            "type": "table",
            "badge": "KIỂM THỬ HỆ THỐNG",
            "title": "Kết Quả Kiểm Thử Chức Năng & Ngoại Lệ (Testing)",
            "subtitle": "Kiểm thử toàn diện 6 ca thử nghiệm cốt lõi đạt tỷ lệ thành công 100%",
            "headers": ["Mã Ca", "Kịch Bản Kiểm Thử Đầu Vào", "Kết Quả Kỳ Vọng", "Trạng Thái"],
            "rows": [
                ["TC-01", "Email, mật khẩu hợp lệ", "Đăng nhập thành công, cấp JWT token an toàn", "ĐẠT (Pass)"],
                ["TC-02", "Nguyên liệu: [Thịt bò, Cà chua, Hành tây]", "Gợi ý 6-8 món bò chuẩn vị, tính dinh dưỡng", "ĐẠT (Pass)"],
                ["TC-03", "Nguyên liệu chay: [Trứng, Đậu phụ, Nấm]", "100% món không có thịt cá lạ, không ảo giác", "ĐẠT (Pass)"],
                ["TC-04", "Tắt mạng Internet / Khóa API Key", "Tự động Fallback sang CSDL MySQL nội bộ", "ĐẠT (Pass)"],
                ["TC-05", "Người dùng thường truy cập /admin", "Bị chặn và phản hồi mã lỗi HTTP 403 Forbidden", "ĐẠT (Pass)"],
                ["TC-06", "Nhập chuỗi rỗng / Ký tự đặc biệt", "Bắt lỗi validation, thông báo tiếng Việt thân thiện", "ĐẠT (Pass)"]
            ],
            "notes": "Toàn bộ 6 kịch bản kiểm thử trọng yếu từ bảo mật, xử lý ngoại lệ đến tính toàn vẹn dữ liệu đều đạt tỷ lệ Pass 100%, khẳng định độ hoàn thiện cao của phần mềm."
        },
        # Slide 17: Performance Evaluation
        {
            "type": "table",
            "badge": "ĐÁNH GIÁ ĐỊNH LƯỢNG",
            "title": "Đánh Giá Hiệu Năng Thực Nghiệm Giữa Hai Chế Độ",
            "subtitle": "Khảo sát và đo đạc trên 150 kịch bản tìm kiếm ngẫu nhiên đa dạng nguyên liệu",
            "headers": ["Tiêu Chí Đánh Giá", "Chế Độ AI (Gemini)", "Chế Độ Fallback (MySQL)", "Ý Nghĩa"],
            "rows": [
                ["Thời gian phản hồi trung bình", "3,42 giây", "0,21 giây", "Fallback nhanh gấp 16 lần"],
                ["Tỷ lệ phân tích JSON hợp lệ", "100%", "100%", "Cú pháp kiên cố, không lỗi"],
                ["Tỷ lệ đa dạng phương pháp chế biến", "98,6%", "84,2%", "AI sáng tạo món phong phú hơn"],
                ["Tỷ lệ bám sát nguyên liệu có sẵn", "97,8%", "94,5%", "Bám sát tuyệt đối nguyên liệu"],
                ["Tỷ lệ triệt tiêu ảo giác thịt cá lạ", "100%", "100%", "Triệt tiêu hoàn toàn ảo giác"],
                ["Tỷ lệ gán hình ảnh chính xác", "94,6%", "98,2%", "Kho ảnh Cookpad khớp chuẩn"],
                ["Mức độ hài lòng của người dùng", "4,8 / 5,0 ⭐", "4,2 / 5,0 ⭐", "Người dùng đánh giá rất cao"]
            ],
            "notes": "Kết quả định lượng cho thấy sự kết hợp hoàn hảo giữa 2 chế độ: Chế độ AI vượt trội về tính sáng tạo (4,8 sao) và tỷ lệ bám sát nguyên liệu (97,8%), trong khi chế độ Fallback tối ưu về tốc độ (0,21 giây) và độ chuẩn xác hình ảnh (98,2%)."
        },
        # Slide 18: Real-life Demos
        {
            "type": "two_columns",
            "badge": "KỊCH BẢN THỰC TẾ",
            "title": "Minh Họa Kịch Bản Kiểm Thử Thực Tế Điển Hình",
            "subtitle": "Chứng minh tính chính xác, thực tế và loại trừ hoàn toàn món không liên quan",
            "col1_title": "Kịch Bản 1: [Trứng, Cà chua, Hành lá]",
            "col1_bullets": [
                "Món đề xuất: Trứng sốt cà chua, Canh cà chua trứng, Trứng chiên hành lá, Cơm chiên trứng.",
                "Cam kết: 100% không xuất hiện thịt bò, heo, gà hay cá lạ.",
                "Dinh dưỡng: Tính toán năng lượng chuẩn (~220 kcal), hiển thị ảnh Cookpad sắc nét."
            ],
            "col2_title": "Kịch Bản 2: [Thịt bò]",
            "col2_bullets": [
                "Món đề xuất: Thịt bò xào hành tây, Thịt bò áp chảo, Bò lúc lắc, Canh dưa chua bắp bò, Măng tây xào thịt bò...",
                "Đầy đủ số lượng: Gợi ý đủ 8 món ngon nhất trong kho 67 món bò.",
                "Phân trang trực quan: Chia làm 3 trang mượt mà (3 món - 3 món - 2 món)."
            ],
            "notes": "Trên màn hình là hai kịch bản điển hình: Dù người dùng chỉ có trứng cà chua hay có thịt bò, hệ thống đều đưa ra các món ăn thân thuộc, chuẩn vị Việt Nam, đúng định lượng và hình ảnh chân thực 100%."
        },
        # Slide 19: Conclusion & Future Work
        {
            "type": "two_columns",
            "badge": "TỔNG KẾT",
            "title": "Kết Luận & Hướng Phát Triển Tương Lai",
            "subtitle": "Đóng góp chính của đề tài và lộ trình nâng cấp sản phẩm ứng dụng",
            "col1_title": "Những Đóng Góp Chính Của Đồ Án",
            "col1_bullets": [
                "Đề xuất thành công kiến trúc Grounded RAG giải quyết triệt để bài toán ảo giác nguyên liệu của LLM.",
                "Hiện thực hóa ứng dụng Web hoàn chỉnh 2 phân hệ (Client & Admin) sẵn sàng đưa vào sử dụng thực tế.",
                "Xây dựng kho dữ liệu 552 món ăn và hơn 2.000 hình ảnh Cookpad Việt Nam chất lượng cao.",
                "Đã triển khai thực tế trên Cloud (Vercel & Render) với tên miền hoạt động ổn định."
            ],
            "col2_title": "Hướng Phát Triển Tương Lai",
            "col2_bullets": [
                "Thị giác máy tính (Computer Vision): Tích hợp mô hình YOLOv8 chụp ảnh khay tủ lạnh tự nhận diện nguyên liệu.",
                "Lập thực đơn tuần thông minh (Weekly Meal Planner): Tự động phân bổ calo 7 ngày theo thể trạng (Keto, giảm cân, tiểu đường).",
                "Phát triển ứng dụng di động đa nền tảng (React Native) và mạng xã hội chia sẻ công thức ẩm thực."
            ],
            "notes": "Đề tài đã hoàn thành xuất sắc các mục tiêu đề ra. Trong tương lai, nhóm sẽ mở rộng thêm tính năng nhận diện thực phẩm qua camera AI và lập thực đơn dinh dưỡng theo tuần cho gia đình."
        },
        # Slide 20: Thank you
        {
            "type": "closing",
            "title": "CHÂN THÀNH CẢM ƠN QUÝ THẦY CÔ VÀ CÁC BẠN!",
            "subtitle": "HỆ THỐNG AI GỢI Ý MÓN ĂN THEO NGUYÊN LIỆU (FoodAI)",
            "advisor": "Trân trọng cảm ơn TS. Đỗ Phúc Hảo đã tận tình hướng dẫn khoa học trong suốt quá trình thực hiện đồ án.",
            "links": "🌐 Live Demo: https://do-an-tri-tue-nhan-tao-nu.vercel.app\n💻 GitHub: https://github.com/T-glonk/DoAnTriTueNhanTao.git",
            "qa": "KÍNH MỜI QUÝ THẦY CÔ TRONG HỘI ĐỒNG ĐẶT CÂU HỎI (Q&A)",
            "notes": "Em xin chân thành cảm ơn quý Thầy Cô trong Hội đồng đã chú ý lắng nghe bài báo cáo của nhóm. Chúng em rất mong nhận được những lời nhận xét, góp ý quý báu của quý Thầy Cô để hoàn thiện đề tài hơn nữa. Nhóm chúng em xin sẵn sàng trả lời các câu hỏi của Hội đồng ạ!"
        }
    ]

    for idx, data in enumerate(slides_data):
        slide = prs.slides.add_slide(blank_slide_layout)
        
        # Add background shape
        bg = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, 0, 0, prs.slide_width, prs.slide_height)
        bg.fill.solid()
        bg.fill.fore_color.rgb = LIGHT_BG
        bg.line.fill.background()

        # Speaker notes
        if "notes" in data:
            notes_slide = slide.notes_slide
            text_frame = notes_slide.notes_text_frame
            text_frame.text = data["notes"]

        if data["type"] == "title":
            # Gradient top bar
            top_bar = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(0), Inches(0), Inches(13.333), Inches(0.2))
            top_bar.fill.solid()
            top_bar.fill.fore_color.rgb = BRAND_ORANGE
            top_bar.line.fill.background()

            # Main Card
            card = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(1.5), Inches(0.9), Inches(10.333), Inches(5.8))
            card.fill.solid()
            card.fill.fore_color.rgb = WHITE
            card.line.color.rgb = CARD_BORDER
            card.line.width = Pt(1.5)

            # Badge pill
            badge = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(4.8), Inches(1.3), Inches(3.733), Inches(0.45))
            badge.fill.solid()
            badge.fill.fore_color.rgb = RGBColor(254, 243, 199)
            badge.line.color.rgb = RGBColor(245, 158, 11)
            tf = badge.text_frame
            tf.text = "🤖 BÁO CÁO ĐỒ ÁN TRÍ TUỆ NHÂN TẠO"
            tf.paragraphs[0].alignment = PP_ALIGN.CENTER
            tf.paragraphs[0].font.size = Pt(13)
            tf.paragraphs[0].font.bold = True
            tf.paragraphs[0].font.color.rgb = RGBColor(180, 83, 9)

            # Title
            txBox = slide.shapes.add_textbox(Inches(1.8), Inches(1.9), Inches(9.733), Inches(1.4))
            tf = txBox.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = data["title"]
            p.font.size = Pt(28)
            p.font.bold = True
            p.font.color.rgb = BRAND_ORANGE
            p.alignment = PP_ALIGN.CENTER

            # Subtitle
            txBox = slide.shapes.add_textbox(Inches(1.8), Inches(3.2), Inches(9.733), Inches(1.1))
            tf = txBox.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = data["subtitle"]
            p.font.size = Pt(14)
            p.font.color.rgb = SLATE
            p.alignment = PP_ALIGN.CENTER

            # Info box
            txBox = slide.shapes.add_textbox(Inches(2.0), Inches(4.3), Inches(9.333), Inches(2.2))
            tf = txBox.text_frame
            tf.word_wrap = True
            
            p1 = tf.paragraphs[0]
            p1.text = data["students"]
            p1.font.size = Pt(15)
            p1.font.bold = True
            p1.font.color.rgb = NAVY
            p1.alignment = PP_ALIGN.CENTER

            p2 = tf.add_paragraph()
            p2.text = data["advisor"]
            p2.font.size = Pt(14)
            p2.font.bold = True
            p2.font.color.rgb = BRAND_BLUE
            p2.alignment = PP_ALIGN.CENTER

            p3 = tf.add_paragraph()
            p3.text = data["dept"]
            p3.font.size = Pt(12)
            p3.font.color.rgb = SLATE
            p3.alignment = PP_ALIGN.CENTER

        elif data["type"] == "closing":
            top_bar = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(0), Inches(0), Inches(13.333), Inches(0.2))
            top_bar.fill.solid()
            top_bar.fill.fore_color.rgb = BRAND_ORANGE
            top_bar.line.fill.background()

            card = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(1.5), Inches(0.9), Inches(10.333), Inches(5.8))
            card.fill.solid()
            card.fill.fore_color.rgb = WHITE
            card.line.color.rgb = CARD_BORDER
            card.line.width = Pt(1.5)

            txBox = slide.shapes.add_textbox(Inches(1.8), Inches(1.4), Inches(9.733), Inches(1.2))
            tf = txBox.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = data["title"]
            p.font.size = Pt(28)
            p.font.bold = True
            p.font.color.rgb = BRAND_ORANGE
            p.alignment = PP_ALIGN.CENTER

            txBox = slide.shapes.add_textbox(Inches(1.8), Inches(2.6), Inches(9.733), Inches(0.8))
            tf = txBox.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = data["subtitle"]
            p.font.size = Pt(16)
            p.font.bold = True
            p.font.color.rgb = BRAND_BLUE
            p.alignment = PP_ALIGN.CENTER

            txBox = slide.shapes.add_textbox(Inches(2.0), Inches(3.4), Inches(9.333), Inches(1.0))
            tf = txBox.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = data["advisor"]
            p.font.size = Pt(14)
            p.font.italic = True
            p.font.color.rgb = SLATE
            p.alignment = PP_ALIGN.CENTER

            qa_box = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(2.5), Inches(4.4), Inches(8.333), Inches(0.8))
            qa_box.fill.solid()
            qa_box.fill.fore_color.rgb = RGBColor(238, 242, 255)
            qa_box.line.color.rgb = RGBColor(99, 102, 241)
            tf = qa_box.text_frame
            p = tf.paragraphs[0]
            p.text = data["qa"]
            p.font.size = Pt(16)
            p.font.bold = True
            p.font.color.rgb = BRAND_BLUE
            p.alignment = PP_ALIGN.CENTER

            txBox = slide.shapes.add_textbox(Inches(2.0), Inches(5.4), Inches(9.333), Inches(0.9))
            tf = txBox.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = data["links"]
            p.font.size = Pt(13)
            p.font.color.rgb = SLATE
            p.alignment = PP_ALIGN.CENTER

        else:
            # Standard Header
            top_bar = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(0), Inches(0), Inches(13.333), Inches(0.08))
            top_bar.fill.solid()
            top_bar.fill.fore_color.rgb = BRAND_ORANGE
            top_bar.line.fill.background()

            # Badge
            badge = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), Inches(0.35), Inches(2.8), Inches(0.35))
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

            # Title & Subtitle
            txBox = slide.shapes.add_textbox(Inches(0.8), Inches(0.72), Inches(11.7), Inches(0.7))
            tf = txBox.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = data["title"]
            p.font.size = Pt(22)
            p.font.bold = True
            p.font.color.rgb = NAVY

            p_sub = tf.add_paragraph()
            p_sub.text = data.get("subtitle", "")
            p_sub.font.size = Pt(12)
            p_sub.font.color.rgb = SLATE

            # Slide Number
            numBox = slide.shapes.add_textbox(Inches(11.8), Inches(0.4), Inches(0.9), Inches(0.4))
            tf = numBox.text_frame
            p = tf.paragraphs[0]
            p.text = f"{idx + 1} / 20"
            p.font.size = Pt(12)
            p.font.bold = True
            p.font.color.rgb = RGBColor(148, 163, 184)
            p.alignment = PP_ALIGN.RIGHT

            # Content Area
            if data["type"] == "agenda":
                y = 1.7
                for item_title, item_desc in data["items"]:
                    card = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), Inches(y), Inches(11.733), Inches(0.88))
                    card.fill.solid()
                    card.fill.fore_color.rgb = WHITE
                    card.line.color.rgb = CARD_BORDER
                    card.line.width = Pt(1)

                    num_badge = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(1.0), Inches(y + 0.14), Inches(0.6), Inches(0.6))
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

                    y += 1.0

            elif data["type"] == "two_columns":
                w = Inches(5.65)
                h = Inches(5.2)

                # Column 1
                card1 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), Inches(1.7), w, h)
                card1.fill.solid()
                card1.fill.fore_color.rgb = WHITE
                card1.line.color.rgb = CARD_BORDER
                card1.line.width = Pt(1)

                tx1 = slide.shapes.add_textbox(Inches(1.0), Inches(1.85), Inches(5.25), Inches(4.8))
                tf1 = tx1.text_frame
                tf1.word_wrap = True
                p_head1 = tf1.paragraphs[0]
                p_head1.text = data["col1_title"]
                p_head1.font.size = Pt(16)
                p_head1.font.bold = True
                p_head1.font.color.rgb = BRAND_ORANGE

                for bullet in data["col1_bullets"]:
                    p = tf1.add_paragraph()
                    p.text = "• " + bullet
                    p.font.size = Pt(13)
                    p.font.color.rgb = NAVY
                    p.space_before = Pt(8)

                # Column 2
                card2 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(6.8), Inches(1.7), w, h)
                card2.fill.solid()
                card2.fill.fore_color.rgb = WHITE
                card2.line.color.rgb = CARD_BORDER
                card2.line.width = Pt(1)

                tx2 = slide.shapes.add_textbox(Inches(7.0), Inches(1.85), Inches(5.25), Inches(4.8))
                tf2 = tx2.text_frame
                tf2.word_wrap = True
                p_head2 = tf2.paragraphs[0]
                p_head2.text = data["col2_title"]
                p_head2.font.size = Pt(16)
                p_head2.font.bold = True
                p_head2.font.color.rgb = BRAND_BLUE

                for bullet in data["col2_bullets"]:
                    p = tf2.add_paragraph()
                    p.text = "• " + bullet
                    p.font.size = Pt(13)
                    p.font.color.rgb = NAVY
                    p.space_before = Pt(8)

            elif data["type"] == "three_columns":
                w = Inches(3.68)
                h = Inches(5.2)
                xs = [Inches(0.8), Inches(4.82), Inches(8.84)]
                cols = [
                    (data["col1_title"], data["col1_bullets"], BRAND_ORANGE),
                    (data["col2_title"], data["col2_bullets"], BRAND_BLUE),
                    (data["col3_title"], data["col3_bullets"], GREEN),
                ]

                for x, (title, bullets, color) in zip(xs, cols):
                    card = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, x, Inches(1.7), w, h)
                    card.fill.solid()
                    card.fill.fore_color.rgb = WHITE
                    card.line.color.rgb = CARD_BORDER
                    card.line.width = Pt(1)

                    tx = slide.shapes.add_textbox(x + Inches(0.2), Inches(1.85), w - Inches(0.4), h - Inches(0.3))
                    tf = tx.text_frame
                    tf.word_wrap = True
                    p_head = tf.paragraphs[0]
                    p_head.text = title
                    p_head.font.size = Pt(15)
                    p_head.font.bold = True
                    p_head.font.color.rgb = color

                    for bullet in bullets:
                        p = tf.add_paragraph()
                        p.text = "• " + bullet
                        p.font.size = Pt(12)
                        p.font.color.rgb = NAVY
                        p.space_before = Pt(6)

            elif data["type"] == "cards_grid":
                w = Inches(5.65)
                h = Inches(2.4)
                coords = [
                    (Inches(0.8), Inches(1.7)),
                    (Inches(6.8), Inches(1.7)),
                    (Inches(0.8), Inches(4.4)),
                    (Inches(6.8), Inches(4.4))
                ]

                colors = [BRAND_ORANGE, BRAND_BLUE, GREEN, RGBColor(147, 51, 234)]
                for (cx, cy), (ctitle, cdesc), color in zip(coords, data["cards"], colors):
                    card = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, cx, cy, w, h)
                    card.fill.solid()
                    card.fill.fore_color.rgb = WHITE
                    card.line.color.rgb = CARD_BORDER
                    card.line.width = Pt(1)

                    left_bar = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, cx, cy, Inches(0.12), h)
                    left_bar.fill.solid()
                    left_bar.fill.fore_color.rgb = color
                    left_bar.line.fill.background()

                    tx = slide.shapes.add_textbox(cx + Inches(0.3), cy + Inches(0.2), w - Inches(0.5), h - Inches(0.4))
                    tf = tx.text_frame
                    tf.word_wrap = True
                    p_head = tf.paragraphs[0]
                    p_head.text = ctitle
                    p_head.font.size = Pt(15)
                    p_head.font.bold = True
                    p_head.font.color.rgb = color

                    p_body = tf.add_paragraph()
                    p_body.text = cdesc
                    p_body.font.size = Pt(12.5)
                    p_body.font.color.rgb = NAVY
                    p_body.space_before = Pt(6)

            elif data["type"] == "table":
                rows = len(data["rows"]) + 1
                cols = len(data["headers"])
                table_shape = slide.shapes.add_table(rows, cols, Inches(0.8), Inches(1.7), Inches(11.733), Inches(5.0))
                table = table_shape.table

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
                            if "ĐẠT" in val or "⭐" in val or "100%" in val:
                                p.font.bold = True
                                p.font.color.rgb = GREEN

    output_path = "FoodAI_Slide_Thuyet_Trinh_20_Slides.pptx"
    prs.save(output_path)
    print(f"✅ Đã tạo thành công file PowerPoint 20 slides: {output_path}")

if __name__ == "__main__":
    create_presentation()
