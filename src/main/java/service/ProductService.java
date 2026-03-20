package service;

import model.Product;
import DAO.ProductRepository;

import java.sql.SQLException;
import java.util.List;

public class ProductService {
    private final ProductRepository productRepository;

    public ProductService() {
        this.productRepository = new ProductRepository();
    }

    public List<Product> getAllProducts() throws SQLException {
        return productRepository.findAll();
    }

    public Product getProductById(int id) throws SQLException {
        return productRepository.findById(id);
    }

    public List<Product> getProductsByCategory(int categoryID) throws SQLException {
        return productRepository.findByCategory(categoryID);
    }

    public void createProduct(Product product) throws SQLException {
        productRepository.save(product);
    }

    public void updateProduct(Product product) throws SQLException {
        productRepository.update(product);
    }

    public void deleteProduct(int id) throws SQLException {
        productRepository.delete(id);
    }
}
