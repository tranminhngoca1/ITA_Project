package DAO;

import util.DatabaseConnection;

import java.sql.*;
import java.util.*;
import model.Issue;

public class IssueDAO {

    public List<Issue> getAllIssues() {
        List<Issue> list = new ArrayList<>();
        String sql = """
                   SELECT isue.IssueID,
                                  i.Name,
                                  isue.Quantity,
                                  st.Name AS Status,
                                  isue.CreatedAt
                           FROM Issue isue
                           JOIN Ingredient i ON isue.IngredientID = i.IngredientID
                           LEFT JOIN Setting st ON isue.StatusID = st.SettingID
                   """;
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Issue issue = new Issue();
                issue.setIssueID(rs.getInt("IssueID"));
                issue.setIngredientName(rs.getString("Name"));
                issue.setQuantity(rs.getDouble("Quantity"));
                issue.setStatus(rs.getString("Status"));
                issue.setCreatedAt(rs.getTimestamp("CreatedAt"));
                list.add(issue);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void insert(Issue issue) {
        String insertSql = """
                   INSERT INTO Issue (IngredientID, Quantity, StatusID, CreatedBy, CreatedAt)
                   VALUES (?, ?, ?, ?, GETDATE())
                   """;
        String updateStockSql = """
                              UPDATE Ingredient
                              SET StockQuantity = StockQuantity - ?
                              WHERE IngredientID = ?
                              """;
        try (Connection conn = DatabaseConnection.getConnection()) {

            conn.setAutoCommit(false); // transaction

            // insert issue
            PreparedStatement ps1 = conn.prepareStatement(insertSql);
            ps1.setInt(1, issue.getIngredientID());
            ps1.setDouble(2, issue.getQuantity());
            ps1.setInt(3, issue.getStatusID());
            ps1.setInt(4, issue.getCreatedBy());

            ps1.executeUpdate();

            // update stock
            PreparedStatement ps2 = conn.prepareStatement(updateStockSql);
            ps2.setDouble(1, issue.getQuantity());
            ps2.setInt(2, issue.getIngredientID());

            ps2.executeUpdate();

            conn.commit(); // commit cả 2

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
