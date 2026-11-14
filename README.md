# 🍜 FoodAI — Hệ Thống Gợi Ý Món Ăn Thông Minh Dựa Trên Nguyên Liệu (AI Chef & Nutritionist)

> **Đồ Án Môn Học: Trí Tuệ Nhân Tạo (Artificial Intelligence Capstone Project)**  
> Ứng dụng mô hình ngôn ngữ lớn **Google Gemini AI** kết hợp kiến trúc **Grounded RAG (Retrieval-Augmented Generation)** truy xuất cơ sở dữ liệu thực tế **Cookpad Việt Nam** để gợi ý thực đơn, định lượng nguyên liệu và phân tích dinh dưỡng khoa học.

---

## 🌐 Trải nghiệm Trực tiếp (Live Demo)
Nếu không muốn cài đặt trên máy cá nhân, bạn có thể truy cập và trải nghiệm trực tiếp hệ thống đã được triển khai:
* **Giao diện Web (Frontend - Vercel):** [https://do-an-tri-tue-nhan-tao-nu.vercel.app](https://do-an-tri-tue-nhan-tao-nu.vercel.app)
* **Máy chủ API (Backend - Render):** [https://doantrituenhantao.onrender.com](https://doantrituenhantao.onrender.com)

---

## 🌟 Tính Năng Nổi Bật

1. 🤖 **Đầu bếp & Chuyên gia dinh dưỡng AI (AI Chef & Nutritionist):**
   * Sử dụng Google Gemini AI để tính toán 8 chỉ số dinh dưỡng: Calories, Protein, Carbohydrates, Chất béo (Fat), Chất xơ (Fiber), Canxi, Sắt, Vitamin C.
   * Định lượng khẩu phần (gram, muỗng) và cung cấp 4 bước nấu chi tiết kèm bí quyết đầu bếp (`ai_reasoning`).
2. 📚 **Kho dữ liệu thực tế Cookpad Việt Nam (552 món ăn & 2.000+ ảnh CDN):**
   * Món ăn được lấy từ cơ sở dữ liệu ẩm thực Việt Nam, kèm ảnh thành phẩm thực tế sắc nét từ Cookpad CDN (`img-global.cpcdn.com`).
   * Cơ chế **Grounded RAG**: AI chỉ phân tích trên các món ăn thực tế có trong kho CSDL, tuyệt đối **không tự bịa món ăn ngoài đời thực**.
3. 🎯 **Thuật toán lọc và chấm điểm chuẩn xác (Smart Ingredient Matching):**
   * Tự động loại trừ các món thịt khi người dùng chỉ có rau củ/trứng.
   * Ngăn chặn dính chữ gia vị gây nhầm lẫn (*mắm tôm* $\ne$ *tôm tươi*, *cà chua* $\ne$ *cá*, *dầu hào* $\ne$ *hàu*).
   * Chống xung đột ảnh: Loại bỏ các ảnh có slug mâu thuẫn với tên món ăn.
4. 📑 **Phân trang trực quan (Pagination):**
   * Hệ thống gợi ý tối đa 8 món ăn tối ưu nhất, chia làm 3 món/trang với thanh chuyển trang tiện lợi.
5. 🛡️ **Hệ thống Quản trị Dashboard:**
   * Quản lý người dùng, phân quyền Admin/User.
   * Quản lý kho món ăn, cho phép Admin tự tay chỉnh sửa thông tin hoặc dán link ảnh mới cập nhật thẳng vào MySQL.
   * Xem lịch sử tìm kiếm và thống kê nguyên liệu phổ biến.

---

## 🛠️ Công Nghệ Sử Dụng

| Tầng hệ thống | Công nghệ / Thư viện |
|---------------|----------------------|
| **Frontend** | React 18, TypeScript, Vite, Tailwind CSS, Lucide React, Recharts |
| **Backend** | Node.js, Express, TypeScript, RESTful API |
| **Trí tuệ nhân tạo (AI)** | Google Gemini API (`@google/generative-ai`) |
| **Cơ sở dữ liệu** | MySQL 8.0 / MySQL Workbench (Hỗ trợ cả Localhost & Cloud TiDB/Aiven) |
| **Xác thực & Bảo mật** | JSON Web Token (JWT) & Bcrypt password hashing |

---

## ⚡ Hướng Dẫn Cài Đặt & Chạy Nhanh Cho Người Mới (Quick Start)

Dự án đã được tích hợp cơ chế **Tự động tạo bảng & Nạp sẵn dữ liệu (Auto-Migration & Auto-Seed)**. Bất kỳ ai tải thư mục dự án về máy đều có thể khởi chạy chỉ qua **3 bước đơn giản**:

### 📋 Yêu cầu tiên quyết:
* Đã cài đặt [Node.js](https://nodejs.org/) (phiên bản 18 hoặc 20+).
* Đã cài đặt [MySQL Server](https://dev.mysql.com/downloads/mysql/) (hoặc XAMPP, MySQL Workbench).

---

### Bước 1: Cài đặt thư viện (Dependencies)
Mở cửa sổ dòng lệnh (Terminal / PowerShell / CMD) tại thư mục gốc của dự án và chạy:

```bash
# Cài đặt toàn bộ thư viện cho cả Root, Backend và Frontend chỉ bằng 1 lệnh:
npm run install:all
```

---

### Bước 2: Tạo Cơ sở dữ liệu & Cấu hình môi trường

1. Mở **MySQL Workbench** (hoặc CMD MySQL / phpMyAdmin), chạy câu lệnh tạo CSDL rỗng:
   ```sql
   CREATE DATABASE foodai CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```
   *(Lưu ý: Bạn chỉ cần tạo Database rỗng, **KHÔNG CẦN** import thủ công file SQL nào vì Backend sẽ tự động tạo 9 bảng và nạp sẵn 552 món ăn khi khởi động).*

2. Vào thư mục `backend/`, copy file `.env.example` thành `.env`:
   * **Trên Windows PowerShell:**
     ```powershell
     Copy-Item backend\.env.example backend\.env
     ```
   * **Trên Linux / macOS:**
     ```bash
     cp backend/.env.example backend/.env
     ```

3. Mở file `backend/.env` và cập nhật thông tin MySQL & Gemini API Key của bạn:
   ```env
   PORT=5001
   NODE_ENV=development
   JWT_SECRET=food-recommendation-super-secret-jwt-key-2024
   JWT_EXPIRES_IN=7d

   # Điền thông tin MySQL của bạn:
   DB_HOST=localhost
   DB_PORT=3306          # hoặc 3307 tùy cấu hình máy bạn
   DB_USER=root
   DB_PASSWORD=mat_khau_mysql_cua_ban
   DB_NAME=foodai

   # Lấy khóa API Google Gemini hoàn toàn miễn phí tại: https://aistudio.google.com/app/apikey
   GEMINI_API_KEY=AIzaSy...

   CORS_ORIGIN=http://localhost:5173
   ```

---

### Bước 3: Khởi chạy Dự án (Chỉ 1 lệnh duy nhất)

Tại thư mục gốc của dự án, chạy lệnh:

```bash
npm run dev
```

> **Lệnh này sẽ tự động khởi động đồng thời cả Backend (Port 5001) và Frontend (Port 5173).**
> Khi Backend khởi động lần đầu, màn hình sẽ hiển thị:
> * `✅ Tạo bảng CSDL thành công`
> * `✅ Đã tạo tài khoản Admin & User`
> * `✅ Đã nạp thành công 552 món ăn từ Cookpad vào MySQL`

Bây giờ bạn mở trình duyệt web và truy cập vào: **http://localhost:5173** để sử dụng ứng dụng!

---

*(Tùy chọn: Nếu muốn chạy riêng biệt từng Terminal)*
* **Terminal 1 (Backend):** `npm run dev:backend`
* **Terminal 2 (Frontend):** `npm run dev:frontend`

---

## 🔑 Tài Khoản Đăng Nhập Mặc Định

Hệ thống đã tạo sẵn 2 tài khoản mẫu trong cơ sở dữ liệu để kiểm thử ngay lập tức:

| Vai trò | Email đăng nhập | Mật khẩu | Quyền hạn |
|---------|-----------------|----------|-----------|
| **Quản trị viên (Admin)** | `admin@foodsystem.com` | `Admin@123456` | Toàn quyền quản trị kho món ăn, chỉnh sửa ảnh, quản lý user, xem thống kê |
| **Người dùng (User)** | `user@foodsystem.com` | `User@123456` | Gợi ý món ăn, lưu yêu thích, xem lịch sử gợi ý, trang cá nhân |

*(Bạn cũng có thể tự bấm nút "Đăng ký" trên giao diện để tạo tài khoản mới).*

---

## 📂 Cấu Trúc Thư Mục Dự Án

```
Xay_dung_he_thong_goi_y_mon_an/
├── backend/                             # Máy chủ API (Node.js + Express + TypeScript)
│   ├── data/                            # Kho dữ liệu tĩnh JSON (552 món ăn & ảnh Cookpad)
│   │   ├── cookpad_recipes.json
│   │   └── cookpad_dish_images.json
│   ├── sql/                             # File schema SQL dự phòng
│   └── src/
│       ├── database/                    # Kết nối MySQL Pool & Auto-Seed (init.ts)
│       ├── middleware/                  # Xác thực JWT (auth.ts)
│       ├── routes/                      # API routes (recipe, auth, admin, user)
│       ├── services/                    # Lõi xử lý thông minh:
│       │   ├── gemini.service.ts        # Gọi Google Gemini AI tính dinh dưỡng & thời gian
│       │   ├── recipe.service.ts        # Thuật toán so khớp nguyên liệu & lọc CSDL
│       │   └── image.service.ts         # Quản lý hình ảnh Cookpad & chống sai ảnh
│       └── index.ts                     # Điểm khởi chạy server backend
├── frontend/                            # Giao diện người dùng (React + Vite + Tailwind)
│   └── src/
│       ├── components/                  # Các component UI tái sử dụng
│       ├── context/                     # Context quản lý Auth và thông tin user
│       ├── lib/                         # Cấu hình Axios API client
│       └── pages/                       # Các trang màn hình:
│           ├── user/HomePage.tsx        # Trang chủ gợi ý món ăn, chọn nguyên liệu
│           ├── user/FavoritesPage.tsx   # Trang danh sách món yêu thích
│           ├── user/HistoryPage.tsx     # Lịch sử tìm kiếm
│           └── admin/                   # Các trang quản trị Dashboard, Recipes, Users
├── do-an.pdf                            # Báo cáo đồ án hoàn chỉnh (68 trang)
├── package.json                         # Scripts khởi chạy nhanh toàn bộ dự án
└── README.md                            # Tài liệu hướng dẫn sử dụng
```

---

## ❓ Câu Hỏi Thường Gặp & Xử Lý Sự Cố (FAQ / Troubleshooting)

### 1. Backend báo lỗi: `ECONNREFUSED` hoặc không kết nối được MySQL?
* Kiểm tra xem dịch vụ MySQL Server trên máy của bạn đã được bật chưa (kiểm tra Services trong Windows hoặc bật MySQL trong XAMPP).
* Kiểm tra cổng kết nối: mặc định MySQL dùng cổng `3306`, nếu bạn cài đặt MySQL 8.0 phụ dùng cổng `3307`, hãy sửa `DB_PORT=3307` trong file `backend/.env`.
* Đảm bảo đã chạy câu lệnh `CREATE DATABASE foodai;` trước khi chạy backend.

### 2. Báo lỗi `Chưa cấu hình GEMINI_API_KEY hợp lệ`?
* Bạn chỉ cần truy cập [Google AI Studio](https://aistudio.google.com/app/apikey), đăng nhập bằng tài khoản Google, nhấn **"Create API key"** (hoàn toàn miễn phí, không yêu cầu thẻ tín dụng).
* Dán khóa API vào biến `GEMINI_API_KEY` trong file `backend/.env`.

### 3. Có cần phải import file SQL thủ công không?
* **Không cần.** Hàm `initializeDatabase()` trong `backend/src/database/init.ts` sẽ tự động phát hiện nếu bảng chưa có và tự động khởi tạo bảng, tạo tài khoản Admin/User và nạp đủ 552 món ăn Cookpad vào CSDL.

---

## 👨‍💻 Tác giả & Đồ Án
* **Tên đồ án:** Hệ thống Gợi ý Món ăn Thông minh Dựa trên Nguyên liệu có sẵn tích hợp Trí tuệ Nhân tạo.
* **Môn học:** Đồ Án Trí Tuệ Nhân Tạo.
* **Báo cáo chi tiết:** Tham khảo file [do-an.pdf](do-an.pdf) trong thư mục gốc.
