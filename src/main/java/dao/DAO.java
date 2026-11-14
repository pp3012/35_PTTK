package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
    protected static Connection con;

    public DAO() {
        try {
            if (con == null || con.isClosed()) {
                String dbHost = System.getenv("DB_HOST") != null ? System.getenv("DB_HOST") : "localhost";
                String dbPort = System.getenv("DB_PORT") != null ? System.getenv("DB_PORT") : "3306";
                String dbName = System.getenv("DB_NAME") != null ? System.getenv("DB_NAME") : "OnlineShop";
                String dbUser = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "root";
                String dbPass = System.getenv("DB_PASS") != null ? System.getenv("DB_PASS") : "123456";

                String url = "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName
                        + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&characterEncoding=UTF-8";

                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, dbUser, dbPass);
            }
        } catch (Exception e) {
            System.err.println("DAO Database Connection Error: " + e.getMessage());
        }
    }

    public boolean isConnected() {
        try {
            return con != null && !con.isClosed();
        } catch (Exception e) {
            return false;
        }
    }
}
