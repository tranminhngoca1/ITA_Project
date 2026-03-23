package DAO;

import model.User;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.LinkedHashMap;
import java.util.Map;

//* day la userdao*/
public class UserDAO {

    public List<User> findAll() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.UserID, u.FullName, u.Email, u.PasswordHash, u.Gender, u.Phone, u.Address, u.AvatarUrl, u.RoleID, s.Name AS RoleName, u.IsActive, u.CreatedAt " +
                     "FROM [User] u LEFT JOIN Setting s ON u.RoleID = s.SettingID";
        
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
        String sql = "SELECT u.UserID, u.FullName, u.Email, u.PasswordHash, u.Gender, u.Phone, u.Address, u.AvatarUrl, u.RoleID, s.Name AS RoleName, u.IsActive, u.CreatedAt " +
                     "FROM [User] u LEFT JOIN Setting s ON u.RoleID = s.SettingID WHERE u.UserID = ?";
        
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
        String sql = "SELECT u.UserID, u.FullName, u.Email, u.PasswordHash, u.Gender, u.Phone, u.Address, u.AvatarUrl, u.RoleID, s.Name AS RoleName, u.IsActive, u.CreatedAt " +
                     "FROM [User] u LEFT JOIN Setting s ON u.RoleID = s.SettingID WHERE u.Email = ?";
        
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

    public List<User> searchUsers(String name, String status, int offset, int limit) throws SQLException {
        List<User> users = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT u.UserID, u.FullName, u.Email, u.PasswordHash, u.Gender, u.Phone, u.Address, u.AvatarUrl, u.RoleID, s.Name AS RoleName, u.IsActive, u.CreatedAt FROM [User] u LEFT JOIN Setting s ON u.RoleID = s.SettingID WHERE 1=1");
        
        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND u.FullName LIKE ?");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND u.IsActive = ?");
        }
        sql.append(" ORDER BY u.UserID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (name != null && !name.trim().isEmpty()) {
                pstmt.setString(paramIndex++, "%" + name.trim() + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                boolean isActive = status.equalsIgnoreCase("Active") || status.equals("1") || status.equals("true");
                pstmt.setBoolean(paramIndex++, isActive);
            }
            pstmt.setInt(paramIndex++, offset);
            pstmt.setInt(paramIndex, limit);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    users.add(mapResultSetToUser(rs));
                }
            }
        }
        return users;
    }

    public int countTotalUsers(String name, String status) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [User] u WHERE 1=1");
        
        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND u.FullName LIKE ?");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND u.IsActive = ?");
        }

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (name != null && !name.trim().isEmpty()) {
                pstmt.setString(paramIndex++, "%" + name.trim() + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                boolean isActive = status.equalsIgnoreCase("Active") || status.equals("1") || status.equals("true");
                pstmt.setBoolean(paramIndex, isActive);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public Map<Integer, String> getRoles() throws SQLException {
        Map<Integer, String> roles = new LinkedHashMap<>();
        String sql = "SELECT SettingID, Name FROM Setting WHERE Type = 'Role' AND IsActive = 1 ORDER BY Priority";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                roles.put(rs.getInt("SettingID"), rs.getString("Name"));
            }
        }
        return roles;
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
        try {
            user.setRoleName(rs.getString("RoleName"));
        } catch (SQLException e) {
            // column not found, ignore
        }
        user.setActive(rs.getBoolean("IsActive"));
        user.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return user;
    }
}
