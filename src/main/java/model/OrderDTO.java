package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class OrderDTO {
    private int orderID;
    private String productName;
    private int quantity;
    private BigDecimal total;
    private Timestamp createdAt;
    private String status;

    public OrderDTO() {}

    public OrderDTO(int orderID, String productName, int quantity, BigDecimal total, Timestamp createdAt, String status) {
        this.orderID = orderID;
        this.productName = productName;
        this.quantity = quantity;
        this.total = total;
        this.createdAt = createdAt;
        this.status = status;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
