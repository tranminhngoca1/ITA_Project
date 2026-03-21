
package model;

import java.util.Date;
public class Issue {
     private int issueID;

    // để insert DB
    private int ingredientID;
    private int statusID;
    private int createdBy;

    // để hiển thị
    private String ingredientName;
    private double quantity;
    private String status;
    private Date createdAt;

    public Issue() {
    }

    public Issue(int issueID, int ingredientID, int statusID, int createdBy, String ingredientName, double quantity, String status, Date createdAt) {
        this.issueID = issueID;
        this.ingredientID = ingredientID;
        this.statusID = statusID;
        this.createdBy = createdBy;
        this.ingredientName = ingredientName;
        this.quantity = quantity;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getIssueID() {
        return issueID;
    }

    public void setIssueID(int issueID) {
        this.issueID = issueID;
    }

    public int getIngredientID() {
        return ingredientID;
    }

    public void setIngredientID(int ingredientID) {
        this.ingredientID = ingredientID;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public String getIngredientName() {
        return ingredientName;
    }

    public void setIngredientName(String ingredientName) {
        this.ingredientName = ingredientName;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
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
