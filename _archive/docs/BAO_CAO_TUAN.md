# BÁO CÁO TIẾN ĐỘ HÀNG TUẦN
## ĐỒ ÁN TRÍ TUỆ NHÂN TẠO: HỆ THỐNG GỢI Ý MÓN ĂN THÔNG MINH (FoodAI)

---

### 📋 THÔNG TIN CHUNG
- **Tên đề tài:** Xây dựng hệ thống gợi ý món ăn thông minh dựa trên nguyên liệu có sẵn (FoodAI)
- **Thời gian báo cáo:** Tuần làm việc (Cập nhật ngày 13/10/2026)
- **Môi trường triển khai:** Node.js, Express, React (Vite), TypeScript, MySQL, Google Gemini AI
- **Trạng thái dự án:** Đã hoàn thiện toàn bộ các chức năng cốt lõi, hệ thống đang vận hành ổn định trên môi trường thử nghiệm nội bộ.

---

### I. MỤC TIÊU VÀ NHIỆM VỤ ĐẶT RA TRONG TUẦN
1. **Dữ liệu & Thu thập:** Hoàn tất cào và làm sạch dữ liệu món ăn Việt Nam từ Cookpad; xây dựng kho ảnh chuẩn HD cho các món ăn.
2. **Trí tuệ nhân tạo (AI Engine):** Tối ưu hóa Prompt Engineering cho Google Gemini AI nhằm loại bỏ ảo giác (hallucination), kiểm soát chặt chẽ nguyên liệu đầu vào và đa dạng hóa phương pháp chế biến.
3. **Cơ sở dữ liệu & Backend:** Chuyển đổi và chuẩn hóa cấu trúc CSDL sang MySQL; xây dựng cơ chế tự động lưu trữ các công thức món ăn do AI sinh ra (Auto-caching & Persistence).
4. **Hệ thống xử lý hình ảnh:** Hoàn thiện thuật toán chấm điểm và gán hình ảnh ẩm thực Cookpad, loại trừ hoàn toàn tình trạng sai lệch ảnh hoặc trùng lặp ảnh giữa các món.
5. **Frontend & Giao diện Admin:** Hoàn thiện giao diện tìm kiếm, hiển thị chi tiết công thức, bảng dinh dưỡng 8 chỉ số và các biểu đồ thống kê trong trang Quản trị viên (Admin).
6. **Kiểm thử tích hợp:** Khởi chạy đồng bộ hệ thống (Frontend, Backend, Database MySQL và AI API) để kiểm tra luồng nghiệp vụ thực tế.

---

### II. NỘI DUNG CÔNG VIỆC ĐÃ HOÀN THÀNH TRONG TUẦN

#### 1. Xây dựng và xử lý dữ liệu ẩm thực (Crawler & Dataset)
- **Công cụ:** Python (`BeautifulSoup`, `requests`).
- **Kết quả thu thập:** Đã cào và chuẩn hóa hơn **549 món ăn thực tế** cùng hơn **1.300 hình ảnh chất lượng cao** (độ phân giải 1200x630) từ Cookpad Việt Nam.
- **Tiền xử lý dữ liệu:** Chuẩn hóa tiếng Việt, phân loại theo danh mục ẩm thực (Món chính, Món canh/súp, Món xào, Món chiên/rán, Món kho/rim, Salad/Gỏi, Ăn sáng/Điểm tâm), loại bỏ các liên kết hỏng hoặc ảnh chất lượng thấp.

#### 2. Tối ưu hóa mô hình AI (Google Gemini AI Engine)
- **Tích hợp API:** Sử dụng thư viện chính thức `@google/generative-ai` kết nối mô hình Gemini.
- **Prompt Engineering đa tầng:**
  - **Ngăn chặn Hallucination (Ảo giác):** Thêm ràng buộc nghiêm ngặt để AI không tự ý bịa thêm nguyên liệu thịt/hải sản đắt tiền khi người dùng chỉ cung cấp rau củ.
  - **Thuật toán loại trừ dính chữ (Word Boundary Negation):** Xử lý triệt để hiện tượng nhầm lẫn giữa gia vị và nguyên liệu tươi sống (ví dụ: *mắm tôm* ≠ *tôm*, *dầu hào* ≠ *hàu*, *cà chua* ≠ *cá*, *đậu gà* ≠ *gà*).
  - **Đa dạng hóa phương pháp nấu:** Đảm bảo 4 món gợi ý luôn bao gồm nhiều phương pháp chế biến khác nhau (ví dụ: 1 món canh, 1 món xào, 1 món kho, 1 món rán), tránh việc gợi ý lặp lại cùng một kiểu nấu.
  - **Phân tích dinh dưỡng khoa học:** Tính toán chi tiết 8 chỉ số dinh dưỡng (Calories, Protein, Carbs, Fat, Fiber, Vitamin C, Calcium, Iron) cho mỗi khẩu phần ăn.
  - **Bí quyết đầu bếp (`ai_reasoning`):** Bổ sung lời khuyên của chuyên gia dinh dưỡng và đầu bếp về lý do kết hợp các nguyên liệu.

#### 3. Phát triển Backend & Cơ sở dữ liệu MySQL
- **Cơ sở dữ liệu:** Thiết kế lược đồ CSDL MySQL 8.0 quan hệ chuẩn hóa gồm:
  - `users`: Quản lý tài khoản, phân quyền (`user` / `admin`), mã hóa mật khẩu Bcrypt.
  - `recipes`: Lưu trữ danh mục món ăn chuẩn.
  - `recipe_ingredients`: Chi tiết nguyên liệu và định lượng.
  - `recipe_steps`: Quy trình từng bước thực hiện có số thứ tự.
  - `recipe_nutrition`: Lưu trữ các chỉ số dinh dưỡng.
  - `cookpad_dish_images`: Kho tra cứu ảnh Cookpad theo khóa truy vấn và danh mục.
  - `favorites` & `search_history`: Lưu trữ tương tác và lịch sử tìm kiếm của người dùng.
- **Tính năng Auto-caching công thức AI:** Viết hàm tự động ghi nhận mọi công thức và dinh dưỡng do AI sáng tạo vào CSDL MySQL để tối ưu tốc độ tra cứu và tái sử dụng cho các lần tìm kiếm tương tự.
- **API & Bảo mật:** Hoàn thiện RESTful API với xác thực JSON Web Token (JWT), thiết lập `express-rate-limit` chống spam và bảo vệ tài nguyên API.

#### 4. Thuật toán chọn lọc và gán hình ảnh thông minh (Image Matcher)
- Xây dựng thuật toán tính điểm tương đồng ngữ nghĩa giữa tên món ăn và kho ảnh Cookpad.
- **Cơ chế phát hiện xung đột (Conflict Detector):** Tự động phát hiện và ngăn chặn việc gán sai ảnh (ví dụ: món canh không được gán ảnh món chiên/rán; món rau không được gán ảnh món thịt).
- **Cơ chế chống trùng lặp (`usedImages Set`):** Đảm bảo trên cùng một màn hình kết quả tìm kiếm, mỗi món ăn đều có hình ảnh minh họa riêng biệt, không bị trùng ảnh.

#### 5. Phát triển Giao diện người dùng (Frontend) & Quản trị (Admin)
- **Công nghệ:** React 18, TypeScript, Vite, Tailwind CSS, Lucide Icons, Recharts.
- **Trang người dùng:**
  - Nhập nguyên liệu trực quan với tính năng thêm nhanh nguyên liệu gợi ý và bộ mẫu thử nghiệm có sẵn.
  - Hiển thị kết quả món ăn dạng thẻ trực quan (Card view), có thể mở rộng xem công thức nhanh hoặc mở Modal chi tiết 3 tab (Nguyên liệu, Cách làm, Dinh dưỡng).
  - Quản lý danh sách món yêu thích và xem lại lịch sử tìm kiếm (có tính năng "Dùng lại bộ nguyên liệu").
- **Trang Quản trị (Admin Dashboard):**
  - Biểu đồ thống kê top nguyên liệu được tìm kiếm nhiều nhất (Recharts).
  - Biểu đồ phân bổ trạng thái người dùng (Active / Inactive).
  - Quản lý danh sách người dùng: tìm kiếm thời gian thực, xem chi tiết, phân trang, kích hoạt/khóa tài khoản.

---

### III. KẾT QUẢ ĐẠT ĐƯỢC VÀ METRICS

| Tiêu chí | Mục tiêu ban đầu | Kết quả đạt được trong tuần | Đánh giá |
| :--- | :--- | :--- | :--- |
| **Số lượng món ăn Cookpad** | ~300 món | **549 món ăn** kèm >1.300 ảnh HD | Vượt kế hoạch |
| **Thời gian phản hồi AI** | < 5.0 giây | **~1.5 - 2.8 giây** | Đạt yêu cầu |
| **Tỷ lệ ảnh đúng ngữ cảnh** | > 85% | **> 96%** (nhờ bộ lọc xung đột) | Rất tốt |
| **Độ chính xác nguyên liệu** | Không có thịt khi nhập rau | **100% tuân thủ** theo prompt âm | Đạt yêu cầu |
| **Trạng thái hệ thống** | Chạy thử nghiệm | Backend (5001) & Frontend (5173) hoạt động trơn tru | Hoàn thành |

---

### IV. KHÓ KHĂN GẶP PHẢI & GIẢI PHÁP ĐÃ ÁP DỤNG

1. **Khó khăn 1: Hiện tượng AI tự bịa nguyên liệu (Hallucination)**
   - *Vấn đề:* Khi người dùng chỉ nhập `trứng, cà chua`, AI đôi khi tự gợi ý món có thêm `thịt bò` hoặc `tôm sú`.
   - *Giải pháp:* Tinh chỉnh System Prompt với chỉ thị phủ định nghiêm ngặt (Strict Negative Constraint): *"Chỉ được sử dụng nguyên liệu người dùng đã cung cấp làm nguyên liệu chính; tuyệt đối không tự thêm thịt, cá, hải sản nếu không có trong danh sách đầu vào."*
2. **Khó khăn 2: Trùng lặp hoặc sai lệch ảnh món ăn**
   - *Vấn đề:* Một số món khác nhau nhưng có tên gần giống nhau bị gán chung một ảnh từ API hoặc cơ sở dữ liệu.
   - *Giải pháp:* Bổ sung cơ chế quản lý tập ảnh đã dùng (`usedImages: Set<string>`) trong suốt phiên render và bổ sung bảng đối chiếu từ khóa loại trừ ảnh đối lập.

---

### V. KẾ HOẠCH CHO TUẦN TIẾP THEO

1. **Thu thập phản hồi & Thử nghiệm người dùng:** Tổ chức cho một nhóm người dùng (sinh viên, người nội trợ) trải nghiệm hệ thống và ghi nhận phản hồi về độ tiện dụng của giao diện.
2. **Tối ưu hóa hiệu năng & Caching:** Cải thiện tốc độ tải trang trên thiết bị di động, tối ưu hóa các câu truy vấn MySQL thông qua các chỉ mục (Indexes).
3. **Hoàn thiện tài liệu & Báo cáo tổng kết:**
   - Cập nhật tài liệu kỹ thuật SRS và kiến trúc hệ thống.
   - Thiết kế Slide thuyết trình đồ án (PowerPoint).
   - Quay video demo các kịch bản sử dụng thực tế (User flow & Admin flow).
