package DAO;

import model.*;
import util.DatabaseConnection;

import java.sql.*;
import java.util.*;

public class PurchaseOrderDAO {

    public List<PurchaseOrder> getAllPO() {
        List<PurchaseOrder> list = new ArrayList<>();
        String sql = "SELECT po.POID, s.ShopName, sup.SupplierName,\n"
                + "                   st.Name AS StatusName,\n"
                + "                   po.CreatedAt\n"
                + "            FROM PurchaseOrder po\n"
                + "            JOIN Shop s ON po.ShopID = s.ShopID\n"
                + "            JOIN Supplier sup ON po.SupplierID = sup.SupplierID\n"
                + "            LEFT JOIN Setting st ON po.StatusID = st.SettingID\n"
                + "            ORDER BY po.CreatedAt DESC";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                PurchaseOrder po = new PurchaseOrder();
                po.setPoID(rs.getInt("POID"));
                po.setShopName(rs.getString("ShopName"));
                po.setSupplierName(rs.getString("SupplierName"));
                po.setStatus(rs.getString("StatusName"));
                po.setCreatedAt(rs.getTimestamp("CreatedAt"));
                list.add(po);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<PurchaseOrderDetail> getPODetail(int poID) {
        List<PurchaseOrderDetail> list = new ArrayList<>();
        String sql = """
                   SELECT pod.PODetailID,
                                      i.Name,
                                      pod.Quantity,
                                      pod.ReceivedQuantity,
                                      s.Value AS Unit
                               FROM PurchaseOrderDetail pod
                               JOIN Ingredient i ON pod.IngredientID = i.IngredientID
                               LEFT JOIN Setting s ON i.UnitID = s.SettingID
                               WHERE pod.POID = ?
                   """;
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, poID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PurchaseOrderDetail d = new PurchaseOrderDetail();
                d.setPoDetailID(rs.getInt("PODetailID"));
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

    public int createPO(int shopID, int supplierID, int userID) {
        String sql = """
            INSERT INTO PurchaseOrder
            (ShopID, SupplierID, CreatedBy, StatusID)
            VALUES (?, ?, ?, 20)
        """;
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps
                = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, shopID);
            ps.setInt(2, supplierID);
            ps.setInt(3, userID);
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }

    public void addPODetail(int poID, int ingredientID, double quantity) {
        String sql = """
                   INSERT INTO PurchaseOrderDetail
                               (POID, IngredientID, Quantity)
                               VALUES (?, ?, ?)
                   """;
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, poID);
            ps.setInt(2, ingredientID);
            ps.setDouble(3, quantity);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void receivePO(int poID) {
        String updateStock = """
                           UPDATE i
                                       SET i.StockQuantity = i.StockQuantity + pod.Quantity
                                       FROM Ingredient i
                                       JOIN PurchaseOrderDetail pod
                                       ON i.IngredientID = pod.IngredientID
                                       WHERE pod.POID = ? 
                           """;
        String updateStatus = """
                            UPDATE PurchaseOrder SET StatusID = 23 WHERE POID = ?
                            """;
        try (Connection conn = DatabaseConnection.getConnection()) {

            conn.setAutoCommit(false);

            PreparedStatement ps1 = conn.prepareStatement(updateStock);
            ps1.setInt(1, poID);
            ps1.executeUpdate();

            PreparedStatement ps2 = conn.prepareStatement(updateStatus);
            ps2.setInt(1, poID);
            ps2.executeUpdate();

            conn.commit();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    

}
