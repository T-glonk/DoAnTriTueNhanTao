# 🍜 FoodAI — Đồ Án Trí Tuệ Nhân Tạo: Hệ Thống Gợi Ý Món Ăn Thông Minh

Hệ thống AI gợi ý món ăn thông minh dựa trên nguyên liệu có sẵn, tích hợp **Google Gemini AI**, tính toán dinh dưỡng chi tiết khoa học, hướng dẫn nấu ăn chuẩn vị và liên kết kho dữ liệu hình ảnh ẩm thực **Cookpad Việt Nam**.

---

## 🌟 Tính năng nổi bật

- 🤖 **AI Chef & Nutritionist (Google Gemini AI)**: Phân tích nguyên liệu người dùng nhập, sáng tạo công thức chuẩn vị Việt, tính toán đầy đủ 8 chỉ số dinh dưỡng (Calories, Protein, Carbs, Fat, Fiber, Vitamin C, Calcium, Iron) và đưa ra bí quyết đầu bếp (`ai_reasoning`).
- 🖼️ **Kho dữ liệu Cookpad Việt Nam**: Hơn 540+ món ăn thực tế và 1.300+ hình ảnh chất lượng cao 1200x630, cơ chế tự động cào và gán ảnh độc nhất, không bị trùng lặp.
- 🎯 **Chống sai lệch nguyên liệu**: Thuật toán loại trừ thông minh ngăn chặn dính chữ gia vị (`mắm tôm` != `tôm`, `cà chua` != `cá`, `dầu hào` != `hàu`, `đậu gà` != `gà`) và ngăn chặn AI tự bịa thịt khi người dùng chỉ nhập rau củ.
- 🍳 **Đa dạng hóa phương pháp nấu**: Gợi ý đa dạng đầy đủ các thể loại: Món xào, Món canh/súp, Món chiên/rán, Món kho/rim, Salad/Gỏi, Điểm tâm/Ăn sáng.
- ❤️ **Yêu thích & Lịch sử**: Lưu trữ món ăn yêu thích, xem lại lịch sử tìm kiếm và đồng bộ CSDL MySQL.
- 👥 **Admin Dashboard**: Quản lý người dùng, xem biểu đồ thống kê nguyên liệu phổ biến, quản lý trạng thái tài khoản.

---

## 🛠️ Công nghệ sử dụng

| Thành phần | Công nghệ |
|------------|-----------|
| **Frontend** | React 18, Vite, TypeScript, Tailwind CSS, Lucide React, Recharts |
| **Backend** | Node.js, Express, TypeScript, RESTful API |
| **Trí tuệ nhân tạo (AI)** | Google Gemini API (`@google/generative-ai`) |
| **Cơ sở dữ liệu** | MySQL 8.0 / MySQL Workbench |
| **Xác thực** | JSON Web Token (JWT) & Bcrypt |
| **Dữ liệu ẩm thực** | Cookpad VN Scraper & HD Image Registry |

---

## 🚀 Hướng dẫn Cài đặt & Khởi chạy

### 1. Yêu cầu hệ thống
- Node.js >= 18
- MySQL Server (Port 3306 hoặc 3307)

### 2. Cài đặt Dependencies
```bash
# Cài đặt root dependencies
npm install

# Cài đặt backend
npm install --prefix backend

# Cài đặt frontend
npm install --prefix frontend
```

### 3. Cấu hình Môi trường (`.env`)
Sao chép `.env.example` thành `.env` trong thư mục `backend/`:
```env
PORT=5001
NODE_ENV=development
JWT_SECRET=food-recommendation-super-secret-jwt-key

DB_HOST=localhost
DB_PORT=3307
DB_USER=root
DB_PASSWORD=your_mysql_password
DB_NAME=foodai

GEMINI_API_KEY=your_google_gemini_api_key
CORS_ORIGIN=http://localhost:5173
```

### 4. Khởi tạo Cơ sở dữ liệu MySQL
Import file schema tại: `backend/sql/01_mysql_schema.sql` vào MySQL Workbench hoặc hệ thống tự động khởi tạo khi backend chạy.

### 5. Chạy Dự án
```bash
# Terminal 1: Chạy Backend (cổng 5001)
npm run dev --prefix backend

# Terminal 2: Chạy Frontend (cổng 5173)
npm run dev --prefix frontend
```

Truy cập giao diện Web tại: **http://localhost:5173**

---

## 🔑 Tài khoản mặc định

| Vai trò | Email | Mật khẩu |
|---------|-------|-----------|
| **Quản trị viên (Admin)** | `admin@foodsystem.com` | `Admin@123456` |
| **Người dùng (User)** | `user@foodsystem.com` | `User@123456` |

---

## 📂 Cấu trúc thư mục

```
├── backend/                  # Mã nguồn Backend API (Node.js/Express/TypeScript)
│   ├── sql/                  # Script SQL tạo CSDL MySQL & Seed dữ liệu
│   └── src/
│       ├── database/         # Kết nối MySQL Pool & Khởi tạo CSDL
│       ├── middleware/       # JWT Auth & Error Handlers
│       ├── routes/           # Auth, Recipe, User, Admin Routes
│       ├── services/         # Gemini AI Service, Image Service, Recipe Matcher
│       └── types/            # TypeScript Interface Definitions
├── frontend/                 # Mã nguồn Giao diện Web (React/Vite/TypeScript)
│   └── src/
│       ├── components/       # UI Components & Recipe Modals
│       ├── context/          # Auth Context & Theme
│       ├── pages/            # Dashboard, Admin, Profile, Favorites, History
│       └── services/         # Axios API Services
└── crawler/                  # Script cào dữ liệu Cookpad Việt Nam
```

---

## 👨‍💻 Tác giả
- Đồ án Trí Tuệ Nhân Tạo: **Hệ thống Gợi ý Món ăn Thông minh (FoodAI)**
