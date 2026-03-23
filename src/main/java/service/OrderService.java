package service;

import DAO.OrderDAO;
import model.OrderDTO;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.LinkedHashMap;

public class OrderService {
    private OrderDAO orderDAO;

    public OrderService() {
        this.orderDAO = new OrderDAO();
    }

    public List<OrderDTO> getAllOrders() throws SQLException {
        return aggregateOrders(orderDAO.getAllOrders());
    }
    
    public List<OrderDTO> searchOrders(String keyword, String status) throws SQLException {
        return aggregateOrders(orderDAO.searchOrders(keyword, status));
    }
    
    private List<OrderDTO> aggregateOrders(List<OrderDTO> flatList) {
        Map<Integer, OrderDTO> map = new LinkedHashMap<>();
        for (OrderDTO dto : flatList) {
            if (map.containsKey(dto.getOrderID())) {
                OrderDTO existing = map.get(dto.getOrderID());
                existing.setProductName(existing.getProductName() + ", " + dto.getProductName() + " (x" + dto.getQuantity() + ")");
                existing.setQuantity(existing.getQuantity() + dto.getQuantity());
                existing.setTotal(existing.getTotal().add(dto.getTotal()));
            } else {
                dto.setProductName(dto.getProductName() + " (x" + dto.getQuantity() + ")");
                map.put(dto.getOrderID(), dto);
            }
        }
        return new ArrayList<>(map.values());
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
    
    public boolean updateOrderDetails(int orderID, int statusID) throws SQLException {
        return orderDAO.updateOrderDetails(orderID, statusID);
    }
    
    public Map<Integer, String> getOrderStatuses() throws SQLException {
        return orderDAO.getOrderStatuses();
    }
}
