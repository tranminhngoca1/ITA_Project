create database ITA;
-- ============================================
-- 1. Bảng Setting
-- ============================================
CREATE TABLE Setting (
    SettingID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Type NVARCHAR(50) NOT NULL,   
    Value NVARCHAR(100) NOT NULL,
    Priority INTEGER NOT NULL DEFAULT 1,
    Description NVARCHAR(255),
    IsActive BIT DEFAULT 1
);

-- ============================================
-- 2. Bảng Supplier
-- ============================================
CREATE TABLE Supplier (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierName NVARCHAR(100) NOT NULL,
    ContactName NVARCHAR(100),
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    Address NVARCHAR(255),
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- ============================================
-- 3. Bảng User
-- ============================================
CREATE TABLE [User] (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    Gender NVARCHAR(10) NOT NULL CHECK (Gender IN (N'Nam', N'Nữ')),
    Phone NVARCHAR(20),
    Address NVARCHAR(255),
    AvatarUrl NVARCHAR(500),   
    RoleID INT NOT NULL,   
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (RoleID) REFERENCES Setting(SettingID)
);

-- ============================================
-- 4. Bảng Shop 
-- ============================================
CREATE TABLE Shop (
    ShopID INT IDENTITY(1,1) PRIMARY KEY,
    ShopName NVARCHAR(100) NOT NULL,
    ShopImage NVARCHAR(MAX),
    Address NVARCHAR(255),
    Phone NVARCHAR(20),
    OwnerID INT,   
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (OwnerID) REFERENCES [User](UserID)
);

-- ============================================
-- 5. Bảng Product (sản phẩm bán)
-- ============================================
CREATE TABLE Product (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    ImageUrl NVARCHAR(500),     
    CategoryID INT NOT NULL,   
    Price DECIMAL(10,2) NOT NULL,
    SupplierID INT,           
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CategoryID) REFERENCES Setting(SettingID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- ============================================
-- 6. Bảng Ingredient (nguyên liệu)
-- ============================================
CREATE TABLE Ingredient (
    IngredientID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    UnitID INT,   
    StockQuantity DECIMAL(10,2) DEFAULT 0,
    SupplierID INT,   
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UnitID) REFERENCES Setting(SettingID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- ============================================
-- 7. Bảng Purchase Order (PO - nhập hàng từ Supplier)
-- ============================================
CREATE TABLE PurchaseOrder (
    POID INT IDENTITY(1,1) PRIMARY KEY,
    ShopID INT NOT NULL,
    SupplierID INT NOT NULL,
    CreatedBy INT NOT NULL,
    StatusID INT,   
    RejectReason NVARCHAR(500),   
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ShopID) REFERENCES Shop(ShopID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (CreatedBy) REFERENCES [User](UserID),
    FOREIGN KEY (StatusID) REFERENCES Setting(SettingID)
);

CREATE TABLE PurchaseOrderDetail (
    PODetailID INT IDENTITY(1,1) PRIMARY KEY,
    POID INT NOT NULL,
    IngredientID INT NOT NULL,
    Quantity DECIMAL(10,2) NOT NULL,
    ReceivedQuantity DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (POID) REFERENCES PurchaseOrder(POID) ON DELETE CASCADE,
    FOREIGN KEY (IngredientID) REFERENCES Ingredient(IngredientID)
);

-- ============================================
-- 8. Bảng Issue (nguyên liệu hỏng/lỗi)
-- ============================================
CREATE TABLE Issue (
    IssueID INT IDENTITY(1,1) PRIMARY KEY,
    IngredientID INT NOT NULL,
    Description NVARCHAR(500),   
    Quantity DECIMAL(10,2) NOT NULL,
    StatusID INT,   
    CreatedBy INT NOT NULL,
    ConfirmedBy INT,
    RejectionReason NVARCHAR(500),   
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (IngredientID) REFERENCES Ingredient(IngredientID),
    FOREIGN KEY (CreatedBy) REFERENCES [User](UserID),
    FOREIGN KEY (ConfirmedBy) REFERENCES [User](UserID),
    FOREIGN KEY (StatusID) REFERENCES Setting(SettingID)
);

-- ============================================
-- 9. Bảng Order (khách đặt sản phẩm)
-- ============================================
CREATE TABLE [Order] (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    ShopID INT NOT NULL,
    CreatedBy INT NOT NULL,
    StatusID INT,   
    CancellationReason NVARCHAR(500),   
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ShopID) REFERENCES Shop(ShopID),
    FOREIGN KEY (CreatedBy) REFERENCES [User](UserID),
    FOREIGN KEY (StatusID) REFERENCES Setting(SettingID)
);

CREATE TABLE OrderDetail (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES [Order](OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- ============================================
-- 10. Bảng ProductBOM (Định lượng/Công thức)
-- ============================================
CREATE TABLE ProductBOM (
    ProductBOMID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    IngredientID INT NOT NULL,
    Quantity DECIMAL(12,4) NOT NULL,   
    UnitID INT,                        
    IsOptional BIT DEFAULT 0,
    DisplayOrder INT DEFAULT 0,
    CONSTRAINT fk_bom_product     FOREIGN KEY (ProductID)    REFERENCES Product(ProductID),
    CONSTRAINT fk_bom_ingredient  FOREIGN KEY (IngredientID) REFERENCES Ingredient(IngredientID),
    CONSTRAINT fk_bom_unit        FOREIGN KEY (UnitID)       REFERENCES Setting(SettingID),
    CONSTRAINT uq_bom_product_ingredient UNIQUE (ProductID, IngredientID)
);

CREATE INDEX idx_bom_product    ON ProductBOM (ProductID, DisplayOrder);
CREATE INDEX idx_bom_ingredient ON ProductBOM (IngredientID);

-- ============================================
-- DATA INSERTION - DỮ LIỆU MẪU
-- ============================================

-- 1. Thêm dữ liệu cho bảng Setting
INSERT INTO Setting (Name, Type, Value, Priority, Description, IsActive) VALUES
(N'System Admin', N'Role', N'Admin', 1, N'Quản trị viên hệ thống', 1),
(N'HR Manager', N'Role', N'HR', 2, N'Nhân sự - Quản lý nhân viên', 1),
(N'Inventory Manager', N'Role', N'Inventory', 3, N'Quản lý kho - Nhập xuất hàng', 1),
(N'Barista', N'Role', N'Barista', 4, N'Pha chế - Nhân viên pha cà phê', 1),
(N'Customer', N'Role', N'User', 5, N'Người dùng - Xem thông tin shop', 0),

(N'Espresso Coffee', N'Category', N'Espresso', 1, N'Các loại cà phê espresso', 1),
(N'Latte Series', N'Category', N'Latte', 2, N'Cà phê sữa nghệ thuật', 1),
(N'Cold Brew', N'Category', N'Cold Brew', 3, N'Cà phê pha lạnh', 1),
(N'Frappuccino', N'Category', N'Frappuccino', 4, N'Đồ uống đá xay', 1),
(N'Tea', N'Category', N'Tea', 5, N'Các loại trà', 1),
(N'Pastry & Bakery', N'Category', N'Pastry', 6, N'Bánh ngọt và bánh mì', 1),
(N'Dessert', N'Category', N'Dessert', 7, N'Tráng miệng', 1),

(N'Kilogram', N'Unit', N'kg', 1, N'Kilogram', 1),
(N'Gram', N'Unit', N'g', 2, N'Gram', 1),
(N'Liter', N'Unit', N'l', 3, N'Lít', 1),
(N'Milliliter', N'Unit', N'ml', 4, N'Mililit', 1),
(N'Package', N'Unit', N'pack', 5, N'Gói', 1),
(N'Bottle', N'Unit', N'bottle', 6, N'Chai', 1),
(N'Bag', N'Unit', N'bag', 7, N'Bao', 1),

(N'Pending Approval', N'POStatus', N'Pending', 1, N'Đơn hàng chờ xử lý', 1),
(N'Approved Order', N'POStatus', N'Approved', 2, N'Đơn hàng đã được duyệt', 1),
(N'Shipping', N'POStatus', N'Shipping', 3, N'Đang giao hàng', 1),
(N'Received', N'POStatus', N'Received', 4, N'Đã nhận hàng', 1),
(N'Cancelled Order', N'POStatus', N'Cancelled', 5, N'Đã hủy đơn hàng', 1),

(N'Reported Issue', N'IssueStatus', N'Reported', 1, N'Đã báo cáo sự cố', 1),
(N'Under Investigation', N'IssueStatus', N'Under Investigation', 2, N'Đang điều tra', 1),
(N'Resolved Issue', N'IssueStatus', N'Resolved', 3, N'Đã giải quyết', 1),
(N'Rejected Issue', N'IssueStatus', N'Rejected', 4, N'Từ chối xử lý', 1),

(N'New Order', N'OrderStatus', N'New', 1, N'Đơn hàng mới', 1),
(N'Preparing Order', N'OrderStatus', N'Preparing', 2, N'Đang chuẩn bị', 1),
(N'Ready for Pickup', N'OrderStatus', N'Ready', 3, N'Sẵn sàng', 1),
(N'Completed Order', N'OrderStatus', N'Completed', 4, N'Đã hoàn thành', 1),
(N'Cancelled Order', N'OrderStatus', N'Cancelled', 5, N'Đã hủy', 1);

-- 2. Thêm dữ liệu cho bảng Suppliers
INSERT INTO Supplier (SupplierName, ContactName, Email, Phone, Address, IsActive) VALUES
(N'Công ty TNHH Cà phê Highlands', N'Nguyễn Văn An', N'contact@highlands.com.vn', N'0901234567', N'123 Đường Nguyễn Huệ, Q1, TP.HCM', 1),
(N'Trung Nguyên Coffee', N'Lê Thị Bình', N'sales@trungnguyencoffee.com', N'0912345678', N'456 Đường Lê Lợi, Q1, TP.HCM', 1),
(N'Công ty Sữa TH True Milk', N'Trần Minh Châu', N'wholesale@thmilk.vn', N'0923456789', N'789 Đường Điện Biên Phủ, Q3, TP.HCM', 1),
(N'Công ty Bánh Kẹo Kinh Đô', N'Phạm Văn Dũng', N'b2b@kinh-do.com.vn', N'0934567890', N'321 Đường Cách Mạng Tháng 8, Q10, TP.HCM', 1),
(N'Công ty Đường Biên Hòa', N'Hoàng Thị Lan', N'contact@bienhoasugar.com', N'0945678901', N'654 Đường Xô Viết Nghệ Tĩnh, Biên Hòa, Đồng Nai', 1);

-- 3. Thêm dữ liệu cho bảng User 
INSERT INTO [User] (FullName, Email, PasswordHash, Gender, Phone, Address, RoleID, IsActive) VALUES
(N'Nguyễn Thị Hồng', N'hr@gmail.com', N'$2a$10$Tna2uT0s8BRJ3oAiQyvUmOipacGm3ObrzS3FlDTxh5GqFu0QsBoli', N'Nữ', N'0901234567', N'123 Đường Lê Lợi, Q1, TP.HCM', 1, 1),
(N'Trần Minh Quân', N'admin@gmail.com', N'$2a$10$Tna2uT0s8BRJ3oAiQyvUmOipacGm3ObrzS3FlDTxh5GqFu0QsBoli', N'Nam', N'0912345678', N'456 Đường Nguyễn Huệ, Q1, TP.HCM', 2, 1),
(N'Lê Thị Mai', N'staff@gmail.com', N'$2a$10$Tna2uT0s8BRJ3oAiQyvUmOipacGm3ObrzS3FlDTxh5GqFu0QsBoli', N'Nữ', N'0923456789', N'789 Đường Điện Biên Phủ, Q3, TP.HCM', 3, 1),
(N'Nguyễn Văn Hùng', N'inventory.hn@coffeelux.com', N'$2a$10$Tna2uT0s8BRJ3oAiQyvUmOipacGm3ObrzS3FlDTxh5GqFu0QsBoli', N'Nam', N'0934567890', N'321 Đường Hoàn Kiếm, Hà Nội', 3, 1),
(N'Phạm Thị Linh', N'employee01@coffeelux.com', N'$2a$10$Tna2uT0s8BRJ3oAiQyvUmOipacGm3ObrzS3FlDTxh5GqFu0QsBoli', N'Nữ', N'0945678901', N'654 Đường Cách Mạng Tháng 8, Q10, TP.HCM', 3, 1),
(N'Hoàng Minh Tú', N'employee02@coffeelux.com', N'$2a$10$Tna2uT0s8BRJ3oAiQyvUmOipacGm3ObrzS3FlDTxh5GqFu0QsBoli', N'Nam', N'0956789012', N'987 Đường Trần Phú, Q5, TP.HCM', 3, 1),
(N'Vũ Thị Nam', N'barista@gmail.com', N'$2a$10$Tna2uT0s8BRJ3oAiQyvUmOipacGm3ObrzS3FlDTxh5GqFu0QsBoli', N'Nữ', N'0967890123', N'147 Đường Lý Tự Trọng, Q1, TP.HCM', 4, 1),
(N'Đỗ Văn Phong', N'cashier02@coffeelux.com', N'$2a$10$Tna2uT0s8BRJ3oAiQyvUmOipacGm3ObrzS3FlDTxh5GqFu0QsBoli', N'Nam', N'0978901234', N'258 Đường Võ Thị Sáu, Q3, TP.HCM', 4, 1),
(N'Trần Văn Bình', N'user@gmail.com', N'$2a$10$Tna2uT0s8BRJ3oAiQyvUmOipacGm3ObrzS3FlDTxh5GqFu0QsBoli', N'Nam', N'0989012345', N'369 Đường Hai Bà Trưng, Q1, TP.HCM', 5, 1);

-- 4. Thêm dữ liệu cho bảng Shops 
INSERT INTO Shop (ShopName, Address, Phone, OwnerID, IsActive) VALUES
(N'CoffeeLux - Chi nhánh Quận 1', N'123 Đường Đồng Khởi, P. Bến Nghé, Q1, TP.HCM', N'02838234567', 2, 1),
(N'CoffeeLux - Chi nhánh Quận 3', N'456 Đường Võ Văn Tần, P.6, Q3, TP.HCM', N'02838345678', 2, 1),
(N'CoffeeLux - Chi nhánh Hà Nội', N'789 Đường Hoàn Kiếm, P. Hàng Trống, Q. Hoàn Kiếm, HN', N'02438456789', 2, 1),
(N'CoffeeLux - Chi nhánh Đà Nẵng', N'321 Đường Trần Phú, P. Thạch Thang, Q. Hải Châu, ĐN', N'02363567890', 2, 1);

-- 5. Thêm dữ liệu cho bảng Products
INSERT INTO Product (ProductName, Description, CategoryID, Price, SupplierID, IsActive) VALUES
(N'Americano', N'Cà phê đen truyền thống', 6, 35000.00, 1, 1),
(N'Espresso', N'Cà phê espresso đậm đà', 6, 30000.00, 1, 1),
(N'Double Espresso', N'Espresso tăng cường', 6, 45000.00, 1, 1),
(N'Cold Brew Original', N'Cà phê pha lạnh nguyên chất', 7, 45000.00, 2, 1),
(N'Cold Brew Vanilla', N'Cà phê lạnh vị vanilla', 7, 50000.00, 2, 1),
(N'Caffe Latte', N'Cà phê sữa nghệ thuật', 8, 55000.00, 1, 1),
(N'Vanilla Latte', N'Latte vị vanilla', 8, 60000.00, 1, 1),
(N'Caramel Latte', N'Latte vị caramel', 8, 65000.00, 1, 1),
(N'Chocolate Frappuccino', N'Đá xay chocolate', 9, 70000.00, 3, 1),
(N'Coffee Frappuccino', N'Đá xay cà phê', 9, 65000.00, 3, 1),
(N'Green Tea Latte', N'Trà xanh sữa', 10, 50000.00, 2, 1),
(N'Earl Grey Tea', N'Trà Earl Grey', 10, 40000.00, 2, 1),
(N'Croissant', N'Bánh sừng bò bơ', 11, 25000.00, 4, 1),
(N'Chocolate Muffin', N'Bánh muffin chocolate', 11, 30000.00, 4, 1),
(N'Blueberry Scone', N'Bánh scone việt quất', 11, 35000.00, 4, 1),
(N'Tiramisu', N'Bánh tiramisu Ý', 12, 65000.00, 4, 1),
(N'Cheesecake', N'Bánh phô mai New York', 12, 70000.00, 4, 1);

-- 6. Thêm dữ liệu cho bảng Ingredients
INSERT INTO Ingredient (Name, UnitID, StockQuantity, SupplierID, IsActive) VALUES
(N'Cà phê Arabica hạt', 13, 50.00, 1, 1),       
(N'Cà phê Robusta hạt', 13, 30.00, 2, 1),       
(N'Cà phê Espresso xay', 13, 20.00, 1, 1),      
(N'Sữa tươi nguyên kem', 16, 100.00, 3, 1),     
(N'Sữa đặc có đường', 19, 50.00, 3, 1),         
(N'Kem tươi', 16, 25.00, 3, 1),                 
(N'Sữa hạnh nhân', 16, 30.00, 3, 1),            
(N'Đường trắng', 13, 25.00, 5, 1),              
(N'Đường nâu', 13, 15.00, 5, 1),                
(N'Mật ong', 18, 20.00, 5, 1),                  
(N'Syrup Vanilla', 18, 15.00, 4, 1),            
(N'Syrup Caramel', 18, 12.00, 4, 1),            
(N'Syrup Hazelnut', 18, 10.00, 4, 1),           
(N'Bột mì đa dụng', 13, 40.00, 4, 1),           
(N'Bột chocolate', 13, 8.00, 4, 1),             
(N'Bột nở', 17, 20.00, 4, 1),                   
(N'Trứng gà', 17, 50.00, 4, 1),                 
(N'Bơ lạt', 13, 15.00, 4, 1),                   
(N'Lá trà xanh', 17, 25.00, 2, 1),              
(N'Lá trà Earl Grey', 17, 20.00, 2, 1),          
(N'Lá trà Oolong', 17, 15.00, 2, 1);            

-- 7. Thêm dữ liệu cho bảng PurchaseOrders 
INSERT INTO PurchaseOrder (ShopID, SupplierID, CreatedBy, StatusID) VALUES
(1, 1, 3, 23), 
(1, 3, 3, 22), 
(2, 2, 4, 21), 
(3, 4, 4, 20), 
(4, 5, 3, 23); 

-- 8. Thêm dữ liệu cho bảng PurchaseOrderDetails
INSERT INTO PurchaseOrderDetail (POID, IngredientID, Quantity, ReceivedQuantity) VALUES
(1, 1, 20.00, 20.00),     
(1, 4, 50.00, 50.00),     
(1, 7, 10.00, 10.00),     
(2, 4, 30.00, 0.00),     
(2, 5, 20.00, 0.00),     
(2, 6, 15.00, 0.00),     
(3, 2, 15.00, 0.00),     
(3, 3, 10.00, 0.00),     
(4, 13, 30.00, 0.00),     
(4, 15, 15.00, 0.00),     
(4, 16, 40.00, 0.00),     
(5, 8, 20.00, 20.00),     
(5, 9, 15.00, 15.00);     

-- 9. Thêm dữ liệu cho bảng Issues 
INSERT INTO Issue (IngredientID, Description, Quantity, StatusID, CreatedBy, ConfirmedBy) VALUES
(1, N'Cà phê Arabica bị ẩm mốc, có mùi lạ không thể sử dụng', 2.50, 27, 5, 3),     
(4, N'Sữa tươi đã hết hạn sử dụng 2 ngày, cần xử lý gấp', 5.00, 25, 6, NULL),       
(7, N'Đường trắng bị vón cục do để nơi ẩm ướt', 1.00, 26, 5, 4),                 
(13, N'Bột mì phát hiện có mọt, cần loại bỏ toàn bộ', 3.00, 27, 7, 3),            
(6, N'Kem tươi bị tách nước, không đủ độ sánh', 2.00, 25, 6, NULL);               

-- 10. Thêm dữ liệu cho bảng Orders 
INSERT INTO [Order] (ShopID, CreatedBy, StatusID) VALUES
(1, 5, 32), 
(1, 6, 31), 
(2, 7, 30), 
(1, 5, 32), 
(3, 6, 29), 
(2, 8, 32), 
(4, 7, 30), 
(1, 5, 31); 

-- 11. Thêm dữ liệu cho bảng OrderDetails
INSERT INTO OrderDetail (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 2, 35000.00),     
(1, 13, 1, 25000.00),    
(2, 6, 1, 55000.00),     
(2, 14, 1, 30000.00),    
(3, 9, 1, 70000.00),     
(3, 16, 1, 65000.00),    
(4, 4, 1, 45000.00),     
(4, 11, 1, 50000.00),    
(5, 2, 1, 30000.00),     
(5, 15, 1, 35000.00),    
(6, 8, 1, 65000.00),     
(6, 17, 1, 70000.00),    
(7, 5, 1, 50000.00),     
(7, 12, 1, 40000.00),    
(8, 10, 1, 65000.00),    
(8, 13, 2, 25000.00);    

-- 12. Thêm dữ liệu cho bảng ProductBOM
INSERT INTO ProductBOM (ProductID, IngredientID, Quantity, UnitID, IsOptional, DisplayOrder) VALUES
(6, 3, 18.0, 14, 0, 1),   
(6, 4, 180.0, 16, 0, 2),
(6, 8, 5.0, 14, 1, 3),     
(7, 3, 18.0, 14, 0, 1),
(7, 4, 180.0, 16, 0, 2),
(7, 11, 20.0, 16, 0, 3),  
(8, 3, 18.0, 14, 0, 1),
(8, 4, 180.0, 16, 0, 2),
(8, 12, 20.0, 16, 0, 3),  
(9, 3, 18.0, 14, 0, 1),
(9, 4, 120.0, 16, 0, 2),
(9, 15, 10.0, 14, 0, 3),  
(9, 6, 30.0, 16, 1, 4),    
(10, 3, 30.0, 14, 0, 1),
(10, 4, 120.0, 16, 0, 2),
(10, 8, 10.0, 14, 1, 3);


SELECT po.POID, s.ShopName, sup.SupplierName,
                   st.Name AS StatusName,
                   po.CreatedAt
            FROM PurchaseOrder po
            JOIN Shop s ON po.ShopID = s.ShopID
            JOIN Supplier sup ON po.SupplierID = sup.SupplierID
            LEFT JOIN Setting st ON po.StatusID = st.SettingID
            ORDER BY po.CreatedAt DESC

select * from PurchaseOrderDetail

SELECT pod.PODetailID,
                   i.Name,
                   pod.Quantity,
                   pod.ReceivedQuantity,
                   s.Value AS Unit
            FROM PurchaseOrderDetail pod
            JOIN Ingredient i ON pod.IngredientID = i.IngredientID
            LEFT JOIN Setting s ON i.UnitID = s.SettingID
            WHERE pod.POID = 5
select * from PurchaseOrder
select * from PurchaseOrderDetail

INSERT INTO PurchaseOrder
            (ShopID, SupplierID, CreatedBy, StatusID)
            VALUES ('1', '3', '4', '24')

INSERT INTO PurchaseOrderDetail
            (POID, IngredientID, Quantity)
            VALUES ('2','4' , '30.00')

UPDATE i
            SET i.StockQuantity = i.StockQuantity + pod.Quantity
            FROM Ingredient i
            JOIN PurchaseOrderDetail pod
            ON i.IngredientID = pod.IngredientID
            WHERE pod.POID = 6

UPDATE PurchaseOrder SET StatusID = 23 WHERE POID = 7

SELECT * FROM Ingredient ORDER BY IngredientID DESC

select * from Ingredient

INSERT INTO Ingredient (Name, StockQuantity, UnitID, SupplierID, IsActive)
        VALUES ('Bánh Tây Nguyên', 40.80, 14, 5, 1)