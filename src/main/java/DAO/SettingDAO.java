package DAO;

import model.Setting;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SettingDAO {

    public List<Setting> getAllSettings() throws SQLException {
        List<Setting> settings = new ArrayList<>();
        String sql = "SELECT * FROM Setting ORDER BY Priority, SettingID";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                settings.add(mapResultSetToSetting(rs));
            }
        }
        return settings;
    }

    public List<Setting> getSettingsByFilter(String name, String type, String status) throws SQLException {
        List<Setting> settings = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Setting WHERE 1=1");
        
        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND Name LIKE ?");
        }
        if (type != null && !type.trim().isEmpty() && !type.equals("all")) {
            sql.append(" AND Type = ?");
        }
        if (status != null && !status.trim().isEmpty() && !status.equals("all")) {
            sql.append(" AND IsActive = ?");
        }
        sql.append(" ORDER BY Priority, SettingID");
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (name != null && !name.trim().isEmpty()) {
                pstmt.setString(paramIndex++, "%" + name.trim() + "%");
            }
            if (type != null && !type.trim().isEmpty() && !type.equals("all")) {
                pstmt.setString(paramIndex++, type);
            }
            if (status != null && !status.trim().isEmpty() && !status.equals("all")) {
                pstmt.setBoolean(paramIndex++, status.equals("1"));
            }
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    settings.add(mapResultSetToSetting(rs));
                }
            }
        }
        return settings;
    }

    public Setting getSettingById(int id) throws SQLException {
        String sql = "SELECT * FROM Setting WHERE SettingID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToSetting(rs);
                }
            }
        }
        return null;
    }

    public List<String> getAllTypes() throws SQLException {
        List<String> types = new ArrayList<>();
        String sql = "SELECT DISTINCT Type FROM Setting ORDER BY Type";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                types.add(rs.getString("Type"));
            }
        }
        return types;
    }

    public boolean createSetting(Setting setting) throws SQLException {
        String sql = "INSERT INTO Setting (Name, Type, Value, Priority, Description, IsActive) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, setting.getName());
            pstmt.setString(2, setting.getType());
            pstmt.setString(3, setting.getValue());
            pstmt.setInt(4, setting.getPriority());
            pstmt.setString(5, setting.getDescription());
            pstmt.setBoolean(6, setting.isActive());
            
            return pstmt.executeUpdate() > 0;
        }
    }

    public boolean updateSetting(Setting setting) throws SQLException {
        String sql = "UPDATE Setting SET Name = ?, Type = ?, Value = ?, Priority = ?, Description = ?, IsActive = ? WHERE SettingID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, setting.getName());
            pstmt.setString(2, setting.getType());
            pstmt.setString(3, setting.getValue());
            pstmt.setInt(4, setting.getPriority());
            pstmt.setString(5, setting.getDescription());
            pstmt.setBoolean(6, setting.isActive());
            pstmt.setInt(7, setting.getSettingID());
            
            return pstmt.executeUpdate() > 0;
        }
    }

    public boolean deleteSetting(int id) throws SQLException {
        String sql = "DELETE FROM Setting WHERE SettingID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        }
    }

    private Setting mapResultSetToSetting(ResultSet rs) throws SQLException {
        Setting setting = new Setting();
        setting.setSettingID(rs.getInt("SettingID"));
        setting.setName(rs.getString("Name"));
        setting.setType(rs.getString("Type"));
        setting.setValue(rs.getString("Value"));
        setting.setPriority(rs.getInt("Priority"));
        setting.setDescription(rs.getString("Description"));
        setting.setActive(rs.getBoolean("IsActive"));
        return setting;
    }
}
