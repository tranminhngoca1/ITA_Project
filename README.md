# DashMin - Java Web Application

## Thông tin dự án
- **JDK**: 17
- **Server**: Tomcat 10.1
- **Database**: SQL Server
- **Technology**: Jakarta Servlet 6.0
- **IDE**: NetBeans

## Cấu trúc dự án
```
DashMin/
├── src/main/java/                 # Java source code
│   └── com/dashmin/
│       ├── controller/            # Servlet Controllers
│       ├── service/               # Business Logic
│       ├── repository/            # Data Access Layer
│       ├── model/                 # Entity Models
│       └── util/                  # Utilities
├── src/main/resources/            # Configuration files
│   └── db.properties
├── web/                           # Web resources
│   ├── WEB-INF/
│   │   ├── web.xml
│   │   └── lib/                   # JAR files (JDBC, Gson, JSTL)
│   ├── includes/                  # JSP components
│   ├── css/, js/, img/, lib/      # Frontend assets
│   ├── *.jsp                      # Dynamic pages
│   └── *.html                     # Static pages
├── nbproject/                     # NetBeans config
└── build.xml                      # Ant build
```

## Cài đặt

### 1. Clone repository
```bash
git clone <repository-url>
cd DashMin
```

### 2. Mở project trong NetBeans
- Mở NetBeans IDE
- File → Open Project
- Chọn thư mục DashMin
- NetBeans sẽ tự động nhận diện project

### 3. Thư viện đã có sẵn
Các JAR file đã được thêm vào `web/WEB-INF/lib/`:
- **sqljdbc42.jar** - SQL Server JDBC Driver
- **jakarta.servlet.jsp.jstl-api-2.0.0.jar** - JSTL API
- **jakarta.servlet.jsp.jstl-2.0.0.jar** - JSTL Implementation

NetBeans sẽ tự động nhận diện các JAR này khi mở project.

### 4. Cấu hình Tomcat trong NetBeans
- Tools → Servers → Add Server
- Chọn Apache Tomcat 10.1
- Chỉ định đường dẫn cài đặt Tomcat

### 5. Cấu hình Database
Chỉnh sửa file `src/main/resources/db.properties`:
```properties
db.url=jdbc:sqlserver://localhost:1433;databaseName=dashmin_db
db.username=sa
db.password=your_password
db.driver=com.microsoft.sqlserver.jdbc.SQLServerDriver
```

### 6. Tạo Database
Chạy script `database.sql` trong SQL Server Management Studio

### 7. Build và Run
- Right-click project → Clean and Build
- Right-click project → Run
- Hoặc nhấn F6

## Chạy ứng dụng
1. NetBeans sẽ tự động start Tomcat và deploy project
2. Truy cập: `http://localhost:8080/dashmin`

## API Endpoints
- GET `/dashmin/user` - Lấy danh sách users
- GET `/dashmin/user/{id}` - Lấy user theo ID
- POST `/dashmin/user` - Tạo user mới
- PUT `/dashmin/user` - Cập nhật user
- DELETE `/dashmin/user/{id}` - Xóa user

## Hướng dẫn cho team members

### Khi clone project lần đầu:
1. Clone repository
2. Mở project trong NetBeans
3. Thêm các thư viện JAR vào `web/WEB-INF/lib/`
4. Cấu hình Tomcat server
5. Cấu hình database connection
6. Build và Run

### Khi làm việc với Git:
```bash
# Pull code mới nhất
git pull origin main

# Tạo branch mới cho feature
git checkout -b feature/ten-feature

# Commit changes
git add .
git commit -m "Mô tả thay đổi"

# Push lên remote
git push origin feature/ten-feature
```

## Quy tắc code
- Đặt tên class theo PascalCase
- Đặt tên method và variable theo camelCase
- Luôn comment code phức tạp
- Commit thường xuyên với message rõ ràng

## Các thành viên team
- [Thêm tên thành viên]

## License
[Thêm license nếu cần]
