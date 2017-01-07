package ticket;

import com.google.gson.Gson;

public class GetAvailableSeats {
	public static String getSeats(String car_name, String date, String begin, String end) {

		// 車次
		car_name = car_name == null ? "" : car_name;
		
		// 日期 yyyy-mm-dd
		date = date == null ? "" : date;
		
		// 起終站
		int _begin = Integer.parseInt(begin == null ? "0" : begin);
		int _end = Integer.parseInt(end == null ? "0" : end);

		return new Gson().toJson(SeatsGetter.getInstance().getSeats(car_name, date, _begin, _end));
	}
}
