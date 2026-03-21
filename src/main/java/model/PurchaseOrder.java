
package model;

import java.util.Date;
public class PurchaseOrder {
    private int poID;
    private String shopName;
    private String supplierName;
    private String status;
    private Date createdAt;

    public PurchaseOrder() {
    }

    public PurchaseOrder(int poID, String shopName, String supplierName, String status, Date createdAt) {
        this.poID = poID;
        this.shopName = shopName;
        this.supplierName = supplierName;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getPoID() {
        return poID;
    }

    public void setPoID(int poID) {
        this.poID = poID;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
}
