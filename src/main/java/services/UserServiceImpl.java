package services;

import dao.UserDAO;
import dao.UserDAOImpl;
import entities.User;

public class UserServiceImpl implements UserService {

    // Injecté par Spring via spring-beans.xml
    private UserDAO userDAO;

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    @Override
    public User authenticate(String username, String password) {
        if (username == null || password == null) return null;
        return userDAO.findByUsernameAndPassword(username.trim(), password.trim());
    }

    /**
     * Insère les utilisateurs par défaut si ils n'existent pas.
     * Appelé via init-method dans spring-beans.xml.
     */
    @Override
    public void initDefaultUsers() {
        insertIfNotExists("admin",    "admin123", "ADMIN");
        insertIfNotExists("user",     "user123",  "USER");
        insertIfNotExists("cherradi", "tdia2024", "ADMIN");
        System.out.println("=== Utilisateurs initialisés en BDD ===");
    }

    private void insertIfNotExists(String username, String password, String role) {
        if (!userDAO.existsByUsername(username)) {
            userDAO.addUser(new User(username, password, role));
        }
    }
}