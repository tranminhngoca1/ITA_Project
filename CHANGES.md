# Thay đổi so với yêu cầu ban đầu

## Thư viện đã điều chỉnh:

### 1. JSTL
- **Ban đầu**: Jakarta JSTL 3.0 (jakarta.tags.core)
- **Hiện tại**: Jakarta JSTL 2.0 (http://java.sun.com/jsp/jstl/core)
- **Lý do**: Phù hợp với thư viện có sẵn trong allowedlib

### 2. Gson
- **Ban đầu**: Sử dụng Gson để convert JSON
- **Hiện tại**: Tự viết JSON converter đơn giản
- **Lý do**: Không có Gson trong allowedlib
- **Code**: Thêm method toJson() trong UserController

### 3. SQL Server JDBC
- **Ban đầu**: mssql-jdbc-12.4.2.jre11.jar (phiên bản mới)
- **Hiện tại**: sqljdbc42.jar (phiên bản cũ)
- **Lý do**: Phù hợp với thư viện có sẵn
- **Connection string**: Bỏ encrypt=true và trustServerCertificate=true

## Các file đã sửa:

1. **web/index.jsp** - Đổi JSTL namespace
2. **web/table.jsp** - Đổi JSTL namespace
3. **web/includes/sidebar.jsp** - Đổi JSTL namespace
4. **web/includes/navbar.jsp** - Đổi JSTL namespace
5. **src/main/java/com/dashmin/controller/UserController.java** - Xóa Gson, thêm JSON converter
6. **src/main/resources/db.properties** - Sửa connection string
7. **README.md** - Cập nhật thông tin thư viện

## Kết quả:
✅ Base code hoàn toàn tương thích với thư viện trong allowedlib
✅ Không cần tải thêm thư viện nào
✅ Sẵn sàng để chạy trên NetBeans với Tomcat 10.1
