package DAO;

import model.Ingredient;
import util.DatabaseConnection;

import java.sql.*;
import java.util.*;

public class IngredientDAO {

    public List<Ingredient> getAllIngredients() {
        List<Ingredient> list = new ArrayList<>();
        String sql = """
                   SELECT i.IngredientID, i.Name, i.StockQuantity,
                                      s.Value AS Unit,
                                      sup.SupplierName,
                                      i.IsActive
                               FROM Ingredient i
                               LEFT JOIN Setting s ON i.UnitID = s.SettingID
                               LEFT JOIN Supplier sup ON i.SupplierID = sup.SupplierID
                   """;
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Ingredient(
                        rs.getInt("IngredientID"),
                        rs.getString("Name"),
                        rs.getDouble("StockQuantity"),
                        rs.getString("Unit"),
                        rs.getString("SupplierName"),
                        rs.getBoolean("IsActive")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Ingredient getById(int id) {
        String sql = "SELECT * FROM Ingredient WHERE IngredientID = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Ingredient i = new Ingredient();
                i.setIngredientID(rs.getInt("IngredientID"));
                i.setName(rs.getString("Name"));
                i.setStockQuantity(rs.getDouble("StockQuantity"));
                i.setUnit(rs.getString("Unit"));
                i.setSupplierName(rs.getString("SupplierName"));
                i.setIsActive(rs.getBoolean("IsActive"));
                return i;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insert(Ingredient i) {
        String sql = """
                   INSERT INTO Ingredient (Name, StockQuantity, UnitID, SupplierID, IsActive)
                               VALUES (?, ?,?, ?, ?)
                   """;
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, i.getName());
            ps.setDouble(2, i.getStockQuantity());
            ps.setString(3, i.getUnit());
            ps.setString(4, i.getSupplierName());
            ps.setBoolean(5, i.isIsActive());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(Ingredient i) {
        String sql = """
                   UPDATE Ingredient
                               SET Name = ?, StockQuantity = ?, UnitID =?, SupplierID = ?, IsActive = ?
                               WHERE IngredientID = ?
                   """;
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, i.getName());
            ps.setDouble(2, i.getStockQuantity());
            ps.setString(3, i.getUnit());
            ps.setString(4, i.getSupplierName());
            ps.setBoolean(5, i.isIsActive());
            ps.setInt(6, i.getIngredientID());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
