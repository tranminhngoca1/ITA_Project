package service;

import DAO.IngredientDAO;
import model.*;
import java.util.List;

public class IngredientService {

    IngredientDAO dao = new IngredientDAO();

    public List<Ingredient> getAll() {
        return dao.getAllIngredients();
    }

    public Ingredient getById(int id) {
        return dao.getById(id);
    }

    public void insert(Ingredient i) {
        dao.insert(i);
    }

    public void update(Ingredient i) {
        dao.update(i);
    }
}
