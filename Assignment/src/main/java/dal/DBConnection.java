package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Database credentials and connection URL
    private static final String DEFAULT_HOST = "localhost";
    private static final String DEFAULT_PORT = "1433";
    private static final String DEFAULT_DB = "QL_BAIGUIXE";
    // Replace with your SQL Server username and password or use integratedSecurity=true
    private static final String USERNAME = "sa"; 
    private static final String PASSWORD = "123"; 

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Register JDBC driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            
            // Open a connection
            String dbURL = "jdbc:sqlserver://" + DEFAULT_HOST + ":" + DEFAULT_PORT 
                    + ";databaseName=" + DEFAULT_DB 
                    + ";encrypt=false;trustServerCertificate=true;";
            // Uncomment the following line if you want to use SQL Server Authentication
            // conn = DriverManager.getConnection(dbURL, USERNAME, PASSWORD);
            
            // Using Integrated Security (Windows Authentication) by default
            conn = DriverManager.getConnection(dbURL + "integratedSecurity=true;");
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Failed to connect to the database: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }
}
