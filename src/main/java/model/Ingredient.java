
package model;


public class Ingredient {
    private int ingredientID;
    private String name;
    private double stockQuantity;
    private String unit;
    private String supplierName;
    private boolean isActive;

    public Ingredient() {
    }

    public Ingredient(int ingredientID, String name, double stockQuantity, String unit, String supplierName, boolean isActive) {
        this.ingredientID = ingredientID;
        this.name = name;
        this.stockQuantity = stockQuantity;
        this.unit = unit;
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

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
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
