package service;

import model.User;
import DAO.UserRepository;

import java.sql.SQLException;
import java.util.List;

public class UserService {
    private final UserRepository userRepository;

    public UserService() {
        this.userRepository = new UserRepository();
    }

    public List<User> getAllUsers() throws SQLException {
        return userRepository.findAll();
    }

    public User getUserById(int id) throws SQLException {
        return userRepository.findById(id);
    }

    public void createUser(User user) throws SQLException {
        userRepository.save(user);
    }

    public void updateUser(User user) throws SQLException {
        userRepository.update(user);
    }

    public void deleteUser(int id) throws SQLException {
        userRepository.delete(id);
    }
}
