
package model;


public class PurchaseOrderDetail {
    private int poDetailID;
    private int poID;
    private String ingredientName;
    private double quantity;
    private double receivedQuantity;
    private String unit;

    public PurchaseOrderDetail() {
    }

    public PurchaseOrderDetail(int poDetailID, int poID, String ingredientName, double quantity, double receivedQuantity, String unit) {
        this.poDetailID = poDetailID;
        this.poID = poID;
        this.ingredientName = ingredientName;
        this.quantity = quantity;
        this.receivedQuantity = receivedQuantity;
        this.unit = unit;
    }

    public int getPoDetailID() {
        return poDetailID;
    }

    public void setPoDetailID(int poDetailID) {
        this.poDetailID = poDetailID;
    }

    public int getPoID() {
        return poID;
    }

    public void setPoID(int poID) {
        this.poID = poID;
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

    public double getReceivedQuantity() {
        return receivedQuantity;
    }

    public void setReceivedQuantity(double receivedQuantity) {
        this.receivedQuantity = receivedQuantity;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }
    
    
}
