package ticket;

import com.google.gson.Gson;

public class GetDestination {
	public static String getDestination(String route, String start) {
		
		route = route == null ? "" : route;
		start = start == null ? "" : start;

		return new Gson().toJson(DestinationGetter.getInstance().getDestination(route, start));
	}
}
