package service;

import DAO.ShopDAO;
import model.Shop;

import java.sql.SQLException;
import java.util.List;

public class ShopService {
    private final ShopDAO shopDAO = new ShopDAO();

    public List<Shop> getAllShops() throws SQLException {
        return shopDAO.findAll();
    }

    public List<Shop> getShopsByOwner(int ownerID) throws SQLException {
        return shopDAO.findByOwner(ownerID);
    }

    public List<Shop> search(String keyword, String status) throws SQLException {
        return shopDAO.search(keyword, status);
    }

    public Shop getShopById(int id) throws SQLException {
        return shopDAO.findById(id);
    }

    public void createShop(Shop shop) throws SQLException {
        shopDAO.save(shop);
    }

    public void updateShop(Shop shop) throws SQLException {
        shopDAO.update(shop);
    }
}
