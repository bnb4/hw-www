package ticket;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import database.DatabaseHelper;

public class CarGetter {

	// Singleton
	private static CarGetter instance;

	public static CarGetter getInstance() {
		if (instance == null) {
			instance = new CarGetter();
		}
		return instance;
	}
	
	public List<Car> getCar(int route, int start, String date, int destination){
		
		List<Car> out = new ArrayList<Car>();
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date inputDate = null;
		try {
			inputDate = dateFormat.parse(date);
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		Calendar c = Calendar.getInstance();
		c.setTime(inputDate);
		int dayOfWeek = c.get(Calendar.DAY_OF_WEEK)-1;

		Connection conn;
		try {
			conn = DatabaseHelper.getConnection();

			//班次
			PreparedStatement stmt = conn.prepareStatement("SELECT car_name, weight, car_type.name, car_time FROM `timetable` "
					+ "INNER JOIN `car` ON timetable.plate = car.plate "
					+ "INNER JOIN `car_type` ON car_type.id = car.car_type "
					+ "WHERE `week` = ? AND `route` = ?");
	    	stmt.setInt(1, dayOfWeek);
	    	stmt.setInt(2, route);
	    	
			ResultSet rs = stmt.executeQuery();
			
			//出發地
			PreparedStatement stmt_start = conn.prepareStatement("SELECT * FROM `line` "
					+ "WHERE `line_id` = ? AND `id` = ?");
			stmt_start.setInt(1, route);
			stmt_start.setInt(2, start);
			
			ResultSet rs_start = stmt_start.executeQuery();
			rs_start.first();
			
			//目的地
			PreparedStatement stmt_des = conn.prepareStatement("SELECT * FROM `line` "
					+ "WHERE `line_id` = ? AND `id` = ?");
			stmt_des.setInt(1, route);
			stmt_des.setInt(2, destination);
			
			ResultSet rs_des = stmt_des.executeQuery();
			rs_des.first();
			
			while (rs.next()) {
				int price = Math.abs(rs_des.getInt("price")-rs_start.getInt("price"))*rs.getInt("weight");
				
				LocalTime ltime_start = LocalTime.parse(rs.getString("car_time"));
				LocalTime ltime_des = LocalTime.parse(rs.getString("car_time"));
				ltime_start = ltime_start.plusMinutes(rs_start.getInt("time"));
				ltime_des = ltime_des.plusMinutes(rs_des.getInt("time"));
				String time_start = ltime_start.toString();
				String time_des = ltime_des.toString();
				
				out.add(new Car(rs.getString("car_name"), time_start, time_des, rs.getString("name"), price));
			}

		} catch (SQLException e) {
			e.getErrorCode();
		}
		return out;
	}
	
	class Car {

		public String car_name;
		public String start_time;
		public String arrival_time;
		public String name;
		public String price;
		public String available_seats;
		
		public Car(String car_name, String start_time, String arrival_time, String name, int price) {
			this.car_name = car_name;
			this.start_time = start_time;
			this.arrival_time = arrival_time;
			this.name = name;
			this.price = String.valueOf(price);
			this.available_seats = String.valueOf(0);
		}
		
	}
}
