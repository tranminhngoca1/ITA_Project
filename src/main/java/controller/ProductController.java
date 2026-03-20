package controller;

import model.Product;
import service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public class ProductController extends HttpServlet {
    private final ProductService productService;

    public ProductController() {
        this.productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String pathInfo = req.getPathInfo();
        String category = req.getParameter("category");
        
        try {
            if (category != null) {
                int categoryID = Integer.parseInt(category);
                List<Product> products = productService.getProductsByCategory(categoryID);
                resp.getWriter().write(toJson(products));
            } else if (pathInfo == null || pathInfo.equals("/")) {
                List<Product> products = productService.getAllProducts();
                resp.getWriter().write(toJson(products));
            } else {
                int id = Integer.parseInt(pathInfo.substring(1));
                Product product = productService.getProductById(id);
                if (product != null) {
                    resp.getWriter().write(toJson(product));
                } else {
                    resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    resp.getWriter().write("{\"error\":\"Product not found\"}");
                }
            }
        } catch (SQLException e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    private String toJson(Product product) {
        return String.format(
            "{\"productID\":%d,\"productName\":\"%s\",\"description\":\"%s\",\"price\":%s,\"categoryID\":%d}",
            product.getProductID(), 
            product.getProductName(), 
            product.getDescription() != null ? product.getDescription() : "",
            product.getPrice().toString(),
            product.getCategoryID()
        );
    }

    private String toJson(List<Product> products) {
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < products.size(); i++) {
            json.append(toJson(products.get(i)));
            if (i < products.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        return json.toString();
    }
}
