package service;

import DAO.PurchaseOrderDAO;
import model.PurchaseOrder;
import java.util.List;

public class PurchaseOrderService {

    PurchaseOrderDAO dao = new PurchaseOrderDAO();

    public List<PurchaseOrder> getAll() {
        return dao.getAllPO();
    }

    public void receive(int id) {
        dao.receivePO(id);
    }

    public int createPO(int shopID, int supplierID, int userID) {
        if (shopID <= 0) {
            throw new RuntimeException("Invalid shop!");
        }
        if (supplierID <= 0) {
            throw new RuntimeException("Invalid supplier");
        }

        return dao.createPO(shopID, supplierID, userID);
    }

    public void receivePO(int poID) {

        if (poID <= 0) {
            throw new RuntimeException("Invalid PO");
        }

        dao.receivePO(poID);
    }
}
