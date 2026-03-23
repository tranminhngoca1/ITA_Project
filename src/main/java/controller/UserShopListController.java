package controller;

import model.Shop;
import model.User;
import service.ShopService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class UserShopListController extends HttpServlet {
    private final ShopService shopService = new ShopService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (req.getSession().getAttribute("loggedInUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");

        try {
            if ("detail".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Shop shop = shopService.getShopById(id);
                req.setAttribute("shop", shop);
                req.getRequestDispatcher("/user/shop-detail.jsp").forward(req, resp);

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Shop shop = shopService.getShopById(id);
                req.setAttribute("shop", shop);
                req.getRequestDispatcher("/user/shop-edit.jsp").forward(req, resp);

            } else if ("add".equals(action)) {
                req.getRequestDispatcher("/user/shop-add.jsp").forward(req, resp);

            } else {
                String keyword = req.getParameter("keyword");
                String status  = req.getParameter("status");
                List<Shop> shops = (keyword != null || status != null)
                        ? shopService.search(keyword, status)
                        : shopService.getAllShops();
                req.setAttribute("shops", shops);
                req.setAttribute("keyword", keyword);
                req.setAttribute("status", status);
                req.getRequestDispatcher("/user/shoplist.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            req.setAttribute("error", "Server error: " + e.getMessage());
            req.getRequestDispatcher("/user/shoplist.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (req.getSession().getAttribute("loggedInUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");

        try {
            if ("add".equals(action)) {
                User user = (User) req.getSession().getAttribute("loggedInUser");
                Shop shop = new Shop();
                shop.setShopName(req.getParameter("shopName"));
                shop.setAddress(req.getParameter("address"));
                shop.setPhone(req.getParameter("phone"));
                shop.setShopImage(req.getParameter("shopImage"));
                shop.setOwnerID(user.getUserID());
                shop.setActive(true);
                shopService.createShop(shop);
                resp.sendRedirect(req.getContextPath() + "/user/shoplist?success=added");

            } else if ("edit".equals(action)) {
                Shop shop = new Shop();
                shop.setShopID(Integer.parseInt(req.getParameter("shopID")));
                shop.setShopName(req.getParameter("shopName"));
                shop.setAddress(req.getParameter("address"));
                shop.setPhone(req.getParameter("phone"));
                shop.setShopImage(req.getParameter("shopImage"));
                shop.setActive("true".equals(req.getParameter("isActive")));
                shopService.updateShop(shop);
                resp.sendRedirect(req.getContextPath() + "/user/shoplist?success=updated");
            }
        } catch (SQLException e) {
            req.setAttribute("error", "Server error: " + e.getMessage());
            req.getRequestDispatcher("/user/shoplist.jsp").forward(req, resp);
        }
    }
}
