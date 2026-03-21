package service;

import DAO.PurchaseOrderDetailDAO;
import model.PurchaseOrderDetail;

import java.util.List;

public class PurchaseOrderDetailService {

    private PurchaseOrderDetailDAO detailDAO = new PurchaseOrderDetailDAO();

    // ===== GET DETAIL =====
    public List<PurchaseOrderDetail> getByPOID(int poID) {

        if (poID <= 0) {
            throw new RuntimeException("Invalid PO");
        }

        return detailDAO.getByPOID(poID);
    }

    // ===== ADD DETAIL =====
    public void addDetail(int poID, int ingredientID, double quantity) {

        if (poID <= 0) {
            throw new RuntimeException("Invalid PO");
        }

        if (ingredientID <= 0) {
            throw new RuntimeException("Invalid ingredient");
        }

        if (quantity <= 0) {
            throw new RuntimeException("Quantity must > 0");
        }

        detailDAO.insert(poID, ingredientID, quantity);
    }

    // ===== UPDATE RECEIVED =====
    public void updateReceived(int poDetailID, double receivedQuantity) {

        if (poDetailID <= 0) {
            throw new RuntimeException("Invalid detail ID");
        }

        if (receivedQuantity < 0) {
            throw new RuntimeException("Received quantity must >= 0");
        }

        detailDAO.updateReceived(poDetailID, receivedQuantity);
    }
}
