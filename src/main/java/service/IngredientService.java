package service;

import DAO.IngredientDAO;
import model.Ingredient;
import java.util.List;

public class IngredientService {

    private IngredientDAO dao = new IngredientDAO();

    public List<Ingredient> getAll() {
        return dao.getAll();
    }

    public void insert(Ingredient i) {
        if (i.getName() == null || i.getName().isEmpty()) {
            throw new RuntimeException("Name required");
        }
        dao.insert(i);
    }
}
