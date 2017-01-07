package ticket;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.DatabaseHelper;

public class DestinationGetter {

	private static DestinationGetter instance;

	public static DestinationGetter getInstance() {
		if (instance == null) {
			instance = new DestinationGetter();
		}
		return instance;
	}
	
	public List<Destination> getDestination(String route, String start) {
		
		List<Destination> out = new ArrayList<Destination>();

		Connection conn;
		try {
			conn = DatabaseHelper.getConnection();

			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM `line` WHERE `line_id` = ? AND `id` > ?");
	    	stmt.setString(1, route);
	    	stmt.setString(2, start);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				out.add(new Destination(rs.getString("id"), rs.getString("name")));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return out;
	}
	class Destination {
		public String id;
		public String name;
		
		public Destination(String id, String name) {
			this.id = id;
			this.name = name;
		}
	}
}
