
package DAO;

import model.PurchaseOrderDetail;
import util.DatabaseConnection;

import java.sql.*;
import java.util.*;
public class PurchaseOrderDetailDAO {
     // ===== GET DETAIL =====
    public List<PurchaseOrderDetail> getByPOID(int poID) {

        List<PurchaseOrderDetail> list = new ArrayList<>();

        String sql = """
            SELECT pod.PODetailID,
                   pod.POID,
                   i.Name,
                   pod.Quantity,
                   pod.ReceivedQuantity,
                   s.Value AS Unit
            FROM PurchaseOrderDetail pod
            JOIN Ingredient i ON pod.IngredientID = i.IngredientID
            LEFT JOIN Setting s ON i.UnitID = s.SettingID
            WHERE pod.POID = ?
        """;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, poID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PurchaseOrderDetail d = new PurchaseOrderDetail();
                d.setPoDetailID(rs.getInt("PODetailID"));
                d.setPoID(rs.getInt("POID")); // 🔥 chuẩn
                d.setIngredientName(rs.getString("Name"));
                d.setQuantity(rs.getDouble("Quantity"));
                d.setReceivedQuantity(rs.getDouble("ReceivedQuantity"));
                d.setUnit(rs.getString("Unit"));
                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ===== ADD DETAIL =====
    public void insert(int poID, int ingredientID, double quantity) {

        String sql = """
            INSERT INTO PurchaseOrderDetail
            (POID, IngredientID, Quantity)
            VALUES (?, ?, ?)
        """;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, poID);
            ps.setInt(2, ingredientID);
            ps.setDouble(3, quantity);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ===== UPDATE RECEIVED QUANTITY =====
    public void updateReceived(int poDetailID, double receivedQuantity) {

        String sql = """
            UPDATE PurchaseOrderDetail
            SET ReceivedQuantity = ?
            WHERE PODetailID = ?
        """;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDouble(1, receivedQuantity);
            ps.setInt(2, poDetailID);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
