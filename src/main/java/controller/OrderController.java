package controller;

import model.OrderDTO;
import service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class OrderController extends HttpServlet {
    private OrderService orderService;

    @Override
    public void init() {
        orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("search".equals(action)) {
                handleSearch(request, response);
            } else {
                List<OrderDTO> orders = orderService.getAllOrders();
                request.setAttribute("orders", orders);
                request.getRequestDispatcher("/orderList.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("accept".equals(action)) {
                int orderID = Integer.parseInt(request.getParameter("orderID"));
                orderService.acceptOrder(orderID);
                response.sendRedirect("orders");
            } else if ("updateStatus".equals(action)) {
                int orderID = Integer.parseInt(request.getParameter("orderID"));
                int statusID = Integer.parseInt(request.getParameter("statusID"));
                orderService.updateOrderStatus(orderID, statusID);
                response.sendRedirect("orders");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
    
    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        
        List<OrderDTO> orders = orderService.searchOrders(keyword, status);
        request.setAttribute("orders", orders);
        request.setAttribute("keyword", keyword);
        request.setAttribute("selectedStatus", status);
        request.getRequestDispatcher("/orderList.jsp").forward(request, response);
    }
}
