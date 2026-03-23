package controller;

import model.User;
import service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

public class UserProfileController extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (req.getSession().getAttribute("loggedInUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            loggedInUser.setFullName(req.getParameter("fullName"));
            loggedInUser.setGender(req.getParameter("gender"));
            loggedInUser.setPhone(req.getParameter("phone"));
            loggedInUser.setAddress(req.getParameter("address"));

            String avatarUrl = req.getParameter("avatarUrl");
            if (avatarUrl != null && !avatarUrl.trim().isEmpty()) {
                loggedInUser.setAvatarUrl(avatarUrl.trim());
            }

            userService.updateUser(loggedInUser);
            session.setAttribute("loggedInUser", loggedInUser);

            resp.sendRedirect(req.getContextPath() + "/user/profile?success=1");
        } catch (SQLException e) {
            req.setAttribute("error", "Server error: " + e.getMessage());
            req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);
        }
    }
}
