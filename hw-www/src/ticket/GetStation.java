package ticket;

import com.google.gson.Gson;


public class GetStation {
	public static String getStation(String route) {
		
		route = route == null ? "" : route;
		
		return new Gson().toJson(StationGetter.getInstance().getStation(route));

	}
}
