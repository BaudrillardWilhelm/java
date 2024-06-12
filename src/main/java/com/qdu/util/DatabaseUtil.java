package com.qdu.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;

/**
 * 数据库工具类，负责打开和关闭数据库连接
 *
 * @author Anna
 */
public class DatabaseUtil {
 
    private static final String DRIVER_CLASS;
    private static final String URL;
    private static final String USERNAME;
    private static final String PASSWORD;

    private static final ResourceBundle rb = ResourceBundle.getBundle("dbconfig");
    
    /**
     * 静态代码块，用于从属性文件读取数据库连接用用户名、密码、驱动类和数据库url
     */
    static {
        URL = rb.getString("jdbc.url"); 
        USERNAME = rb.getString("jdbc.username"); 
        PASSWORD = rb.getString("jdbc.password"); 
        DRIVER_CLASS = rb.getString("jdbc.driver");
    }

    public static Connection getConnection() {

        Connection con = null;
        
        try {
            Class.forName(DRIVER_CLASS);
            con=DriverManager.getConnection(URL,USERNAME,PASSWORD);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        return con;
    }
    
    public static void close(ResultSet rs, Statement stmt,Connection con){
        try {
                if(rs!=null) rs.close();
                if(stmt!=null) stmt.close();
                if(con!=null) con.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
    }
}
