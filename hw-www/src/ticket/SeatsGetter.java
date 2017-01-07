package ticket;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import database.DatabaseHelper;

public class SeatsGetter {
	
	// Singleton
    private static SeatsGetter instance;
    public static SeatsGetter getInstance() {
		if(instance == null) { 
			instance = new SeatsGetter();
		}
		return instance;
	}
    
    
    // 傳入用參數
    String car_name;
    String date;
    int begin;
    int end;
    
    // SQL 撈到儲存用
    int rows;
    int columns;
    Map<Integer, List<Seat>> table;

    private SeatsGetter(){}
	
   	public ReturnData getSeats(String car_name, String date, int begin, int end) {
        this.car_name = car_name;
        this.date = date;
        this.begin = begin;
        this.end = end;
        table = new HashMap<>();
        
        return this.getSeatsDetails();
    }
    
    private ReturnData getSeatsDetails() {
    	
    	ReturnData _return = new ReturnData(this.car_name, this.date, this.begin, this.end);
    	
    	try {
	    	
	        Connection con = DatabaseHelper.getConnection();
	        
	        if (!this.isCarExists(con, _return)) return _return;
	        if (!this.getTicketSeats(con, _return)) return _return;
	        if (!this.getSeatsAvailable(_return)) return _return;
			//var_dump($return);
	        
    	} catch (SQLException e) {
    		e.printStackTrace();
    		_return.status = "資料庫連線失敗";
    	}
    	
        return _return;
    }
    
    private boolean isCarExists(Connection con, ReturnData _return) {

    	try {
	        PreparedStatement stmt = // 取得車子座位
	        		con.prepareStatement("SELECT rows, columns FROM timetable " +
	        				"INNER JOIN car ON timetable.plate = car.plate " +
	        				"INNER JOIN car_type ON car_type.id = car.car_type " +
	        				"WHERE car_name = ?");
	        stmt.setString(1, this.car_name);
	        ResultSet rs = stmt.executeQuery();
	            
	        if (!rs.next()) {
	        	_return.status = "找不到該車輛";
	        	return false;
	        }
	        
	        this.rows = rs.getInt("rows");
	        this.columns = rs.getInt("columns");
	
	        stmt.close();
	        return true;
    	} catch (Exception e) {
    		e.printStackTrace();
    		_return.status = "取得車輛位子數量失敗";
    		return false;
    	}
    }
    
    private boolean getTicketSeats(Connection con, ReturnData _return) {
        try {
	    	PreparedStatement stmt = con.prepareStatement("SELECT begin, end, seat_row, seat_column "
	    			+ "FROM ticket WHERE car_name = ? AND car_date = ?");
	    	stmt.setString(1, this.car_name);
	    	stmt.setString(2, this.date);

	    	ResultSet rs = stmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		int _begin = rs.getInt("begin"), _end = rs.getInt("end");
	    		int seat_row = rs.getInt("seat_row"), seat_column = rs.getInt("seat_column");
	    		
	    		for (int i = _begin; i < _end; i++) {
	                if (i < this.begin) continue;
	                if (i >= this.end) break;
	                
	                List<Seat> t = this.table.get(i);
	                if (t == null) t = new ArrayList<>();
	                
	                t.add(new Seat(seat_row, seat_column));
	                
	                this.table.put(i, t);
	            }
	    	}
	    	
	        stmt.close();
	        return true;
        } catch (Exception e) {
        	e.printStackTrace();
        	_return.status = "搜尋訂票資料表發生錯誤";
        	return false;
        }
    }
    
    private boolean getSeatsAvailable(ReturnData _return) {
        for (int i = 1; i <= this.rows; i++) {
            for (int j = 1; j <= this.columns; j++) {
                // 每個位子都找看看
                boolean isUsed = false;

                Search:
                for (int k = this.begin; k < this.end; k++) {
                	if (this.table.get(k) != null) {
	                    for(Seat each_seat : this.table.get(k)) {
	                        if (each_seat.row == i && each_seat.column == j) {
	                            isUsed = true;
	                            break Search;
	                        }   
	                    }
                    }
                }

                if (!isUsed) {
                    // 該位子可用
                    _return.addSeat(i, j);
                }
            }
        }

        _return.status = "success";
        return true;
    }
}
