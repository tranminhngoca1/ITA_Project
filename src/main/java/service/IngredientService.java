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
    
     public Ingredient getById(int id) {
        return dao.getById(id);
    }
     
      public void update(Ingredient i) {
        dao.update(i);
    }

    public void delete(int id) {
        dao.delete(id);
    }
}
