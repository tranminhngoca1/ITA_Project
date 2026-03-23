package controller;

import model.Setting;
import service.SettingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class SettingController extends HttpServlet {
    private final SettingService settingService;

    public SettingController() {
        this.settingService = new SettingService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getParameter("action");
        
        try {
            if (action == null || action.equals("list")) {
                handleList(req, resp);
            } else if (action.equals("add")) {
                handleAddForm(req, resp);
            } else if (action.equals("edit")) {
                handleEditForm(req, resp);
            } else if (action.equals("delete")) {
                handleDelete(req, resp);
            } else {
                handleList(req, resp);
            }
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        
        try {
            if (action.equals("create")) {
                handleCreate(req, resp);
            } else if (action.equals("update")) {
                handleUpdate(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/settings?action=list");
            }
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    private void handleList(HttpServletRequest req, HttpServletResponse resp) 
            throws SQLException, ServletException, IOException {
        String name = req.getParameter("name");
        String type = req.getParameter("type");
        String status = req.getParameter("status");
        
        List<Setting> settings;
        if ((name != null && !name.trim().isEmpty()) || 
            (type != null && !type.trim().isEmpty() && !type.equals("all")) || 
            (status != null && !status.trim().isEmpty() && !status.equals("all"))) {
            settings = settingService.getSettingsByFilter(name, type, status);
        } else {
            settings = settingService.getAllSettings();
        }
        
        List<String> types = settingService.getAllTypes();
        
        req.setAttribute("settings", settings);
        req.setAttribute("types", types);
        req.setAttribute("selectedName", name);
        req.setAttribute("selectedType", type);
        req.setAttribute("selectedStatus", status);
        
        req.getRequestDispatcher("/setting-list.jsp").forward(req, resp);
    }

    private void handleAddForm(HttpServletRequest req, HttpServletResponse resp) 
            throws SQLException, ServletException, IOException {
        List<String> types = settingService.getAllTypes();
        req.setAttribute("types", types);
        req.getRequestDispatcher("/setting-form.jsp").forward(req, resp);
    }

    private void handleEditForm(HttpServletRequest req, HttpServletResponse resp) 
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Setting setting = settingService.getSettingById(id);
        
        if (setting == null) {
            resp.sendRedirect(req.getContextPath() + "/settings?action=list");
            return;
        }
        
        List<String> types = settingService.getAllTypes();
        req.setAttribute("setting", setting);
        req.setAttribute("types", types);
        req.getRequestDispatcher("/setting-form.jsp").forward(req, resp);
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse resp) 
            throws SQLException, IOException {
        Setting setting = new Setting();
        setting.setName(req.getParameter("name"));
        setting.setType(req.getParameter("type"));
        setting.setValue(req.getParameter("value"));
        setting.setPriority(Integer.parseInt(req.getParameter("priority")));
        setting.setDescription(req.getParameter("description"));
        setting.setActive(req.getParameter("isActive") != null);
        
        settingService.createSetting(setting);
        resp.sendRedirect(req.getContextPath() + "/settings?action=list");
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) 
            throws SQLException, IOException {
        Setting setting = new Setting();
        setting.setSettingID(Integer.parseInt(req.getParameter("id")));
        setting.setName(req.getParameter("name"));
        setting.setType(req.getParameter("type"));
        setting.setValue(req.getParameter("value"));
        setting.setPriority(Integer.parseInt(req.getParameter("priority")));
        setting.setDescription(req.getParameter("description"));
        setting.setActive(req.getParameter("isActive") != null);
        
        settingService.updateSetting(setting);
        resp.sendRedirect(req.getContextPath() + "/settings?action=list");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) 
            throws SQLException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        settingService.deleteSetting(id);
        resp.sendRedirect(req.getContextPath() + "/settings?action=list");
    }
}
