package service;

import model.Product;
import DAO.ProductDAO;

import java.sql.SQLException;
import java.util.List;

public class ProductService {
    private final ProductDAO productDAO;

    public ProductService() {
        this.productDAO = new ProductDAO();
    }

    public List<Product> getAllProducts() throws SQLException {
        return productDAO.findAll();
    }

    public Product getProductById(int id) throws SQLException {
        return productDAO.findById(id);
    }

    public List<Product> getProductsByCategory(int categoryID) throws SQLException {
        return productDAO.findByCategory(categoryID);
    }

    public void createProduct(Product product) throws SQLException {
        productDAO.save(product);
    }

    public void updateProduct(Product product) throws SQLException {
        productDAO.update(product);
    }

    public void deleteProduct(int id) throws SQLException {
        productDAO.delete(id);
    }
}
