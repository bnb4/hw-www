package ticket;

import com.google.gson.Gson;

public class GetCar {
	public static String getCar(String route, String start, String date, String destination) {
		
		int _route = route == null ? 0 : Integer.parseInt(route);
		int _start = start == null ? 0 : Integer.parseInt(start);
		date = date == null ? "" : date;
		int _destination = destination == null ? 0 : Integer.parseInt(destination);

		return new Gson().toJson(CarGetter.getInstance().getCar(_route, _start, date, _destination));
	}
}
