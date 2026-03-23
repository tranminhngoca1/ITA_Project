package service;

import model.User;
import DAO.UserDAO;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

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

    public List<User> searchUsers(String name, String status, int page, int limit) throws SQLException {
        int offset = (page - 1) * limit;
        if (offset < 0) offset = 0;
        return userDAO.searchUsers(name, status, offset, limit);
    }

    public int countTotalUsers(String name, String status) throws SQLException {
        return userDAO.countTotalUsers(name, status);
    }

    public User authenticate(String email, String password) throws SQLException {
        User user = userDAO.findByEmail(email);
        if (user != null && user.getPasswordHash().equals(password)) {
            return user;
        }
        return null;
    }
    public Map<Integer, String> getRoles() throws SQLException {
        return userDAO.getRoles();
    }
}
