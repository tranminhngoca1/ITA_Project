package DAO;

import model.Shop;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShopDAO {

    private static final String BASE_SELECT =
        "SELECT s.ShopID, s.ShopName, s.ShopImage, s.Address, s.Phone, " +
        "s.OwnerID, u.FullName AS OwnerName, s.IsActive, s.CreatedAt " +
        "FROM Shop s LEFT JOIN [User] u ON s.OwnerID = u.UserID ";

    public List<Shop> findAll() throws SQLException {
        List<Shop> list = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(BASE_SELECT + "ORDER BY s.CreatedAt DESC")) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public List<Shop> findByOwner(int ownerID) throws SQLException {
        List<Shop> list = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE s.OwnerID = ? ORDER BY s.CreatedAt DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ownerID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    public List<Shop> search(String keyword, String status) throws SQLException {
        List<Shop> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(BASE_SELECT + "WHERE 1=1 ");
        if (keyword != null && !keyword.trim().isEmpty())
            sql.append("AND (s.ShopName LIKE ? OR s.Address LIKE ?) ");
        if (status != null && !status.trim().isEmpty())
            sql.append("AND s.IsActive = ? ");
        sql.append("ORDER BY s.CreatedAt DESC");

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String like = "%" + keyword.trim() + "%";
                ps.setString(idx++, like);
                ps.setString(idx++, like);
            }
            if (status != null && !status.trim().isEmpty())
                ps.setBoolean(idx, "active".equalsIgnoreCase(status));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    public Shop findById(int id) throws SQLException {
        String sql = BASE_SELECT + "WHERE s.ShopID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        }
        return null;
    }

    public void save(Shop shop) throws SQLException {
        String sql = "INSERT INTO Shop (ShopName, ShopImage, Address, Phone, OwnerID, IsActive) VALUES (?,?,?,?,?,?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, shop.getShopName());
            ps.setString(2, shop.getShopImage());
            ps.setString(3, shop.getAddress());
            ps.setString(4, shop.getPhone());
            ps.setInt(5, shop.getOwnerID());
            ps.setBoolean(6, shop.isActive());
            ps.executeUpdate();
        }
    }

    public void update(Shop shop) throws SQLException {
        String sql = "UPDATE Shop SET ShopName=?, ShopImage=?, Address=?, Phone=?, IsActive=? WHERE ShopID=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, shop.getShopName());
            ps.setString(2, shop.getShopImage());
            ps.setString(3, shop.getAddress());
            ps.setString(4, shop.getPhone());
            ps.setBoolean(5, shop.isActive());
            ps.setInt(6, shop.getShopID());
            ps.executeUpdate();
        }
    }

    private Shop map(ResultSet rs) throws SQLException {
        Shop s = new Shop();
        s.setShopID(rs.getInt("ShopID"));
        s.setShopName(rs.getString("ShopName"));
        s.setShopImage(rs.getString("ShopImage"));
        s.setAddress(rs.getString("Address"));
        s.setPhone(rs.getString("Phone"));
        s.setOwnerID(rs.getInt("OwnerID"));
        s.setOwnerName(rs.getString("OwnerName"));
        s.setActive(rs.getBoolean("IsActive"));
        s.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return s;
    }
}
