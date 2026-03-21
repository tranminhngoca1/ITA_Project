package DAO;

import model.Product;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

#day la product
public class ProductDAO {

    public List<Product> findAll() throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT ProductID, ProductName, Description, ImageUrl, CategoryID, Price, SupplierID, IsActive, CreatedAt FROM Product WHERE IsActive = 1";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Product product = mapResultSetToProduct(rs);
                products.add(product);
            }
        }
        return products;
    }

    public Product findById(int id) throws SQLException {
        String sql = "SELECT ProductID, ProductName, Description, ImageUrl, CategoryID, Price, SupplierID, IsActive, CreatedAt FROM Product WHERE ProductID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProduct(rs);
                }
            }
        }
        return null;
    }

    public List<Product> findByCategory(int categoryID) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT ProductID, ProductName, Description, ImageUrl, CategoryID, Price, SupplierID, IsActive, CreatedAt FROM Product WHERE CategoryID = ? AND IsActive = 1";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, categoryID);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Product product = mapResultSetToProduct(rs);
                    products.add(product);
                }
            }
        }
        return products;
    }

    public void save(Product product) throws SQLException {
        String sql = "INSERT INTO Product (ProductName, Description, ImageUrl, CategoryID, Price, SupplierID, IsActive) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, product.getProductName());
            pstmt.setString(2, product.getDescription());
            pstmt.setString(3, product.getImageUrl());
            pstmt.setInt(4, product.getCategoryID());
            pstmt.setBigDecimal(5, product.getPrice());
            if (product.getSupplierID() != null) {
                pstmt.setInt(6, product.getSupplierID());
            } else {
                pstmt.setNull(6, Types.INTEGER);
            }
            pstmt.setBoolean(7, product.isActive());
            pstmt.executeUpdate();
        }
    }

    public void update(Product product) throws SQLException {
        String sql = "UPDATE Product SET ProductName = ?, Description = ?, ImageUrl = ?, CategoryID = ?, Price = ?, SupplierID = ?, IsActive = ? WHERE ProductID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, product.getProductName());
            pstmt.setString(2, product.getDescription());
            pstmt.setString(3, product.getImageUrl());
            pstmt.setInt(4, product.getCategoryID());
            pstmt.setBigDecimal(5, product.getPrice());
            if (product.getSupplierID() != null) {
                pstmt.setInt(6, product.getSupplierID());
            } else {
                pstmt.setNull(6, Types.INTEGER);
            }
            pstmt.setBoolean(7, product.isActive());
            pstmt.setInt(8, product.getProductID());
            pstmt.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "UPDATE Product SET IsActive = 0 WHERE ProductID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
    }

    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setProductID(rs.getInt("ProductID"));
        product.setProductName(rs.getString("ProductName"));
        product.setDescription(rs.getString("Description"));
        product.setImageUrl(rs.getString("ImageUrl"));
        product.setCategoryID(rs.getInt("CategoryID"));
        product.setPrice(rs.getBigDecimal("Price"));
        product.setSupplierID((Integer) rs.getObject("SupplierID"));
        product.setActive(rs.getBoolean("IsActive"));
        product.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return product;
    }
}
