package service;

import DAO.OrderDAO;
import model.OrderDTO;
import java.sql.SQLException;
import java.util.List;

public class OrderService {
    private OrderDAO orderDAO;

    public OrderService() {
        this.orderDAO = new OrderDAO();
    }

    public List<OrderDTO> getAllOrders() throws SQLException {
        return orderDAO.getAllOrders();
    }
}
