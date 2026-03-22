package controller;

import service.UserService;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

public class ResetPasswordController extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/reset-pass.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email = req.getParameter("email");

        try {
            User user = userService.getUserByEmail(email);
            if (user != null) {
                req.setAttribute("success", "A reset link has been sent to " + email);
            } else {
                req.setAttribute("error", "No account found with that email.");
            }
        } catch (SQLException e) {
            req.setAttribute("error", "Server error. Please try again.");
        }

        req.getRequestDispatcher("/reset-pass.jsp").forward(req, resp);
    }
}
