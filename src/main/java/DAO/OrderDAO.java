package DAO;

import model.OrderDTO;
import util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.LinkedHashMap;
import java.util.Map;

public class OrderDAO {
    
    public List<OrderDTO> getAllOrders() throws SQLException {
        List<OrderDTO> orders = new ArrayList<>();
        String sql = "SELECT o.OrderID, p.ProductName, od.Quantity, " +
                    "(od.Quantity * od.Price) AS Total, o.CreatedAt, s.Value AS Status, " +
                    "u.FullName AS CustomerName, o.StatusID " +
                    "FROM [Order] o " +
                    "JOIN OrderDetail od ON o.OrderID = od.OrderID " +
                    "JOIN Product p ON od.ProductID = p.ProductID " +
                    "LEFT JOIN Setting s ON o.StatusID = s.SettingID " +
                    "LEFT JOIN [User] u ON o.CreatedBy = u.UserID " +
                    "ORDER BY o.CreatedAt DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                OrderDTO order = new OrderDTO();
                order.setOrderID(rs.getInt("OrderID"));
                order.setProductName(rs.getString("ProductName"));
                order.setQuantity(rs.getInt("Quantity"));
                order.setTotal(rs.getBigDecimal("Total"));
                order.setCreatedAt(rs.getTimestamp("CreatedAt"));
                order.setStatus(rs.getString("Status"));
                order.setCustomerName(rs.getString("CustomerName"));
                order.setStatusID(rs.getInt("StatusID"));
                orders.add(order);
            }
        }
        return orders;
    }
    
    public List<OrderDTO> searchOrders(String keyword, String status) throws SQLException {
        List<OrderDTO> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT o.OrderID, p.ProductName, od.Quantity, " +
            "(od.Quantity * od.Price) AS Total, o.CreatedAt, s.Value AS Status, " +
            "u.FullName AS CustomerName, o.StatusID " +
            "FROM [Order] o " +
            "JOIN OrderDetail od ON o.OrderID = od.OrderID " +
            "JOIN Product p ON od.ProductID = p.ProductID " +
            "LEFT JOIN Setting s ON o.StatusID = s.SettingID " +
            "LEFT JOIN [User] u ON o.CreatedBy = u.UserID WHERE 1=1"
        );
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (p.ProductName LIKE ? OR u.FullName LIKE ?)");
        }
        if (status != null && !status.trim().isEmpty() && !status.equals("All")) {
            sql.append(" AND s.Value = ?");
        }
        sql.append(" ORDER BY o.CreatedAt DESC");
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchPattern = "%" + keyword + "%";
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
            }
            if (status != null && !status.trim().isEmpty() && !status.equals("All")) {
                pstmt.setString(paramIndex, status);
            }
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    OrderDTO order = new OrderDTO();
                    order.setOrderID(rs.getInt("OrderID"));
                    order.setProductName(rs.getString("ProductName"));
                    order.setQuantity(rs.getInt("Quantity"));
                    order.setTotal(rs.getBigDecimal("Total"));
                    order.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    order.setStatus(rs.getString("Status"));
                    order.setCustomerName(rs.getString("CustomerName"));
                    order.setStatusID(rs.getInt("StatusID"));
                    orders.add(order);
                }
            }
        }
        return orders;
    }
    
    public boolean updateOrderStatus(int orderID, int newStatusID) throws SQLException {
        String sql = "UPDATE [Order] SET StatusID = ? WHERE OrderID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, newStatusID);
            pstmt.setInt(2, orderID);
            return pstmt.executeUpdate() > 0;
        }
    }

    public OrderDTO getOrderById(int orderId) throws SQLException {
        String sql = "SELECT o.OrderID, p.ProductName, od.Quantity, " +
                    "(od.Quantity * od.Price) AS Total, o.CreatedAt, s.Value AS Status, " +
                    "u.FullName AS CustomerName, o.StatusID " +
                    "FROM [Order] o " +
                    "JOIN OrderDetail od ON o.OrderID = od.OrderID " +
                    "JOIN Product p ON od.ProductID = p.ProductID " +
                    "LEFT JOIN Setting s ON o.StatusID = s.SettingID " +
                    "LEFT JOIN [User] u ON o.CreatedBy = u.UserID " +
                    "WHERE o.OrderID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, orderId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    OrderDTO order = new OrderDTO();
                    order.setOrderID(rs.getInt("OrderID"));
                    order.setProductName(rs.getString("ProductName"));
                    order.setQuantity(rs.getInt("Quantity"));
                    order.setTotal(rs.getBigDecimal("Total"));
                    order.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    order.setStatus(rs.getString("Status"));
                    order.setCustomerName(rs.getString("CustomerName"));
                    order.setStatusID(rs.getInt("StatusID"));
                    return order;
                }
            }
        }
        return null;
    }

    public boolean updateOrderDetails(int orderID, int statusID, int quantity) throws SQLException {
        String sqlOrder = "UPDATE [Order] SET StatusID = ? WHERE OrderID = ?";
        String sqlDetail = "UPDATE OrderDetail SET Quantity = ? WHERE OrderID = ?";
        
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);
            
            try (PreparedStatement pstmtOrder = conn.prepareStatement(sqlOrder)) {
                pstmtOrder.setInt(1, statusID);
                pstmtOrder.setInt(2, orderID);
                pstmtOrder.executeUpdate();
            }
            
            try (PreparedStatement pstmtDetail = conn.prepareStatement(sqlDetail)) {
                pstmtDetail.setInt(1, quantity);
                pstmtDetail.setInt(2, orderID);
                pstmtDetail.executeUpdate();
            }
            
            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    public Map<Integer, String> getOrderStatuses() throws SQLException {
        Map<Integer, String> statuses = new LinkedHashMap<>();
        String sql = "SELECT SettingID, Value FROM Setting WHERE Type = 'OrderStatus' ORDER BY Priority";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                statuses.put(rs.getInt("SettingID"), rs.getString("Value"));
            }
        }
        return statuses;
    }
}
