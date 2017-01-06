package ticket;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.DatabaseHelper;

public class StationGetter {

	// Singleton
	private static StationGetter instance;

	public static StationGetter getInstance() {
		if (instance == null) {
			instance = new StationGetter();
		}
		return instance;
	}

	public List<Station> getStation(String route) {
		
		List<Station> out = new ArrayList<Station>();

		Connection conn;
		try {
			conn = DatabaseHelper.getConnection();

			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM `line` WHERE `line_id` = ? AND `id` != (SELECT MAX(`id`) FROM `line`)");
	    	stmt.setString(1, route);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				out.add(new Station(rs.getString("id"), rs.getString("name")));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return out;
	}

	class Station {
		public String id;
		public String name;
		
		public Station(String id, String name) {
			this.id = id;
			this.name = name;
		}
	}
}
