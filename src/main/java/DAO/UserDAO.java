package DAO;

import model.User;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public List<User> findAll() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT UserID, FullName, Email, PasswordHash, Gender, Phone, Address, AvatarUrl, RoleID, IsActive, CreatedAt FROM [User]";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                User user = mapResultSetToUser(rs);
                users.add(user);
            }
        }
        return users;
    }

    public User findById(int id) throws SQLException {
        String sql = "SELECT UserID, FullName, Email, PasswordHash, Gender, Phone, Address, AvatarUrl, RoleID, IsActive, CreatedAt FROM [User] WHERE UserID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        }
        return null;
    }

    public User findByEmail(String email) throws SQLException {
        String sql = "SELECT UserID, FullName, Email, PasswordHash, Gender, Phone, Address, AvatarUrl, RoleID, IsActive, CreatedAt FROM [User] WHERE Email = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        }
        return null;
    }

    public void save(User user) throws SQLException {
        String sql = "INSERT INTO [User] (FullName, Email, PasswordHash, Gender, Phone, Address, AvatarUrl, RoleID, IsActive) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getFullName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPasswordHash());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getPhone());
            pstmt.setString(6, user.getAddress());
            pstmt.setString(7, user.getAvatarUrl());
            pstmt.setInt(8, user.getRoleID());
            pstmt.setBoolean(9, user.isActive());
            pstmt.executeUpdate();
        }
    }

    public void update(User user) throws SQLException {
        String sql = "UPDATE [User] SET FullName = ?, Email = ?, Gender = ?, Phone = ?, Address = ?, AvatarUrl = ?, RoleID = ?, IsActive = ? WHERE UserID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getFullName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getGender());
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getAddress());
            pstmt.setString(6, user.getAvatarUrl());
            pstmt.setInt(7, user.getRoleID());
            pstmt.setBoolean(8, user.isActive());
            pstmt.setInt(9, user.getUserID());
            pstmt.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM [User] WHERE UserID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
    }

    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserID(rs.getInt("UserID"));
        user.setFullName(rs.getString("FullName"));
        user.setEmail(rs.getString("Email"));
        user.setPasswordHash(rs.getString("PasswordHash"));
        user.setGender(rs.getString("Gender"));
        user.setPhone(rs.getString("Phone"));
        user.setAddress(rs.getString("Address"));
        user.setAvatarUrl(rs.getString("AvatarUrl"));
        user.setRoleID(rs.getInt("RoleID"));
        user.setActive(rs.getBoolean("IsActive"));
        user.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return user;
    }
}
