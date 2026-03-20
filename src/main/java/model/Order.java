package model;

import java.sql.Timestamp;

public class Order {
    private int orderID;
    private int shopID;
    private int createdBy;
    private Integer statusID;
    private String cancellationReason;
    private Timestamp createdAt;

    public Order() {
    }

    public Order(int orderID, int shopID, int createdBy, Integer statusID, String cancellationReason) {
        this.orderID = orderID;
        this.shopID = shopID;
        this.createdBy = createdBy;
        this.statusID = statusID;
        this.cancellationReason = cancellationReason;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getShopID() {
        return shopID;
    }

    public void setShopID(int shopID) {
        this.shopID = shopID;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public Integer getStatusID() {
        return statusID;
    }

    public void setStatusID(Integer statusID) {
        this.statusID = statusID;
    }

    public String getCancellationReason() {
        return cancellationReason;
    }

    public void setCancellationReason(String cancellationReason) {
        this.cancellationReason = cancellationReason;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
