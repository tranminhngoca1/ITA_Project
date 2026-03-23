package controller;

import model.User;
import service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.UUID;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1 MB
    maxFileSize       = 5 * 1024 * 1024,  // 5 MB
    maxRequestSize    = 10 * 1024 * 1024  // 10 MB
)
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
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            // Update text fields
            user.setFullName(req.getParameter("fullName"));
            user.setGender(req.getParameter("gender"));
            user.setPhone(req.getParameter("phone"));
            user.setAddress(req.getParameter("address"));

            // Handle avatar file upload
            Part filePart = req.getPart("avatarFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = saveAvatar(filePart, req);
                if (fileName != null) {
                    user.setAvatarUrl(req.getContextPath() + "/uploads/avatars/" + fileName);
                }
            }

            userService.updateUser(user);
            session.setAttribute("loggedInUser", user);
            resp.sendRedirect(req.getContextPath() + "/user/profile?success=1");

        } catch (SQLException e) {
            req.setAttribute("error", "Server error: " + e.getMessage());
            req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);
        }
    }

    private String saveAvatar(Part filePart, HttpServletRequest req) throws IOException {
        String originalName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String ext = originalName.contains(".")
                ? originalName.substring(originalName.lastIndexOf('.'))
                : "";

        // Only allow image types
        if (!ext.matches("(?i)\\.(jpg|jpeg|png|gif|webp)")) return null;

        String uploadDir = req.getServletContext().getRealPath("/uploads/avatars");
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        String newFileName = UUID.randomUUID().toString() + ext;
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, new File(dir, newFileName).toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        return newFileName;
    }
}
