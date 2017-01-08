package ticket;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.Date;
import java.util.TimeZone;

import javax.servlet.http.HttpSession;

import database.DatabaseHelper;

public class GetTicket {

	public static boolean getTicket(HttpSession session, String start, String end, String date, String car_name) {
		
		int _end = end == null ? 0 : Integer.parseInt(end);
		int _start = start == null ? 0 : Integer.parseInt(start);
		date = date == null ? "" : date;
		car_name = car_name == null ? "" : car_name;
		
		Connection conn;
    	try {
    		
    		//檢查重複訂票
			conn = DatabaseHelper.getConnection();
    		PreparedStatement stmt_chk = conn.prepareStatement("SELECT COUNT(*) AS c FROM `ticket` "
    				+ "WHERE `user_id` = ? AND `car_date` = ? AND `car_name` = ?");
			stmt_chk.setString(1, session.getAttribute("user_id").toString());
			stmt_chk.setString(2, date);
			stmt_chk.setString(3, car_name);
			ResultSet rs_chk = stmt_chk.executeQuery();
    		System.out.println(stmt_chk);
			
			rs_chk.first();
			
			if (rs_chk.getInt("c")>0) {
				session.setAttribute("error", "duplicate");
				return false;
			}
			
			//檢查是否有位置
			SeatsGetter seat_getter = SeatsGetter.getInstance();
			String status = seat_getter.getSeats(car_name, date, _start, _end).status;
			if (!status.equals("success")) {
				session.setAttribute("error", "status");
				return false;
			}
			
			//班次
    		PreparedStatement stmt = conn.prepareStatement("SELECT car_name, weight, car_type.name, route, car_time FROM `timetable`  "
    				+ "INNER JOIN `car` ON timetable.plate = car.plate "
    				+ "INNER JOIN `car_type` ON car_type.id = car.car_type "
    				+ "WHERE `car_name` = ?");
    		stmt.setString(1, car_name);
			ResultSet rs = stmt.executeQuery();
			System.out.println(rs);
			
			rs.first();
			
			//出發地
    		PreparedStatement stmt_start = conn.prepareStatement("SELECT * FROM `line` WHERE `line_id` = ? AND `id` = ?");
    		stmt_start.setInt(1, rs.getInt("route"));
    		stmt_start.setInt(2, _start);
			ResultSet rs_start = stmt_start.executeQuery();
			System.out.println(stmt_start);
			
			rs_start.first();
			
			//目的地
    		PreparedStatement stmt_end = conn.prepareStatement("SELECT * FROM `line` WHERE `line_id` = ? AND `id` = ?");
    		stmt_end.setInt(1, rs.getInt("route"));
    		stmt_end.setInt(2, _end);
			ResultSet rs_end = stmt_end.executeQuery();
			System.out.println(stmt_end);
			
			rs_end.first();
			
			
			int price = Math.abs(rs_end.getInt("price")-rs_start.getInt("price"))*rs.getInt("weight");	//票價
			
			LocalTime ltime_start = LocalTime.parse(rs.getString("car_time"));
			LocalTime ltime_end = LocalTime.parse(rs.getString("car_time"));
			ltime_start = ltime_start.plusMinutes(rs_start.getInt("time"));
			ltime_end = ltime_end.plusMinutes(rs_end.getInt("time"));
			String time_start = ltime_start.toString();
			String time_end = ltime_end.toString();
			
			Date now = new Date();
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			df.setTimeZone(TimeZone.getTimeZone("Asia/Taipei"));
			String current_time = df.format(now);
			
			Seat av_seat = seat_getter.getSeats(car_name, date, _start, _end).availableSeats.get(0);
			
			//insert ticket
			PreparedStatement stmt_ticket = conn.prepareStatement("INSERT INTO `ticket`(`id`, `user_id`, `email`, `phone`, `ticket_time`, `car_date`, `car_name`, `begin`, `end`, `seat_row`, `seat_column`, `price`) VALUES "
					+ "(NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			stmt_ticket.setString(1, session.getAttribute("user_id").toString());
			stmt_ticket.setString(2, session.getAttribute("email").toString());
			stmt_ticket.setString(3, session.getAttribute("phone").toString());
			stmt_ticket.setString(4, current_time);
			stmt_ticket.setString(5, date);
			stmt_ticket.setString(6, car_name);
			stmt_ticket.setInt(7, _start);
			stmt_ticket.setInt(8, _end);
			stmt_ticket.setInt(9, av_seat.row);
			stmt_ticket.setInt(10, av_seat.column);
			stmt_ticket.setInt(11, price);
			
			stmt_ticket.executeUpdate();
			System.out.println(stmt_ticket);
			
			//insert log
			PreparedStatement stmt_log = conn.prepareStatement("INSERT INTO `log`(`id`, `time`, `type`, `content`) VALUES "
					+ "(NULL, ?, ?, ?)");
			stmt_log.setString(1, current_time);
			stmt_log.setString(2, "reservation");
			stmt_log.setString(3, session.getAttribute("user_id").toString()+"的訂票");
			
			stmt_log.executeUpdate();
			System.out.println(stmt_log);
			

			session.setAttribute("car_name", car_name);
			session.setAttribute("date", date);
			session.setAttribute("start", rs_start.getString("name"));
			session.setAttribute("end", rs_end.getString("name"));
			session.setAttribute("seat_row", av_seat.row);
			session.setAttribute("seat_column", av_seat.column);
			session.setAttribute("start_time", time_start);
			session.setAttribute("arrival_time", time_end);
			session.setAttribute("price", price);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return true;
	}

}
