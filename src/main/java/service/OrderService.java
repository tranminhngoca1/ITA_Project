package service;

import DAO.OrderDAO;
import model.OrderDTO;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class OrderService {
    private OrderDAO orderDAO;

    public OrderService() {
        this.orderDAO = new OrderDAO();
    }

    public List<OrderDTO> getAllOrders() throws SQLException {
        return orderDAO.getAllOrders();
    }
    
    public List<OrderDTO> searchOrders(String keyword, String status) throws SQLException {
        return orderDAO.searchOrders(keyword, status);
    }
    
    public boolean acceptOrder(int orderID) throws SQLException {
        return orderDAO.updateOrderStatus(orderID, 30);
    }
    
    public boolean updateOrderStatus(int orderID, int statusID) throws SQLException {
        return orderDAO.updateOrderStatus(orderID, statusID);
    }
    
    public OrderDTO getOrderById(int orderId) throws SQLException {
        return orderDAO.getOrderById(orderId);
    }
    
    public boolean updateOrderDetails(int orderID, int statusID, int quantity) throws SQLException {
        return orderDAO.updateOrderDetails(orderID, statusID, quantity);
    }
    
    public Map<Integer, String> getOrderStatuses() throws SQLException {
        return orderDAO.getOrderStatuses();
    }
}
