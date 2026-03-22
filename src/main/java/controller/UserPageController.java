package controller;

import model.User;
import service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class UserPageController extends HttpServlet {
    private final UserService userService;

    public UserPageController() {
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        try {
            String searchName = req.getParameter("name");
            String searchStatus = req.getParameter("status");
            String pageStr = req.getParameter("page");
            
            int page = 1;
            int limit = 5;
            if (pageStr != null && !pageStr.trim().isEmpty()) {
                try {
                    page = Integer.parseInt(pageStr);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            List<User> users = userService.searchUsers(searchName, searchStatus, page, limit);
            int totalRecords = userService.countTotalUsers(searchName, searchStatus);
            int totalPages = (int) Math.ceil((double) totalRecords / limit);

            req.setAttribute("users", users);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("searchName", searchName != null ? searchName : "");
            req.setAttribute("searchStatus", searchStatus != null ? searchStatus : "");

            req.getRequestDispatcher("/table.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Error loading users", e);
        }
    }
}
