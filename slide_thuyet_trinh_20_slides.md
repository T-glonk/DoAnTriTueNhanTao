# 📊 KỊCH BẢN & NỘI DUNG 20 SLIDE BÁO CÁO ĐỒ ÁN TRÍ TUỆ NHÂN TẠO

**Đề tài:** HỆ THỐNG AI GỢI Ý MÓN ĂN THEO NGUYÊN LIỆU (FoodAI)  
**Sinh viên thực hiện:** Phạm Tấn Hào (2351220282) - Trần Quốc Trung (2351220096)  
**Giảng viên hướng dẫn:** TS. Đỗ Phúc Hảo  
**Trường:** Đại học Kiến trúc Đà Nẵng — Khoa Công nghệ Thông tin — Lớp: 23CT2  

---

## SLIDE 1: GIỚI THIỆU ĐỀ TÀI (Title Slide)
* **Tiêu đề lớn:** HỆ THỐNG AI GỢI Ý MÓN ĂN THEO NGUYÊN LIỆU
* **Phụ đề:** Ứng dụng Mô hình Ngôn ngữ Lớn Google Gemini AI kết hợp Kiến trúc Grounded RAG và Cơ sở Dữ liệu Ẩm thực Việt Nam
* **Thông tin nhóm tác giả:**
  * Sinh viên 1: **Phạm Tấn Hào** — MSSV: `2351220282`
  * Sinh viên 2: **Trần Quốc Trung** — MSSV: `2351220096`
* **Lớp:** 23CT2 — Ngành Công nghệ Thông tin
* **Giảng viên hướng dẫn:** **TS. Đỗ Phúc Hảo**
* **Đơn vị:** Trường Đại học Kiến trúc Đà Nẵng — Khoa Công nghệ Thông tin
* **Năm học:** 2025 – 2026

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Kính thưa quý Thầy Cô trong Hội đồng chấm đồ án tốt nghiệp và các bạn sinh viên. Hôm nay, nhóm chúng em gồm Phạm Tấn Hào và Trần Quốc Trung, dưới sự hướng dẫn tận tình của TS. Đỗ Phúc Hảo, xin được vinh hạnh báo cáo đồ án môn học Trí tuệ Nhân tạo với đề tài: 'Hệ thống AI gợi ý món ăn theo nguyên liệu - FoodAI'."*

---

## SLIDE 2: NỘI DUNG THUYẾT TRÌNH (Agenda / Outline)
* **Bố cục bài báo cáo gồm 5 phần chính:**
  1. **Đặt vấn đề & Mục tiêu nghiên cứu:** Bối cảnh thực tế, vấn đề ảo giác của AI và giải pháp đề xuất.
  2. **Cơ sở lý thuyết & Công nghệ:** Google Gemini AI, Grounded RAG, NLP tiếng Việt, Tech Stack.
  3. **Phân tích thiết kế & Giải thuật:** Kiến trúc 3 tầng, quy trình RAG 4 bước, thuật toán lọc ràng buộc, thiết kế CSDL.
  4. **Cài đặt & Kết quả thử nghiệm:** Giao diện người dùng, trang quản trị Admin, đánh giá định lượng hiệu năng.
  5. **Kết luận & Hướng phát triển:** Đóng góp của đề tài và định hướng nâng cấp trong tương lai.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Bài thuyết trình của nhóm em được cấu trúc thành 5 phần mạch lạc: đi từ lý do hình thành đề tài, cơ sở công nghệ, giải thuật lõi giải quyết bài toán ảo giác AI, kết quả thực nghiệm hệ thống và cuối cùng là định hướng phát triển."*

---

## SLIDE 3: BỐI CẢNH THỰC TẾ & BÀI TOÁN ĐẶT RA
* **Thực trạng đời sống:**
  * Câu hỏi thường nhật của hàng triệu người nội trợ: *"Hôm nay ăn gì?"*, *"Tủ lạnh còn những gì để nấu?"*.
  * Hàng tuần có lượng lớn thực phẩm tươi sống, rau củ bị bỏ phí do không biết cách chế biến kết hợp.
* **Hạn chế của các phương pháp truyền thống:**
  * Bắt buộc phải biết trước tên món ăn mới tra cứu được công thức.
  * Các ứng dụng tìm kiếm từ khóa thông thường so khớp máy móc, nghèo nàn kết quả.
  * Thiếu bảng phân tích định lượng dinh dưỡng khoa học (calo, đạm, béo, chất xơ) phục vụ sức khỏe.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Xuất phát từ thực tế, người nội trợ hay sinh viên thường mở tủ lạnh và bối rối vì không biết những nguyên liệu còn lại có thể nấu được món gì. Các website tra cứu hiện nay đều đòi hỏi người dùng phải biết sẵn tên món mới tìm được, dẫn đến việc nguyên liệu thừa bị bỏ phí và tốn kém chi phí sinh hoạt."*

---

## SLIDE 4: THÁCH THỨC CỦA LLM THUẦN TÚY & Ý TƯỞNG GIẢI PHÁP
* **Vấn đề cốt lõi khi ứng dụng AI:**
  * Các Mô hình Ngôn ngữ Lớn (LLM) có khả năng sáng tạo rất cao, nhưng gặp nhược điểm nghiêm trọng là **Ảo giác (Hallucination)**.
  * Khi người dùng chỉ nhập *"Trứng, Cà chua"*, AI thuần túy có xu hướng tự bịa thêm *"Thịt bò, Tôm sú"* để công thức hấp dẫn hơn $\rightarrow$ Vi phạm nguyên tắc có sẵn của người dùng.
* **Giải pháp đột phá của FoodAI:**
  * Đề xuất mô hình **Grounded RAG (Retrieval-Augmented Generation)**: AI **chỉ được phép phân tích dựa trên danh sách món ăn thực tế được truy xuất từ CSDL MySQL**.
  * Kết hợp bộ lọc ràng buộc ngữ nghĩa tiếng Việt để triệt tiêu hoàn toàn hiện tượng tự bịa nguyên liệu lạ.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Nếu chỉ dùng ChatGPT hay Gemini thuần túy để hỏi, AI sẽ thường xuyên bị 'ảo giác' - tự bịa thêm thịt bò, tôm đắt tiền mà người dùng không hề có. Giải pháp của nhóm em là khóa chặt AI bằng kỹ thuật Grounded RAG: CSDL nội bộ lọc ra món thực tế trước, AI chỉ đóng vai trò Đầu bếp phân tích dinh dưỡng và thời gian nấu, không được tự ý bịa món."*

---

## SLIDE 5: MỤC TIÊU VÀ PHẠM VI NGHIÊN CỨU
* **Mục tiêu tổng quát:**
  * Xây dựng nền tảng Web thông minh hỗ trợ gợi ý 6–8 món ăn Việt Nam từ nguyên liệu có sẵn, tính toán dinh dưỡng chi tiết và kèm ảnh thực tế sắc nét.
* **Mục tiêu cụ thể:**
  1. Xây dựng kho tri thức ẩm thực với **552 món ăn Việt Nam** và hơn **2.000 hình ảnh Cookpad CDN**.
  2. Tích hợp **Google Gemini AI** phân tích 8 chỉ số dinh dưỡng (Calo, Protein, Carbs, Fat, Fiber, Ca, Fe, Vit C).
  3. Cài đặt thuật toán NLP tiếng Việt loại bỏ sai lệch từ vựng (*mắm tôm* $\ne$ *tôm*, *cà chua* $\ne$ *cá*).
  4. Cơ chế phân trang 3 món/trang và tự động dự phòng (Fallback) khi mất kết nối mạng.
* **Phạm vi:** Ẩm thực gia đình Việt Nam, giao diện Web Single Page Application (SPA) responsive.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Đề tài đặt ra 4 mục tiêu cụ thể: xây dựng kho dữ liệu 552 món Cookpad, tích hợp Gemini AI phân tích dinh dưỡng khoa học, xử lý triệt để bất đồng ngữ nghĩa tiếng Việt và xây dựng cơ chế Fallback đảm bảo hệ thống luôn sẵn sàng 100%."*

---

## SLIDE 6: TỔNG QUAN HỆ THỐNG CÔNG NGHỆ (TECH STACK)
* **Frontend:**
  * React 18, TypeScript, Vite: Đảm bảo tốc độ render cực nhanh và an toàn kiểu dữ liệu.
  * Tailwind CSS, Lucide Icons, Recharts: Giao diện hiện đại, trực quan, biểu đồ tương tác cao.
* **Backend:**
  * Node.js, Express, TypeScript: Kiến trúc RESTful API mô-đun hóa, xử lý bất đồng bộ mượt mà.
  * JWT (JSON Web Token) & Bcrypt: Bảo mật xác thực người dùng và phân quyền Admin/User.
* **AI & Database:**
  * **Google Gemini AI** (`@google/generative-ai`): Động cơ tính toán dinh dưỡng & công thức ẩm thực.
  * **MySQL 8.0**: Lưu trữ quan hệ chuẩn 3NF (hỗ trợ cả Localhost và Cloud TiDB Serverless).

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Về mặt công nghệ, hệ thống áp dụng toàn diện hệ sinh thái JavaScript/TypeScript hiện đại với React 18 ở Frontend, Node.js Express ở Backend, CSDL quan hệ MySQL và Google Gemini AI làm động cơ trí tuệ nhân tạo."*

---

## SLIDE 7: KIẾN TRÚC TỔNG THỂ HỆ THỐNG (3-Tier Architecture)
* **Tầng 1 - Giao diện (Client Layer):**
  * Single Page Application (SPA), Client-side Routing, State Management với React Context.
* **Tầng 2 - Máy chủ Ứng dụng (Server Layer):**
  * `Auth Middleware`: Xác thực JWT, kiểm soát `is_active` và phân quyền `role`.
  * `Rate Limiter`: Chặn tấn công từ chối dịch vụ (DDoS / Brute-force).
  * `Gemini Service`: Xử lý Prompt Engineering và trích xuất JSON kiên cố.
  * `Recipe Service`: Thuật toán so khớp Heuristic và lọc ràng buộc nguyên liệu.
  * `Image Service`: Thuật toán chấm điểm và kiểm soát ảnh Cookpad.
* **Tầng 3 - Dữ liệu & Dịch vụ Ngoài (Data & Services Layer):**
  * MySQL Database (Users, Recipes, Nutrition, Favorites, History).
  * Google Gemini API (Cloud LLM Engine) & Cookpad CDN.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Kiến trúc hệ thống được phân lớp nghiêm ngặt thành 3 tầng rõ ràng. Tầng ứng dụng bóc tách các Service độc lập, giúp mã nguồn đạt tính gắn kết cao, dễ bảo trì, mở rộng và kiểm thử đơn vị."*

---

## SLIDE 8: LUỒNG GỢI Ý MÓN ĂN GROUNDED RAG (LÕI AI)
* **Quy trình 4 bước thực thi:**
  * **Bước 1 (Truy vấn CSDL):** Backend nhận nguyên liệu người dùng nhập, truy vấn kho MySQL để chọn ra danh sách 6–8 món ăn thực tế có sẵn ảnh Cookpad khớp từ khóa nhất.
  * **Bước 2 (Gửi ngữ cảnh cho AI):** Đưa danh sách món ăn từ CSDL vào Prompt của Gemini AI, áp đặt quy tắc: *Bắt buộc giữ nguyên Tên và ID món ăn từ CSDL, không được tự tạo món mới*.
  * **Bước 3 (AI Enrichment):** Gemini AI tính toán 8 chỉ số dinh dưỡng, thời gian nấu, định lượng khẩu phần và viết lời khuyên đầu bếp (`ai_reasoning`).
  * **Bước 4 (Đồng bộ CSDL):** Hệ thống cập nhật các chỉ số dinh dưỡng do AI phân tích vào MySQL để tái sử dụng, không cần gọi lại API cho các lần sau.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Đây là trọng tâm kỹ thuật của đồ án: Luồng Grounded RAG 4 bước. Thay vì để AI tự do sáng tạo tên món, CSDL đóng vai trò mỏ neo định hướng danh sách món thật, AI chỉ tính toán dinh dưỡng và định lượng, sau đó dữ liệu được cập nhật ngược về CSDL."*

---

## SLIDE 9: XỬ LÝ NGÔN NGỮ TỰ NHIÊN TIẾNG VIỆT (Vietnamese NLP)
* **Thách thức của tiếng Việt trong ẩm thực:**
  * Chữ có dấu, biến thể vùng miền: *thịt lợn* = *thịt heo* = *ba chỉ*; *hột gà* = *trứng gà*.
  * Hiện tượng dính chữ gây nhầm lẫn nguy hiểm: *cà chua* chứa chữ *cá*, *mắm tôm* chứa chữ *tôm*, *bơ tỏi* chứa chữ *bò*, *đậu gà* chứa chữ *gà*.
* **Giải pháp cài đặt trong hệ thống:**
  1. Chuẩn hóa NFD Unicode và loại bỏ dấu thanh để so khớp mẫu.
  2. Kiểm tra ranh giới từ nguyên vẹn (Whole-word Regex Boundary `\b`).
  3. Xây dựng **Từ điển Nhóm nguyên liệu đồng nghĩa** kèm **Bộ từ khóa loại trừ (Negative Excludes)**.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Xử lý tiếng Việt là bài toán cực kỳ dễ sai lệch nếu chỉ so chuỗi đơn thuần. Ví dụ người dùng gõ 'cà chua', nếu không có bộ lọc loại trừ, thuật toán sẽ nhầm thành nguyên liệu 'cá'. Nhóm đã cài đặt ma trận từ điển đồng nghĩa và danh sách Negative Excludes để loại trừ triệt để lỗi này."*

---

## SLIDE 10: THUẬT TOÁN LỌC RÀNG BUỘC & CHẤM ĐIỂM ĐA TIÊU CHÍ
* **Bộ lọc loại trừ cứng (Hard Constraints):**
  * *Nguyên tắc bảo vệ Protein:* Nếu người dùng không nhập thịt/cá $\rightarrow$ Loại bỏ 100% các món mặn chứa thịt cá.
  * *Nguyên tắc đơn nhất:* Nếu người dùng chỉ có 1 loại thịt (ví dụ: Thịt bò) $\rightarrow$ Loại bỏ các món đòi hỏi cả thịt heo/tôm/mực mà người dùng không có.
* **Công thức chấm điểm ưu tiên (Ranking Formula):**
  $$\text{Score} = (\text{Số nguyên liệu khớp} \times 100) + (\text{Tên món chứa từ khóa} \times 50) + (\text{Khớp đúng loại đạm chính} \times 150)$$
  * Các món có tên chứa trực tiếp nguyên liệu chính (ví dụ: *Trứng sốt cà chua*, *Bò lúc lắc*) đạt điểm cao nhất và xếp Top 1.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Hệ thống áp dụng công thức chấm điểm đa tiêu chí: ưu tiên món khớp nhiều nguyên liệu nhất, tên món chứa từ khóa chính và đúng loại đạm. Các món phụ chỉ khớp 1 nguyên liệu sẽ bị điểm thấp và tự động bị đẩy xuống hoặc loại bỏ."*

---

## SLIDE 11: THIẾT KẾ CƠ SỞ DỮ LIỆU & KHO ẨM THỰC THỰC TẾ
* **Mô hình CSDL chuẩn 3NF (9 bảng quan hệ):**
  * `users`: Quản lý tài khoản, mã hóa BCrypt, cờ `is_active`, quyền `role`.
  * `recipes`: Kho 552 món ăn chuẩn Việt Nam (tên, mô tả, ảnh, độ khó, thời gian, khẩu phần).
  * `recipe_ingredients`, `recipe_steps`, `recipe_nutrition`: Chi tiết nguyên liệu, 4 bước nấu và 8 chỉ số dinh dưỡng.
  * `favorite_recipes`, `search_history`: Sổ tay yêu thích và lịch sử tìm kiếm người dùng.
  * `cookpad_dish_images`: Kho hơn 2.000 hình ảnh Cookpad CDN sắc nét.
* **Cơ chế Auto-Migration & Auto-Seed:**
  * Backend tự động kiểm tra và khởi tạo bảng, nạp 552 món khi chạy lần đầu, không cần thao tác SQL thủ công.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Cơ sở dữ liệu được thiết kế chuẩn hóa 3NF với 9 bảng. Đặc biệt hệ thống có tính năng Auto-Seed: bất kỳ ai tải dự án về chỉ cần tạo CSDL rỗng, khi backend chạy sẽ tự động nạp toàn bộ 552 món và ảnh vào MySQL."*

---

## SLIDE 12: KIỂM SOÁT HÌNH ẢNH MÓN ĂN & CHỐNG SAI LỆCH
* **Cơ chế 2 lớp bảo vệ tính khớp hình ảnh:**
  * **Lớp 1 - Thuật toán `isImageUrlConflicting`:**
    * Giải mã slug của URL ảnh Cookpad (`thit-bo-xao-hanh-tay-recipe-main-photo.jpg`).
    * Nếu tên món là **Thịt bò** nhưng ảnh chứa từ khóa **gà (`ga`)** hoặc **heo (`heo`)** $\rightarrow$ Thuật toán loại bỏ ảnh ngay lập tức.
    * Tự động lọc các ảnh cơm bento tạo hình trẻ em hoặc ảnh mâm cơm gia đình hỗn hợp.
  * **Lớp 2 - Quyền can thiệp từ Admin Dashboard:**
    * Quản trị viên có thể tự bấm nút Chỉnh sửa trên từng món để dán link ảnh mới theo ý muốn và lưu trực tiếp vào CSDL.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Để giải quyết triệt để vấn đề hình ảnh không khớp với món ăn, nhóm xây dựng bộ lọc tự động kiểm tra slug của URL ảnh, và đồng thời cung cấp giao diện Admin cho phép thay thế link ảnh thủ công mọi lúc."*

---

## SLIDE 13: GIAO DIỆN PHÂN HỆ NGƯỜI DÙNG (Client Web App)
* **Trang chủ tìm kiếm thông minh:**
  * Nhập nguyên liệu dạng tag màu động, hỗ trợ gợi ý nhanh các combo nguyên liệu phổ biến.
  * Phân trang trực quan: Gợi ý tối đa 8 món, hiển thị **3 món/trang** với thanh điều hướng cuộn mượt mà.
* **Modal Chi tiết Món ăn 3 Tab chuyên sâu:**
  * **Tab 1 - Cách làm:** Hướng dẫn 4 bước sơ chế, ướp, nấu và hoàn thiện.
  * **Tab 2 - Định lượng nguyên liệu:** Báo xanh nguyên liệu có sẵn, báo xám gia vị cần thêm.
  * **Tab 3 - Dinh dưỡng khoa học:** Bảng 8 chỉ số vi chất kèm bí quyết canh lửa từ AI Chef.
* **Tính năng cá nhân hóa:** Lưu món yêu thích một chạm (Trái tim), xem lịch sử tìm kiếm và nút *"Dùng lại"* 1-click.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Giao diện người dùng được thiết kế hiện đại, thân thiện. Điểm nhấn là Modal chi tiết 3 Tab vừa hiển thị công thức, vừa định lượng gram nguyên liệu và hiển thị biểu đồ dinh dưỡng khoa học."*

---

## SLIDE 14: GIAO DIỆN PHÂN HỆ QUẢN TRỊ (Admin Dashboard)
* **Các chức năng quản trị then chốt:**
  * **Tổng quan hệ thống:** Thẻ KPI thời gian thực (tổng user, tổng món, lượt query) và biểu đồ Top 10 nguyên liệu được tìm kiếm nhiều nhất.
  * **Quản lý người dùng:** Danh sách tài khoản, tìm kiếm, phân quyền, khóa/mở khóa tài khoản (có chốt an toàn ngăn Admin tự khóa chính mình).
  * **Quản lý Kho Món Ăn & Ảnh Cookpad:** Lọc theo 7 danh mục, tìm kiếm công thức, thêm/sửa/xóa món ăn và cập nhật ảnh trực tiếp vào MySQL.
  * **Giám sát AI Query Logs:** Theo dõi nhật ký truy vấn của người dùng theo thời gian thực.
  * **Cấu hình & Giám sát Hệ thống:** Kiểm tra trạng thái kết nối Gemini AI và tài nguyên CPU/RAM server.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Phân hệ Admin Panel cung cấp đầy đủ công cụ quản trị dữ liệu, giám sát hoạt động của Gemini AI và cho phép quản lý vòng đời tài khoản người dùng an toàn."*

---

## SLIDE 15: CƠ CHẾ DỰ PHÒNG CHỊU LỖI BỀN VỮNG (Fallback Layer)
* **Tính sẵn sàng cao (High Availability):**
  * Trong môi trường thực tế, API của bên thứ ba (Google Gemini) có thể bị mất mạng, timeout hoặc vượt hạn mức (Quota Exceeded).
* **Kiến trúc chuyển mạch tự động:**
  * Khối `try-catch` tại backend bắt lỗi mạng ngay lập tức mà không gây crash server.
  * Tự động chuyển mạch sang hàm `suggestRecipesFromDatabase()`: Tra cứu trực tiếp từ kho 552 món ăn Cookpad MySQL nội bộ bằng giải thuật Heuristic.
  * Thời gian phản hồi chế độ Fallback **chỉ 0,21 giây (< 300ms)**, đảm bảo người dùng luôn nhận được kết quả gợi ý chuẩn xác mà không hề gặp màn hình trắng hay báo lỗi.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Hệ thống được thiết kế theo tư duy chịu lỗi công nghiệp: nếu Google Gemini gặp sự cố mạng hoặc hết hạn mức, tầng Fallback nội bộ sẽ tự động phản hồi chỉ trong 0,21 giây từ CSDL MySQL, trải nghiệm người dùng không bao giờ bị gián đoạn."*

---

## SLIDE 16: KẾT QUẢ KIỂM THỬ HỆ THỐNG
* **Kiểm thử chức năng và trường hợp biên (Bảng 4.1 trong báo cáo):**
  * **TC-01:** Đăng nhập, băm mật khẩu BCrypt, cấp phát token JWT $\rightarrow$ **Đạt (Pass)**.
  * **TC-02:** Nhập nguyên liệu có thịt bò $\rightarrow$ Gợi ý đủ 6-8 món bò kèm dinh dưỡng $\rightarrow$ **Đạt (Pass)**.
  * **TC-03:** Nhập nguyên liệu chay (trứng, đậu, nấm) $\rightarrow$ 100% không có thịt cá lạ $\rightarrow$ **Đạt (Pass)**.
  * **TC-04:** Tắt Internet / Khóa API Key $\rightarrow$ Tự động Fallback sang CSDL MySQL $\rightarrow$ **Đạt (Pass)**.
  * **TC-05:** Người dùng thường truy cập `/admin` $\rightarrow$ Chặn bằng mã lỗi HTTP 403 $\rightarrow$ **Đạt (Pass)**.
  * **TC-06:** Nhập ký tự đặc biệt / chuỗi rỗng $\rightarrow$ Thông báo lỗi tiếng Việt thân thiện $\rightarrow$ **Đạt (Pass)**.

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Toàn bộ 6 kịch bản kiểm thử trọng yếu từ bảo mật, xử lý ngoại lệ đến tính toàn vẹn dữ liệu đều đạt tỷ lệ Pass 100%, khẳng định độ hoàn thiện cao của phần mềm."*

---

## SLIDE 17: ĐÁNH GIÁ ĐỊNH LƯỢNG HIỆU NĂNG
* **Bảng so sánh thực nghiệm (Khảo sát trên 150 kịch bản ngẫu nhiên):**

| Tiêu chí đánh giá | Chế độ AI (Gemini) | Chế độ Fallback (MySQL) |
|---|:---:|:---:|
| **Thời gian phản hồi trung bình** | **3,42 giây** | **0,21 giây** |
| **Tỷ lệ phân tích JSON hợp lệ** | **100%** | **100%** |
| **Tỷ lệ đa dạng phương pháp chế biến** | **98,6%** | 84,2% |
| **Tỷ lệ bám sát nguyên liệu có sẵn** | **97,8%** | 94,5% |
| **Tỷ lệ triệt tiêu ảo giác thịt cá lạ** | **100%** | **100%** |
| **Tỷ lệ gán hình ảnh chính xác** | 94,6% | **98,2%** |
| **Điểm hài lòng người dùng (thang 5 sao)** | **4,8 / 5,0 ⭐** | 4,2 / 5,0 ⭐ |

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Kết quả định lượng cho thấy sự kết hợp hoàn hảo giữa 2 chế độ: Chế độ AI vượt trội về tính sáng tạo (4,8 sao) và tỷ lệ bám sát nguyên liệu (97,8%), trong khi chế độ Fallback tối ưu về tốc độ (0,21 giây) và độ chuẩn xác hình ảnh (98,2%)."*

---

## SLIDE 18: MINH HỌA KỊCH BẢN THỰC TẾ
* **Kịch bản 1: Người dùng chỉ có nguyên liệu đơn giản `[Trứng, Cà chua, Hành lá]`**
  * *Hệ thống gợi ý:* Trứng sốt cà chua, Canh cà chua trứng, Trứng chiên hành lá...
  * *Cam kết:* **Tuyệt đối không bịa thịt cá**, tính toán calo (~220 kcal), hiển thị ảnh thành phẩm chuẩn xác.
* **Kịch bản 2: Người dùng có `[Thịt bò]`**
  * *Hệ thống gợi ý:* Thịt bò xào hành tây, Thịt bò áp chảo, Bò lúc lắc, Canh dưa chua bắp bò...
  * *Giao diện:* Trả về đủ 8 món ăn phân bổ trên 3 trang (Trang 1: 3 món, Trang 2: 3 món, Trang 3: 2 món).

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Trên màn hình là hai kịch bản điển hình: Dù người dùng chỉ có trứng cà chua hay có thịt bò, hệ thống đều đưa ra các món ăn thân thuộc, chuẩn vị Việt Nam, đúng định lượng và hình ảnh chân thực 100%."*

---

## SLIDE 19: KẾT LUẬN & HƯỚNG PHÁT TRIỂN
* **Đóng góp chính của đề tài:**
  1. Đề xuất thành công kiến trúc **Grounded RAG** giải quyết triệt để bài toán ảo giác nguyên liệu của LLM.
  2. Xây dựng hoàn chỉnh ứng dụng Web thực tế với đầy đủ 2 phân hệ Khách hàng và Quản trị viên.
  3. Kho dữ liệu phong phú 552 món ăn và hơn 2.000 hình ảnh Cookpad Việt Nam.
  4. Hệ thống đã triển khai thực tế trên Cloud (Vercel & Render) với tên miền hoạt động ổn định.
* **Hướng phát triển trong tương lai:**
  * Tích hợp **Thị giác máy tính (YOLOv8)**: Chụp ảnh khay tủ lạnh tự động nhận diện nguyên liệu.
  * **Lập kế hoạch thực đơn tuần (Weekly Meal Planner)**: Tự động cân đối calo 7 ngày theo thể trạng người dùng (hỗ trợ giảm cân, Keto, tiểu đường).
  * Phát triển ứng dụng di động đa nền tảng (React Native).

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Đề tài đã hoàn thành xuất sắc các mục tiêu đề ra. Trong tương lai, nhóm sẽ mở rộng thêm tính năng nhận diện thực phẩm qua camera AI và lập thực đơn dinh dưỡng theo tuần cho gia đình."*

---

## SLIDE 20: LỜI CẢM ƠN & HỎI ĐÁP (Q&A)
* **CHÂN THÀNH CẢM ƠN QUÝ THẦY CÔ VÀ CÁC BẠN ĐÃ LẮNG NGHE!**
* **Lời tri ân:** Nhóm xin trân trọng cảm ơn **TS. Đỗ Phúc Hảo** đã tận tình hướng dẫn, định hướng khoa học trong suốt quá trình thực hiện đồ án.
* **Liên kết dự án & Trải nghiệm trực tiếp:**
  * 🌐 **Live Web:** `https://do-an-tri-tue-nhan-tao-nu.vercel.app`
  * 💻 **GitHub Repository:** `https://github.com/T-glonk/DoAnTriTueNhanTao.git`
* **Mời Quý Thầy Cô trong Hội đồng đặt câu hỏi (Q&A)!**

> 🎙️ **Lời thoại thuyết trình (Speaker Notes):**  
> *"Em xin chân thành cảm ơn quý Thầy Cô trong Hội đồng đã chú ý lắng nghe bài báo cáo của nhóm. Chúng em rất mong nhận được những lời nhận xét, góp ý quý báu của quý Thầy Cô để hoàn thiện đề tài hơn nữa. Nhóm chúng em xin sẵn sàng trả lời các câu hỏi của Hội đồng ạ!"*
