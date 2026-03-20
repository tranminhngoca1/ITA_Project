# Hướng dẫn đẩy project lên GitHub

## Bước 1: Tạo repository trên GitHub
1. Truy cập https://github.com
2. Đăng nhập tài khoản
3. Click nút **New** (hoặc dấu + góc trên bên phải)
4. Điền thông tin:
   - Repository name: `DashMin` (hoặc tên bạn muốn)
   - Description: `Java Web Application with Servlet, JSP, SQL Server`
   - Chọn **Public** hoặc **Private**
   - **KHÔNG** chọn "Add a README file"
   - **KHÔNG** chọn ".gitignore" và "license"
5. Click **Create repository**

## Bước 2: Kết nối local repository với GitHub

Sau khi tạo xong, GitHub sẽ hiển thị hướng dẫn. Chạy các lệnh sau trong terminal:

```bash
# Di chuyển vào thư mục project
cd "c:\Users\Acer\OneDrive\Máy tính\DashMin"

# Thêm remote repository (thay YOUR_USERNAME và YOUR_REPO bằng thông tin của bạn)
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git

# Đổi tên branch thành main (nếu cần)
git branch -M main

# Push code lên GitHub
git push -u origin main
```

## Bước 3: Nhập username và password
- **Username**: Tên đăng nhập GitHub của bạn
- **Password**: Sử dụng **Personal Access Token** (không phải password thường)

### Tạo Personal Access Token:
1. Vào GitHub → Settings → Developer settings
2. Personal access tokens → Tokens (classic)
3. Generate new token (classic)
4. Chọn quyền: `repo` (full control)
5. Copy token và dùng làm password

## Bước 4: Xác nhận
Truy cập repository trên GitHub để kiểm tra code đã được push lên.

## Các lệnh Git thường dùng cho team:

### Clone repository (team members):
```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO
```

### Làm việc hàng ngày:
```bash
# Pull code mới nhất
git pull origin main

# Tạo branch mới cho feature
git checkout -b feature/ten-feature

# Xem thay đổi
git status

# Thêm file vào staging
git add .

# Commit
git commit -m "Mô tả thay đổi"

# Push lên GitHub
git push origin feature/ten-feature
```

### Merge code:
1. Tạo Pull Request trên GitHub
2. Review code
3. Merge vào main branch

## Lưu ý:
- File `db.properties` đã được ignore (không push lên GitHub)
- Mỗi thành viên cần tạo file `db.properties` riêng từ `db.properties.example`
- Thư viện JAR đã được push lên (trong web/WEB-INF/lib/)
