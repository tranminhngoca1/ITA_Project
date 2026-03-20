# CoffeeLux - Coffee Shop Management System

## Thông tin dự án
- **JDK**: 17
- **Server**: Tomcat 10.1
- **Database**: SQL Server (ITA Database)
- **Technology**: Jakarta Servlet 6.0, JSP, JSTL 2.0
- **IDE**: NetBeans

## Mô tả hệ thống
Hệ thống quản lý chuỗi cửa hàng cà phê CoffeeLux với các chức năng:
- Quản lý người dùng (User) với nhiều vai trò (Admin, HR, Inventory, Barista, Customer)
- Quản lý sản phẩm (Product) và danh mục
- Quản lý cửa hàng (Shop)
- Quản lý nhà cung cấp (Supplier)
- Quản lý nguyên liệu (Ingredient)
- Quản lý đơn hàng (Order)
- Quản lý nhập hàng (Purchase Order)
- Quản lý công thức sản phẩm (ProductBOM)

## Cấu trúc database
- **Setting**: Cấu hình hệ thống (Role, Category, Unit, Status)
- **User**: Người dùng với các vai trò khác nhau
- **Shop**: Cửa hàng
- **Supplier**: Nhà cung cấp
- **Product**: Sản phẩm bán
- **Ingredient**: Nguyên liệu
- **Order**: Đơn hàng khách
- **PurchaseOrder**: Đơn nhập hàng
- **Issue**: Báo cáo sự cố nguyên liệu
- **ProductBOM**: Định lượng nguyên liệu cho sản phẩm

## Cài đặt

### 1. Clone repository
```bash
git clone <repository-url>
cd DashMin
```

### 2. Mở project trong NetBeans
- File → Open Project
- Chọn thư mục DashMin

### 3. Thư viện đã có sẵn
Các JAR file trong `web/WEB-INF/lib/`:
- sqljdbc42.jar
- jakarta.servlet.jsp.jstl-api-2.0.0.jar
- jakarta.servlet.jsp.jstl-2.0.0.jar

### 4. Cấu hình Database
1. Chạy script `database.sql` trong SQL Server Management Studio
2. Copy `src/main/resources/db.properties.example` → `db.properties`
3. Cập nhật thông tin:
```properties
db.url=jdbc:sqlserver://localhost:1433;databaseName=ITA
db.username=sa
db.password=your_password
```

### 5. Cấu hình Tomcat
- Tools → Servers → Add Server
- Chọn Apache Tomcat 10.1

### 6. Build và Run
- Right-click project → Clean and Build
- Right-click project → Run (F6)

## API Endpoints

### User API
- GET `/api/user` - Lấy danh sách users
- GET `/api/user/{id}` - Lấy user theo ID
- POST `/api/user` - Tạo user mới
- PUT `/api/user` - Cập nhật user
- DELETE `/api/user/{id}` - Xóa user

### Product API
- GET `/api/product` - Lấy danh sách products
- GET `/api/product/{id}` - Lấy product theo ID
- GET `/api/product?category={categoryID}` - Lấy products theo category

### Page URLs
- `/` hoặc `/index.jsp` - Trang chủ
- `/users` - Danh sách users (JSP)
- `/signin.html` - Đăng nhập

## Dữ liệu mẫu
Database đã có sẵn dữ liệu mẫu:
- 9 users với các vai trò khác nhau
- 5 suppliers
- 4 shops
- 17 products (cà phê, trà, bánh)
- 21 ingredients
- Sample orders và purchase orders

## Tài khoản test
- **Admin**: admin@gmail.com / password: 123456
- **HR**: hr@gmail.com / password: 123456
- **Staff**: staff@gmail.com / password: 123456
- **Barista**: barista@gmail.com / password: 123456
- **User**: user@gmail.com / password: 123456

## Quy tắc làm việc với Git
```bash
git pull origin main
git checkout -b feature/ten-feature
git add .
git commit -m "Mô tả thay đổi"
git push origin feature/ten-feature
```

## License
[Thêm license nếu cần]
