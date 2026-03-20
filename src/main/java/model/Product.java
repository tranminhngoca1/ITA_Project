package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Product {
    private int productID;
    private String productName;
    private String description;
    private String imageUrl;
    private int categoryID;
    private BigDecimal price;
    private Integer supplierID;
    private boolean isActive;
    private Timestamp createdAt;

    public Product() {
    }

    public Product(int productID, String productName, String description, String imageUrl, 
                   int categoryID, BigDecimal price, Integer supplierID, boolean isActive) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
        this.imageUrl = imageUrl;
        this.categoryID = categoryID;
        this.price = price;
        this.supplierID = supplierID;
        this.isActive = isActive;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getSupplierID() {
        return supplierID;
    }

    public void setSupplierID(Integer supplierID) {
        this.supplierID = supplierID;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
