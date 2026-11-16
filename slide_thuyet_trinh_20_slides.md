# 📊 BỘ SLIDE THUYẾT TRÌNH BẢO VỆ ĐỒ ÁN TRÍ TUỆ NHÂN TẠO (20 SLIDES)

**ĐỀ TÀI:** HỆ THỐNG AI GỢI Ý MÓN ĂN THEO NGUYÊN LIỆU (FoodAI)  
**Đơn vị:** Trường Đại học Kiến trúc Đà Nẵng — Khoa Công nghệ Thông tin  
**Lớp:** 23CT2 — Năm học: 2025–2026  
**Giảng viên hướng dẫn:** TS. Đỗ Phúc Hảo  
**Sinh viên thực hiện:** 
* Phạm Tấn Hào — MSSV: 2351220282
* Trần Quốc Trung — MSSV: 2351220096

---

## 📑 BỐ CỤC TỔNG QUAN 20 SLIDE

```
[Slide 1]  TRANG TIÊU ĐỀ (BÌA BÁO CÁO BẢO VỆ)
[Slide 2]  NỘI DUNG TRÌNH BÀY (OUTLINE)
[Slide 3]  BỐI CẢNH THỰC TẾ & TÍNH CẤP THIẾT
[Slide 4]  HẠN CHẾ CỦA PHƯƠNG PHÁP TRUYỀN THỐNG & THÁCH THỨC VỚI LLM
[Slide 5]  MỤC TIÊU VÀ ĐÓNG GÓP CỦA ĐỒ ÁN
[Slide 6]  KIẾN TRÚC TỔNG THỂ HỆ THỐNG (3-TIER ARCHITECTURE)
[Slide 7]  KIẾN TRÚC GROUNDED RAG — NGUYÊN LÝ KHỬ ẢO GIÁC
[Slide 8]  HỆ SINH THÁI CÔNG NGHỆ & CƠ SỞ DỮ LIỆU
[Slide 9]  TIỀN XỬ LÝ NLP TIẾNG VIỆT & MA TRẬN ĐỒNG NGHĨA
[Slide 10] THUẬT TOÁN SO KHỚP VÀ CHẤM ĐIỂM ĐA TIÊU CHÍ (RANKING)
[Slide 11] CƠ CHẾ BẢO VỆ ĐỒNG NHẤT HÌNH ẢNH (IMAGE CONFLICT PREVENTION)
[Slide 12] CƠ CHẾ DỰ PHÒNG CHỊU LỖI (FALLBACK MECHANISM)
[Slide 13] THIẾT KẾ USE CASE & PHÂN QUYỀN HỆ THỐNG
[Slide 14] DEMO GIAO DIỆN CLIENT: TÌM KIẾM & GỢI Ý PHÂN TRANG (3 MÓN/TRANG)
[Slide 15] DEMO GIAO DIỆN CLIENT: PHÂN TÍCH DINH DƯỠNG & CÔNG THỨC 4 BƯỚC
[Slide 16] DEMO GIAO DIỆN CLIENT: SỔ TAY YÊU THÍCH & TÁI DÙNG LỊCH SỬ
[Slide 17] DEMO GIAO DIỆN ADMIN: QUẢN TRỊ KHO MÓN & ĐỔI LINK ẢNH TRỰC TIẾP
[Slide 18] KẾT QUẢ THỰC NGHIỆM ĐỊNH LƯỢNG (AI VS FALLBACK)
[Slide 19] KẾT LUẬN & HƯỚNG PHÁT TRIỂN TƯƠNG LAI
[Slide 20] LỜI CẢM ƠN & PHIÊN HỎI ĐÁP (Q&A)
```

---

## CHI TIẾT TỪNG SLIDE THUYẾT TRÌNH

---

### SLIDE 1: TRANG TIÊU ĐỀ (TITLE SLIDE)
* **Tiêu đề chính:** BÁO CÁO ĐỒ ÁN TRÍ TUỆ NHÂN TẠO
* **Tên đề tài:** **HỆ THỐNG AI GỢI Ý MÓN ĂN THEO NGUYÊN LIỆU (FoodAI)**
* **Phụ đề:** *Ứng dụng Google Gemini AI và Kiến trúc Grounded RAG trên kho dữ liệu thực nghiệm Cookpad Việt Nam*
* **Thông tin thực hiện:**
  * **Trường:** Đại học Kiến trúc Đà Nẵng — Khoa Công nghệ Thông tin
  * **Lớp:** 23CT2
  * **Giảng viên hướng dẫn:** TS. Đỗ Phúc Hảo
  * **Sinh viên thực hiện:**
    1. Phạm Tấn Hào — MSSV: 2351220282
    2. Trần Quốc Trung — MSSV: 2351220096
  * **Thời gian:** Đà Nẵng, Năm học 2025–2026

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Kính thưa quý Thầy Cô trong Hội đồng chấm đồ án tốt nghiệp và các bạn sinh viên. Em tên là Trần Quốc Trung, cùng bạn Phạm Tấn Hào đại diện cho nhóm nghiên cứu lớp 23CT2. Hôm nay, chúng em rất vinh dự được trình bày báo cáo đồ án Trí tuệ Nhân tạo với đề tài: **'Hệ thống AI gợi ý món ăn theo nguyên liệu (FoodAI)'**, dưới sự hướng dẫn khoa học tận tình của Thầy TS. Đỗ Phúc Hảo. Sau đây, em xin phép được bắt đầu phần báo cáo."*

---

### SLIDE 2: NỘI DUNG TRÌNH BÀY (OUTLINE)
* **Tiêu đề:** NỘI DUNG BÁO CÁO
* **Cấu trúc 5 phần:**
  1. **Đặt vấn đề & Mục tiêu:** Bối cảnh thực tiễn, thách thức công nghệ và mục tiêu đề tài.
  2. **Cơ sở lý thuyết & Kiến trúc:** Trí tuệ nhân tạo tạo sinh, hiện tượng ảo giác và mô hình Grounded RAG.
  3. **Thuật toán & Thiết kế hệ thống:** Xử lý ngôn ngữ tự nhiên tiếng Việt, lọc ràng buộc đạm và thiết kế CSDL.
  4. **Hiện thực hóa & Thử nghiệm:** Demo các luồng nghiệp vụ thực tế trên hệ thống Web và phân hệ Admin.
  5. **Đánh giá & Kết luận:** Kết quả định lượng, so sánh hiệu năng và phương hướng mở rộng.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Bài thuyết trình của chúng em hôm nay được cô đọng thành 5 phần mạch lạc: Bắt đầu từ bài toán thực tế quản lý thực phẩm hàng ngày, kế tiếp là giải pháp kiến trúc Grounded RAG kết hợp Google Gemini AI, các thuật toán xử lý ngôn ngữ tiếng Việt loại bỏ sai lệch nguyên liệu, phần trình diễn trực tiếp hệ thống và cuối cùng là kết quả thực nghiệm cùng phương hướng phát triển."*

---

### SLIDE 3: BỐI CẢNH THỰC TẾ & TÍNH CẤP THIẾT
* **Tiêu đề:** BỐI CẢNH & TÍNH CẤP THIẾT CỦA ĐỀ TÀI
* **Các điểm thực trạng:**
  * 🧊 **Nhu cầu thường nhật:** Câu hỏi *"Hôm nay ăn gì?"* và *"Tủ lạnh còn những nguyên liệu này thì nấu món gì ngon?"* là trăn trở mỗi ngày của hàng triệu người nội trợ, sinh viên và người đi làm.
  * 🥦 **Lãng phí thực phẩm:** Hàng triệu tấn rau củ, thịt cá tươi sống bị hư hỏng, quá hạn vì người dùng không biết cách kết hợp các nguyên liệu lẻ tẻ còn sót lại.
  * 🩺 **Nhu cầu dinh dưỡng cá nhân hóa:** Người dùng hiện đại không chỉ muốn ăn ngon mà còn quan tâm sâu sắc đến năng lượng (Calo), đạm, chất xơ và kiểm soát cân nặng.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Xuất phát từ thực tế đời sống, hầu hết mỗi chúng ta khi mở tủ lạnh đều thấy một vài quả trứng, nửa quả cà chua, một ít hành lá hay mẩu thịt bò, nhưng lại lúng túng không biết nấu món gì. Sự thiếu hụt một công cụ tư vấn thông minh dẫn đến lãng phí thực phẩm và tốn kém chi phí sinh hoạt. Đây chính là động lực thôi thúc nhóm nghiên cứu xây dựng giải pháp FoodAI."*

---

### SLIDE 4: HẠN CHẾ HIỆN NAY & THÁCH THỨC VỚI AI
* **Tiêu đề:** HẠN CHẾ CỦA PHƯƠNG PHÁP TRUYỀN THỐNG & THÁCH THỨC VỚI LLM
* **Bảng so sánh 2 cách tiếp cận trước đây:**

| Phương pháp | Đặc điểm | Hạn chế cốt tử |
|---|---|---|
| **Web tra cứu truyền thống** | Tìm kiếm theo từ khóa SQL cứng | Bắt buộc phải biết trước tên món; kết quả nghèo nàn; không linh hoạt theo nguyên liệu có sẵn. |
| **Dùng LLM thuần túy (Chatbot)** | Hỏi trực tiếp ChatGPT / LLM tự do | **Hiện tượng ảo giác (Hallucination):** Tự bịa thêm tôm, cua, thịt bò đắt tiền; tự chế tên món lạ hoắc; không có hình ảnh thực tế khớp món. |

* **Nghịch lý cần giải quyết:** Làm sao để tận dụng được khả năng sáng tạo công thức của AI, nhưng **buộc AI phải tuân thủ nghiêm ngặt nguyên liệu người dùng có và món ăn phải có thật ngoài đời?**

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Nếu dùng các web nấu ăn cũ, ta bắt buộc phải gõ đúng tên 'Thịt kho tàu' hay 'Canh chua cá' mới tìm được. Ngược lại, nếu thả nổi cho các Chatbot AI sinh tự do, AI sẽ mắc bệnh 'ảo giác'—người dùng chỉ có trứng và cà chua nhưng AI lại tự tiện gợi ý món thịt bò xào hay tôm rim. Đó là lý do hệ thống cần một kiến trúc lai ghép đặc thù."*

---

### SLIDE 5: MỤC TIÊU & ĐÓNG GÓP CỦA ĐỒ ÁN
* **Tiêu đề:** MỤC TIÊU VÀ NHỮNG ĐÓNG GÓP CỐT LÕI
* **3 Mục tiêu khoa học & kỹ thuật:**
  1. 🎯 **Xây dựng kiến trúc gợi ý lai ghép (Grounded RAG):** Kết hợp khả năng tạo sinh văn bản của Google Gemini AI với tri thức thực tế từ CSDL MySQL.
  2. 🔬 **Kiểm soát ngữ nghĩa tiếng Việt:** Triệt tiêu hoàn toàn lỗi nhận nhầm từ ghép (mắm tôm $\ne$ tôm, cà chua $\ne$ cá, dầu hào $\ne$ hàu) và cấm AI tự bịa nguyên liệu lạ.
  3. 🚀 **Hệ thống phần mềm hoàn chỉnh:** Fullstack Web (React + Node.js + MySQL), phân quyền JWT, quản trị ảnh Cookpad CDN, gợi ý từ 6-8 món phân trang 3 món/trang.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Đồ án không dừng lại ở mức thử nghiệm mô hình lý thuyết, mà đặt ra mục tiêu xây dựng một sản phẩm hoàn chỉnh phục vụ người dùng thực tế: gợi ý chuẩn xác 6-8 món, có hình ảnh thật từ Cookpad, tính đúng calo dinh dưỡng và có sẵn trang quản trị điều hành dữ liệu."*

---

### SLIDE 6: KIẾN TRÚC TỔNG THỂ HỆ THỐNG
* **Tiêu đề:** KIẾN TRÚC PHÂN TẦNG HỆ THỐNG (THREE-TIER ARCHITECTURE)
* **Sơ đồ khối 3 tầng:**
  * **1. Client Layer (Frontend):** React 18, TypeScript, Tailwind CSS, Vite, Axios Client.
  * **2. Server Layer (Backend RESTful API):** Node.js, Express, Rate Limiter, Auth JWT Middleware.
    * *Mô-đun AI:* `gemini.service.ts` (Google Gemini SDK).
    * *Mô-đun Nghiệp vụ:* `recipe.service.ts` (Heuristic Matching, Ranking).
    * *Mô-đun Hình ảnh:* `image.service.ts` (Image Conflict Filter, CDN Mapper).
  * **3. Data Layer (Database & External Services):**
    * MySQL 8.0 (9 bảng chuẩn hóa 3NF).
    * Google Gemini API Cloud.
    * Cookpad CDN Image Registry (hơn 2.000 ảnh).

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Hệ thống được thiết kế theo mô hình 3 tầng hiện đại, phân tách trách nhiệm rạch ròi. Tầng ứng dụng bóc tách độc lập các Service cho AI, nghiệp vụ so khớp và xử lý hình ảnh, giúp hệ thống đạt độ gắn kết cao, giảm phụ thuộc và dễ dàng mở rộng, kiểm thử."*

---

### SLIDE 7: KIẾN TRÚC GROUNDED RAG — NGUYÊN LÝ KHỬ ẢO GIÁC
* **Tiêu đề:** QUY TRÌNH GROUNDED RAG — CHỐNG ẢO GIÁC MÔ HÌNH LỚN
* **Quy trình 4 bước thực thi:**
  1. **Bước 1 (Truy xuất CSDL - Retrieval):** Hệ thống lọc kho MySQL lấy các món ăn thực tế khớp với nguyên liệu người dùng.
  2. **Bước 2 (Đóng gói ngữ cảnh - Context Grounding):** Gửi danh sách món ứng viên có thật (kèm ID, tên chuẩn, ảnh CDN) vào Prompt của Gemini.
  3. **Bước 3 (AI Enrichment):** Ép AI chỉ đóng vai trò Chuyên gia ẩm thực & Dinh dưỡng: tính toán Calo, Protein, Carbs, Fat, thời gian nấu và bí quyết chế biến. **Cấm tuyệt đối tạo tên món mới**.
  4. **Bước 4 (Đồng bộ tri thức - Database Sync):** Lưu cập nhật kết quả dinh dưỡng của AI ngược vào MySQL để làm giàu CSDL.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Đây là đóng góp kỹ thuật trọng tâm nhất của đồ án. Thay vì để Gemini tự do nghĩ ra món ăn, hệ thống áp dụng cơ chế RAG định hướng CSDL: Món ăn và ảnh chụp được neo chặt từ kho Cookpad thật 100%. AI chỉ làm nhiệm vụ tính toán vi chất và hoàn thiện các bước nấu. Nhờ đó, triệt tiêu hoàn toàn hiện tượng ảo giác."*

---

### SLIDE 8: HỆ SINH THÁI CÔNG NGHỆ & CƠ SỞ DỮ LIỆU
* **Tiêu đề:** CÔNG NGHỆ SỬ DỤNG & LƯỢC ĐỒ CƠ SỞ DỮ LIỆU
* **Stack công nghệ chính:**
  * **Google Gemini AI:** Dòng mô hình `gemini-3.6-flash` / `gemini-3.5-flash` với cấu trúc `responseMimeType: 'application/json'`.
  * **Cơ sở dữ liệu:** MySQL 8.0 với 9 bảng quan hệ: `users`, `recipes`, `recipe_ingredients`, `recipe_steps`, `recipe_nutrition`, `recipe_tags`, `favorite_recipes`, `search_history`, `cookpad_dish_images`.
  * **Quy mô dữ liệu nội bộ:** **552 món ăn Việt Nam** thực tế và hơn **2.000 ảnh CDN Cookpad** phân giải 1200x630.
  * **Bảo mật:** Mã hóa mật khẩu một chiều BCrypt (salt rounds = 12), xác thực phân quyền qua JWT 7 ngày.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Cơ sở dữ liệu của hệ thống được chuẩn hóa theo dạng chuẩn 3NF, lưu trữ hơn 550 món ăn Việt Nam truyền thống. Việc kết hợp SDK chính thức của Google Gemini với chế độ ép kiểu JSON Schema giúp việc trao đổi dữ liệu giữa AI và Backend diễn ra trơn tru mà không bao giờ bị lỗi cú pháp parse."*

---

### SLIDE 9: TIỀN XỬ LÝ NLP TIẾNG VIỆT & TỪ ĐIỂN ĐỒNG NGHĨA
* **Tiêu đề:** XỬ LÝ NGÔN NGỮ TỰ NHIÊN TIẾNG VIỆT & MA TRẬN ĐỒNG NGHĨA
* **Các thuật toán tiền xử lý:**
  * 🔤 **Chuẩn hóa Unicode NFD:** Phân tách và loại bỏ dấu thanh: `Normalize(s) = RegexReplace(s, [\u0300-\u036F], '')`.
  * 🛡️ **Whole-Word Boundary Check:** Dùng Regex `(^|[^a-z0-9])target([^a-z0-9]|$)` để tránh dính từ (ví dụ: không nhận nhầm `heo` trong `bánh bèo`).
  * 📚 **Ma trận từ điển đồng nghĩa (Synonym Groups):**
    * *Thịt bò:* thăn bò, bắp bò, nạm bò, gầu bò, ba chỉ bò...
    * *Thịt heo:* ba chỉ, thịt lợn, sườn non, giò heo, thịt xay...
  * ⛔ **Tập luật loại trừ phủ định (Negative Excludes):**
    * Phân biệt `cá` với `cà chua, cà tím, cà rốt`.
    * Phân biệt `thịt bò` với `bơ tỏi, quả bơ, bơ lạt, bò húc`.
    * Phân biệt `thịt gà` với `đậu gà, nấm đùi gà`.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Tiếng Việt có độ phức tạp ngữ âm rất lớn. Nếu chỉ dùng hàm so sánh chuỗi thông thường, khi người dùng nhập 'cá', máy tính sẽ nhầm sang 'cà chua', hoặc nhập 'bò' sẽ nhầm sang 'bơ tỏi'. Hệ thống đã giải quyết dứt điểm vấn đề này bằng ma trận đồng nghĩa và bộ lọc loại trừ phủ định đặc thù cho ẩm thực Việt."*

---

### SLIDE 10: THUẬT TOÁN SO KHỚP VÀ CHẤM ĐIỂM ĐA TIÊU CHÍ
* **Tiêu đề:** THUẬT TOÁN CHẤM ĐIỂM & XẾP HẠNG ỨNG VIÊN
* **Công thức chấm điểm ưu tiên:**
  $$\text{Score} = (N_{\text{matched}} \times 100) + (\text{Score}_{\text{title}} \times 50) + (\text{Score}_{\text{meat}} \times 150)$$
* **Các điều kiện lọc cứng (Hard Constraints):**
  1. **Ràng buộc Protein:** Nếu người dùng chỉ có `thịt bò`, loại bỏ 100% các món đòi hỏi thịt heo, thịt gà hay tôm cá.
  2. **Bảo vệ món chay:** Nếu người dùng chỉ nhập rau củ / trứng / đậu phụ, loại bỏ toàn bộ các món thịt động vật.
  3. **Ưu tiên tên món:** Các món có tên chứa trực tiếp nguyên liệu chính (như *Trứng sốt cà chua*, *Bò xào hành tây*) sẽ luôn được cộng 50-100 điểm để đứng Top 1.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Thuật toán xếp hạng đa tiêu chí bảo đảm món ăn nào tận dụng được nhiều nguyên liệu nhất và có tên gọi khớp nhất với từ khóa sẽ đứng đầu bảng. Đồng thời, các điều kiện lọc cứng hoạt động như một bức tường lửa, ngăn không cho các món đòi hỏi nguyên liệu người dùng không có lọt vào kết quả."*

---

### SLIDE 11: CƠ CHẾ BẢO VỆ ĐỒNG NHẤT HÌNH ẢNH
* **Tiêu đề:** CƠ CHẾ BẢO VỆ ĐỒNG NHẤT HÌNH ẢNH MÓN ĂN
* **Quy trình kiểm soát 2 tầng:**
  * **Tầng 1 — Bộ lọc tự động (`isImageUrlConflicting`):**
    * Giải mã URL slug của ảnh Cookpad.
    * Nếu tên món là **Thịt bò**, nhưng đường link ảnh lại chứa chữ **gà (`ga`)** hay **heo (`heo`)** $\rightarrow$ Tự động loại bỏ ảnh ngay lập tức.
    * Điểm phạt $-100$ cho các ảnh cơm hộp tạo hình Bento, đồ ăn dặm cho bé, hoặc ảnh mâm cơm hỗn hợp.
  * **Tầng 2 — Quản trị viên tự tay ghi đè ảnh tại Dashboard Admin:**
    * Cho phép Admin mở modal sửa món, dán đường link ảnh mới từ Google Image hoặc mạng xã hội.
    * CSDL MySQL cập nhật ngay và ghi đè ảnh cũ vĩnh viễn.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Một vấn đề rất dễ gặp khi làm web gợi ý món ăn là 'râu ông này cắm cằm bà kia'—tên món là súp gà nhưng ảnh lại là đĩa thịt luộc. Hệ thống FoodAI đã xây dựng bộ phân tích giải mã slug ảnh tự động để triệt tiêu lỗi này, đồng thời trao toàn quyền cho Admin chỉnh sửa link ảnh ngay trên giao diện."*

---

### SLIDE 12: CƠ CHẾ DỰ PHÒNG CHỊU LỖI (FALLBACK)
* **Tiêu đề:** CƠ CHẾ DỰ PHÒNG CHỊU LỖI (FAULT-TOLERANT ARCHITECTURE)
* **Nguyên lý hoạt động:**
  ```
  Yêu cầu Gợi ý Món ăn
           │
           ▼
    [Kiểm tra API Key & Mạng] ──(Sự cố / Mất mạng / Hết Quota)──┐
           │ (Bình thường)                                      │
           ▼                                                    ▼
  ┌─────────────────────────┐                         ┌───────────────────────┐
  │  Nhánh Chính: GEMINI AI │                         │ Nhánh Dự Phòng: MYSQL │
  │  (Grounded RAG 6-8 món) │                         │ (Heuristic CSDL <0.3s)│
  └─────────────────────────┘                         └───────────────────────┘
           │                                                    │
           └────────────────────────┬───────────────────────────┘
                                    ▼
                     [Giao diện Client không gián đoạn]
  ```
* **Thời gian phản hồi:** Nhánh Fallback chỉ mất **0,21 giây**, đảm bảo hệ thống luôn sẵn sàng 100% trong mọi tình huống.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Trong môi trường triển khai thực tế, không có gì đảm bảo kết nối ra ngoài Internet luôn thông suốt 100%. Vì vậy, nhóm đã thiết kế cơ chế chuyển mạch Fallback: Nếu Gemini gặp sự cố mạng hoặc vượt hạn mức, hệ thống tự động chuyển sang chế độ Heuristic CSDL nội bộ chỉ trong 0,21 giây, người dùng không hề gặp lỗi màn hình trắng."*

---

### SLIDE 13: ĐẶC TẢ USE CASE & PHÂN QUYỀN
* **Tiêu đề:** ĐẶC TẢ CA SỬ DỤNG (USE CASE) & PHÂN QUYỀN
* **Phân định rõ ràng 2 nhóm tác tử (Actors):**
  * **1. Khách hàng (User):**
    * Đăng ký, Đăng nhập (JWT).
    * Nhập nguyên liệu, nhận gợi ý 6-8 món từ AI.
    * Xem chi tiết công thức 4 bước & bảng dinh dưỡng 8 chỉ số.
    * Lưu món vào sổ tay Yêu thích & Xem lại Lịch sử gợi ý.
  * **2. Quản trị viên (Admin):**
    * Xem Dashboard thống kê tổng quan (người dùng, món ăn, top nguyên liệu).
    * Quản lý người dùng: Kích hoạt, khóa tài khoản, đổi mật khẩu.
    * Quản trị kho món ăn: Thêm, sửa công thức, cập nhật URL ảnh Cookpad.
    * Giám sát nhật ký AI Query Logs theo thời gian thực.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Hệ thống phân quyền bảo mật hai cấp độ. Khách hàng thông thường được bảo vệ dữ liệu riêng tư qua mã token JWT. Còn Quản trị viên nắm giữ Dashboard đặc quyền để theo dõi toàn bộ hoạt động, với chốt an toàn ngăn Admin tự khóa tài khoản của chính mình."*

---

### SLIDE 14: DEMO GIAO DIỆN CLIENT — GỢI Ý 8 MÓN & PHÂN TRANG
* **Tiêu đề:** TRẢI NGHIỆM GỢI Ý MÓN ĂN & PHÂN TRANG MƯỢT MÀ
* **Hình ảnh / Điểm nổi bật trên giao diện:**
  * **Input động:** Hỗ trợ gõ phím dạng tag màu hoặc bấm 1-click vào danh mục nguyên liệu phổ biến (*thịt bò, trứng, cà chua, hành tây...*).
  * **Bộ combo mẫu:** Hỗ trợ các combo gia đình chuẩn bị sẵn để người dùng thử nghiệm nhanh.
  * **Gợi ý 8 món ăn:** Danh sách gợi ý từ 6-8 món tối ưu nhất.
  * **Phân trang 3 món/trang:** Hiển thị 3 món mỗi trang kèm thanh điều hướng `← Trang trước | Trang 1 / 2 / 3 | Trang tiếp theo →`, hiệu ứng chuyển trang mượt mà.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Trên màn hình là giao diện trang chủ của FoodAI. Người dùng có thể nhập nguyên liệu bằng bàn phím hoặc nhấn chọn các tag màu có sẵn. Sau khi nhấn 'Gợi ý món ăn AI', hệ thống sẽ đưa ra danh sách 6 đến 8 món ăn. Để giao diện không bị dài và rối mắt, chúng em thiết kế bộ phân trang 3 món mỗi trang với hiệu ứng cuộn mượt mà."*

---

### SLIDE 15: DEMO GIAO DIỆN CLIENT — CHI TIẾT & DINH DƯỠNG
* **Tiêu đề:** MODAL CHI TIẾT CÔNG THỨC & BẢNG DINH DƯỠNG KHOA HỌC
* **Cấu trúc Modal 3 Tab chuyên biệt:**
  * **Tab 1 — Nguyên liệu:** Đánh dấu màu xanh các nguyên liệu có sẵn; liệt kê định lượng gram/muỗng rõ ràng; tách riêng gia vị cần chuẩn bị thêm.
  * **Tab 2 — Hướng dẫn nấu ăn:** Quy trình 4 bước chuẩn bếp: *Sơ chế $\rightarrow$ Tẩm ướp $\rightarrow$ Chế biến $\rightarrow$ Hoàn thiện*.
  * **Tab 3 — Bảng chỉ số Dinh dưỡng:** 8 chỉ số vi chất: Calo, Protein, Carbs, Fat, Fiber, Vitamin C, Canxi, Sắt.
  * **AI Chef Reasoning:** Khối lời khuyên chuyên gia, giải thích mẹo canh lửa và bí quyết giữ trọn dưỡng chất.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Khi người dùng nhấn vào bất kỳ món ăn nào, cửa sổ chi tiết sẽ mở ra với 3 tab khoa học: Tab nguyên liệu đánh dấu xanh rõ ràng cái gì đã có và cái gì cần mua thêm; Tab hướng dẫn nấu 4 bước chi tiết; và Tab dinh dưỡng hiển thị đầy đủ calo cùng lời khuyên của Bếp trưởng AI."*

---

### SLIDE 16: DEMO GIAO DIỆN CLIENT — YÊU THÍCH & LỊCH SỬ
* **Tiêu đề:** SỔ TAY MÓN ĂN YÊU THÍCH & TÁI DÙNG LỊCH SỬ
* **Chức năng hỗ trợ người dùng:**
  * ❤️ **Lưu món yêu thích:** Nhấn icon Trái tim để lưu vào bộ sưu tập cá nhân. Dữ liệu đồng bộ trực tiếp vào bảng `favorite_recipes` trong MySQL.
  * 🕒 **Lịch sử tìm kiếm thông minh:** Lưu trữ danh sách các phiên tìm kiếm gần nhất.
  * 🔄 **Tính năng 'Dùng lại' (Re-use):** Chỉ với 1 cú click vào nút *'Dùng lại'*, toàn bộ tập nguyên liệu của ngày hôm trước sẽ được tự động điền vào ô tìm kiếm, tiết kiệm thời gian thao tác.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Hai tính năng cá nhân hóa quan trọng là Sổ tay món ăn yêu thích và Lịch sử tìm kiếm. Người dùng có thể bấm lưu những món ngon để nấu lại sau này. Đặc biệt, nút 'Dùng lại' trong lịch sử cho phép tải lại tập nguyên liệu cũ chỉ với 1 cú nhấp chuột."*

---

### SLIDE 17: DEMO GIAO DIỆN ADMIN — QUẢN TRỊ KHO MÓN & ẢNH
* **Tiêu đề:** DASHBOARD QUẢN TRỊ KHO DỮ LIỆU & KIỂM SOÁT ẢNH COOKPAD
* **Công cụ dành cho Quản trị viên:**
  * 📊 **Thống kê thời gian thực:** Đo lường KPI tổng số người dùng, số món ăn trong kho (552 món), tổng lượt gợi ý AI.
  * 🖼️ **Quản lý kho ảnh Cookpad:** Lọc món theo 7 danh mục, tìm kiếm theo tên hoặc nguyên liệu.
  * ✏️ **Chỉnh sửa & Ghi đè ảnh:** Cho phép Admin tự tay copy link ảnh đẹp trên mạng dán vào ô URL để cập nhật CSDL ngay lập tức.
  * 🔒 **Quản lý tài khoản:** Khóa/mở khóa người dùng vi phạm, đặt lại mật khẩu an toàn.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Tại trang quản trị, Admin có cái nhìn toàn cảnh về tình trạng hệ thống. Đặc biệt, theo đúng yêu cầu kiểm soát chất lượng, Admin có thể tìm kiếm bất kỳ món nào trong kho 552 món và tự tay dán link hình ảnh chất lượng cao để cập nhật trực tiếp vào MySQL."*

---

### SLIDE 18: KẾT QUẢ THỰC NGHIỆM ĐỊNH LƯỢNG
* **Tiêu đề:** KẾT QUẢ ĐO LƯỜNG THỰC NGHIỆM ĐỊNH LƯỢNG (150 KỊCH BẢN)
* **Bảng số liệu kiểm thử thực tế:**

| Chỉ số đo lường | Chế độ AI (Gemini) | Chế độ Fallback (MySQL) |
|---|:---:|:---:|
| **Thời gian phản hồi trung bình** | **3,42 giây** | **0,21 giây** |
| **Tỷ lệ phân tích JSON hợp lệ** | **100%** | **100%** |
| **Tỷ lệ đa dạng phương pháp chế biến** | **98,6%** | **84,2%** |
| **Tỷ lệ bám sát nguyên liệu đầu vào** | **97,8%** | **94,5%** |
| **Tỷ lệ triệt tiêu ảo giác thịt cá lạ** | **100%** | **100%** |
| **Tỷ lệ gán hình ảnh chính xác** | **94,6%** | **98,2%** |
| **Độ hài lòng người dùng (thang 5⭐)** | **4,8 / 5,0** | **4,2 / 5,0** |

* **Đánh giá:** Chế độ AI vượt trội về độ phong phú công thức; Chế độ Fallback áp đảo về tốc độ phản hồi và độ chuẩn xác ảnh.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Nhóm đã tiến hành kiểm thử thực nghiệm trên 150 kịch bản nguyên liệu khác nhau. Kết quả cho thấy cả hai chế độ đều đạt tỷ lệ 100% triệt tiêu ảo giác thịt cá lạ. Chế độ AI đạt điểm hài lòng 4.8/5 sao nhờ sự đa dạng, trong khi chế độ Fallback phản hồi cực nhanh chỉ 0,21 giây."*

---

### SLIDE 19: KẾT LUẬN & HƯỚNG PHÁT TRIỂN TƯƠNG LAI
* **Tiêu đề:** KẾT LUẬN & PHƯƠNG HƯỚNG MỞ RỘNG
* **Kết luận đạt được:**
  * ✅ Hoàn thành toàn diện các mục tiêu nghiên cứu và triển khai đề ra.
  * ✅ Chứng minh tính hiệu quả của mô hình Grounded RAG trong việc ứng dụng LLM vào bài toán thực tiễn.
  * ✅ Triển khai thành công hệ thống trên môi trường đám mây thực tế (Vercel & Render).
* **4 Hướng phát triển tiềm năng:**
  1. 📷 **Tích hợp Computer Vision:** Dùng mô hình YOLOv8 nhận diện trực tiếp thực phẩm từ ảnh chụp khay tủ lạnh.
  2. 📅 **Lập kế hoạch thực đơn tuần (Weekly Meal Planner):** Tự động cân đối calo 7 ngày theo thể trạng (Keto, Gym, tiểu đường).
  3. 📱 **Ứng dụng Mobile đa nền tảng:** Phát triển ứng dụng React Native / Flutter kèm thông báo hạn sử dụng thực phẩm.
  4. 👥 **Mạng xã hội ẩm thực:** Cho phép người dùng chia sẻ ảnh món ăn đã nấu và bình chọn công thức AI.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Đồ án đã khẳng định tính khả thi và ứng dụng thực tiễn cao của Trí tuệ Nhân tạo trong đời sống. Trong tương lai, nhóm dự kiến sẽ tích hợp thêm mô hình thị giác máy tính YOLOv8 để người dùng chỉ cần chụp ảnh tủ lạnh là hệ thống tự nhận diện, cũng như phát triển ứng dụng di động hoàn chỉnh."*

---

### SLIDE 20: LỜI CẢM ƠN & PHIÊN HỎI ĐÁP (Q&A)
* **Tiêu đề:** CHÂN THÀNH CẢM ƠN QUÝ THẦY CÔ & HỘI ĐỒNG!
* **Thông điệp:**
  * *"Chúng em xin trân trọng cảm ơn Thầy TS. Đỗ Phúc Hảo đã tận tình định hướng và giúp đỡ chúng em hoàn thành đồ án này."*
  * *"Xin trân trọng cảm ơn quý Thầy Cô trong Hội đồng chấm đồ án Khoa Công nghệ Thông tin đã lắng nghe phần báo cáo."*
* **Thông tin dự án:**
  * 🌐 **Live Demo:** `https://do-an-tri-tue-nhan-tao-nu.vercel.app`
  * 💻 **GitHub Repository:** `https://github.com/T-glonk/DoAnTriTueNhanTao.git`
* **PHIÊN HỎI ĐÁP (Q&A):** *Nhóm kính mời quý Thầy Cô trong Hội đồng đặt câu hỏi và đóng góp ý kiến!*

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Phần trình bày của nhóm chúng em đến đây là kết thúc. Chúng em xin chân thành cảm ơn quý Thầy Cô trong Hội đồng đã dành thời gian lắng nghe. Nhóm chúng em rất mong nhận được những ý kiến nhận xét và đóng góp quý báu từ quý Thầy Cô để đồ án ngày càng hoàn thiện hơn. Em xin trân trọng cảm ơn!"*
