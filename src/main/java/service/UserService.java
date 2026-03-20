package service;

import model.User;
import DAO.UserDAO;

import java.sql.SQLException;
import java.util.List;

public class UserService {
    private final UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    public List<User> getAllUsers() throws SQLException {
        return userDAO.findAll();
    }

    public User getUserById(int id) throws SQLException {
        return userDAO.findById(id);
    }

    public User getUserByEmail(String email) throws SQLException {
        return userDAO.findByEmail(email);
    }

    public void createUser(User user) throws SQLException {
        userDAO.save(user);
    }

    public void updateUser(User user) throws SQLException {
        userDAO.update(user);
    }

    public void deleteUser(int id) throws SQLException {
        userDAO.delete(id);
    }
}
