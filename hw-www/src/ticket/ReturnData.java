package ticket;

import java.util.ArrayList;
import java.util.List;

public class ReturnData {
	public String status;
	public String car_name;
	public String date;
	public String begin;
	public String end;
    public List<Seat> availableSeats;
    
    public ReturnData(String car_name, String date, int begin, int end) {
        this.car_name = car_name;
        this.date = date;
        this.begin = String.valueOf(begin);
        this.end = String.valueOf(end);
        this.availableSeats = new ArrayList<>();
    }
    
    public void addSeat(int row, int column) {
        this.availableSeats.add(new Seat(row, column));
    }
}
