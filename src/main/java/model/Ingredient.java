
package model;


public class Ingredient {
    private int ingredientID;
    private String name;
    private double stockQuantity;

    private int unitID;
    private int supplierID;

    // hiển thị
    private String unitName;
    private String supplierName;

    private boolean isActive;

    public Ingredient() {
    }

    public Ingredient(int ingredientID, String name, double stockQuantity, int unitID, int supplierID, String unitName, String supplierName, boolean isActive) {
        this.ingredientID = ingredientID;
        this.name = name;
        this.stockQuantity = stockQuantity;
        this.unitID = unitID;
        this.supplierID = supplierID;
        this.unitName = unitName;
        this.supplierName = supplierName;
        this.isActive = isActive;
    }

    public int getIngredientID() {
        return ingredientID;
    }

    public void setIngredientID(int ingredientID) {
        this.ingredientID = ingredientID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(double stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public int getUnitID() {
        return unitID;
    }

    public void setUnitID(int unitID) {
        this.unitID = unitID;
    }

    public int getSupplierID() {
        return supplierID;
    }

    public void setSupplierID(int supplierID) {
        this.supplierID = supplierID;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }
    
            
            
}
