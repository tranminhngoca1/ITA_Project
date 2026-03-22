package DAO;

import model.Ingredient;
import util.DatabaseConnection;
import java.sql.*;
import java.util.*;

public class IngredientDAO {

    public List<Ingredient> getAll() {
        List<Ingredient> list = new ArrayList<>();

        String sql = """
            SELECT i.IngredientID, i.Name, i.StockQuantity,
                   i.UnitID, i.SupplierID,
                   s.Value AS UnitName,
                   sup.SupplierName,
                   i.IsActive
            FROM Ingredient i
            LEFT JOIN Setting s ON i.UnitID = s.SettingID
            LEFT JOIN Supplier sup ON i.SupplierID = sup.SupplierID
        """;

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Ingredient i = new Ingredient();
                i.setIngredientID(rs.getInt("IngredientID"));
                i.setName(rs.getString("Name"));
                i.setStockQuantity(rs.getDouble("StockQuantity"));
                i.setUnitID(rs.getInt("UnitID"));
                i.setSupplierID(rs.getInt("SupplierID"));
                i.setUnitName(rs.getString("UnitName"));
                i.setSupplierName(rs.getString("SupplierName"));
                i.setIsActive(rs.getBoolean("IsActive"));
                list.add(i);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void insert(Ingredient i) {
        String sql = """
            INSERT INTO Ingredient (Name, StockQuantity, UnitID, SupplierID, IsActive)
            VALUES (?, ?, ?, ?, ?)
        """;

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            conn.setAutoCommit(false);

            ps.setString(1, i.getName());
            ps.setDouble(2, i.getStockQuantity());
            ps.setInt(3, i.getUnitID());
            ps.setInt(4, i.getSupplierID());
            ps.setBoolean(5, i.isIsActive());

            ps.executeUpdate();

            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
