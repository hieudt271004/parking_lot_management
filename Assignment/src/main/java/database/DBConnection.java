package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String DEFAULT_HOST = "localhost";
    private static final String DEFAULT_PORT = "1433";
    private static final String DEFAULT_DB = "QL_BAIGUIXE";
    // Uncomment these if you are not using integrated security
    // private static final String USERNAME = "sa"; 
    // private static final String PASSWORD = "your_password"; 

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String dbURL = "jdbc:sqlserver://" + DEFAULT_HOST + ":" + DEFAULT_PORT 
                    + ";databaseName=" + DEFAULT_DB 
                    + ";encrypt=false;trustServerCertificate=true;";
            
            // Using Integrated Security (Windows Authentication)
            conn = DriverManager.getConnection(dbURL + "integratedSecurity=true;");
            
            // Or use SQL Server Authentication:
            // conn = DriverManager.getConnection(dbURL, USERNAME, PASSWORD);
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("DB Connection failed: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }
}
