package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseHelper {
	
	public static Connection getConnection() throws SQLException {
		try { 
		    Class.forName("com.mysql.jdbc.Driver"); 
		} catch(ClassNotFoundException e) {
		    System.out.println("找不到驅動程式類別"); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return DriverManager.getConnection("jdbc:mysql://localhost/hw-www?useUnicode=true&characterEncoding=Big5", "hw-www", "ggininder");
	}
	
}
