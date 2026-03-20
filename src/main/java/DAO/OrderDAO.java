package DAO;

import model.OrderDTO;
import util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    
    public List<OrderDTO> getAllOrders() throws SQLException {
        List<OrderDTO> orders = new ArrayList<>();
        String sql = "SELECT o.OrderID, p.ProductName, od.Quantity, " +
                    "(od.Quantity * od.Price) AS Total, o.CreatedAt, s.Value AS Status " +
                    "FROM [Order] o " +
                    "JOIN OrderDetail od ON o.OrderID = od.OrderID " +
                    "JOIN Product p ON od.ProductID = p.ProductID " +
                    "LEFT JOIN Setting s ON o.StatusID = s.SettingID " +
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
                orders.add(order);
            }
        }
        return orders;
    }
}
