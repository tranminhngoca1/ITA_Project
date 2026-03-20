package util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseConnection {
    private static String url;
    private static String username;
    private static String password;
    private static String driver;

    static {
        try (InputStream input = DatabaseConnection.class.getClassLoader()
                .getResourceAsStream("db.properties")) {
            if (input == null) {
                System.err.println("Critical Error: db.properties not found in classpath!");
                throw new RuntimeException("db.properties not found");
            }
            Properties prop = new Properties();
            prop.load(input);
            
            url = prop.getProperty("db.url");
            username = prop.getProperty("db.username");
            password = prop.getProperty("db.password");
            driver = prop.getProperty("db.driver");
            
            Class.forName(driver);
            System.out.println("Database driver loaded successfully: " + driver);
        } catch (IOException | ClassNotFoundException e) {
            System.err.println("Error initializing DatabaseConnection: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to load database configuration", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }
}
