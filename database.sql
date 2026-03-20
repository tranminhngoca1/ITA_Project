-- Create database
CREATE DATABASE dashmin_db;
GO

USE dashmin_db;
GO

-- Create users table
CREATE TABLE users (
    id INT PRIMARY KEY IDENTITY(1,1),
    username NVARCHAR(50) NOT NULL UNIQUE,
    email NVARCHAR(100) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- Insert sample data
INSERT INTO users (username, email, password) VALUES 
('admin', 'admin@dashmin.com', '123456'),
('user1', 'user1@dashmin.com', '123456');
GO
