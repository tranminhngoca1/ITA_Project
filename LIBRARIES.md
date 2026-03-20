# Thư viện JAR đã được thêm vào dự án

## Các file JAR trong web/WEB-INF/lib/:

1. **jakarta.servlet.jsp.jstl-api-2.0.0.jar**
   - JSTL API (Jakarta Standard Tag Library)
   - Cung cấp các tag chuẩn cho JSP (forEach, if, choose, etc.)

2. **jakarta.servlet.jsp.jstl-2.0.0.jar**
   - JSTL Implementation
   - Triển khai các tag JSTL

3. **sqljdbc42.jar**
   - Microsoft SQL Server JDBC Driver
   - Kết nối Java với SQL Server

## Lưu ý:
- Các file JAR này đã được copy từ thư mục allowedlib
- NetBeans sẽ tự động nhận diện các JAR trong web/WEB-INF/lib/
- Không cần thêm thủ công vào Libraries trong NetBeans
- Khi build project, các JAR này sẽ được đóng gói vào file WAR

## Nếu thiếu thư viện:
Nếu team member khác thiếu thư viện, họ cần:
1. Tải các JAR từ nguồn chính thức
2. Copy vào web/WEB-INF/lib/
3. Hoặc lấy từ thư mục allowedlib nếu có
