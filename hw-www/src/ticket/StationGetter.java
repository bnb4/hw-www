package ticket;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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

	public Station getStation(String route) {

		ArrayList tem_id = new ArrayList();
		ArrayList tem_name = new ArrayList();

		Connection conn;
		try {
			conn = DatabaseHelper.getConnection();

			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM `line` " + "WHERE `line_id` = " + route
					+ "AND `id` != (SELECT MAX(`id`) FROM `line`)");
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				tem_id.add(rs.getString("id"));
				tem_name.add(rs.getString("name"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new Station(tem_id, tem_name);
	}

	class Station {
		public ArrayList id;
		public ArrayList name;

		public Station(ArrayList id, ArrayList name) {
			this.id = id;
			this.name = name;
		}
	}
}
