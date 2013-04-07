package parser;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Scanner;


public class EventParser {
	
	private static final String BASE_URL = "https://graph.facebook.com/";
	private static final String ACCESS_TOKEN = "356870157756071%7CZKRXp2JMaj8T6jg1nGTvRiDa1Xs";
	private static final String FIELDS = "id,owner,name,description,start_time,end_time,location,venue,privacy,picture";

	public static void parse(String eventURL) throws MalformedURLException, IOException {
		// parse event ID
		String eventID = parseEventID(eventURL);
		if (eventID == null) {
			return;
		}
		
		// make Facebook Graph API call
		String url = buildURL(eventID);
		InputStream response = new URL(url).openStream();
		
		// get response
		Scanner in = new Scanner(response);
		StringBuilder json = new StringBuilder();
		while (in.hasNext()) {
			json.append(in.next());
		}
		in.close();
		response.close();
		
		// parse JSON object using GSON into separate fields
		// store event + fields in datastore object
	}
	
	private static String parseEventID(String eventURL) {
		String[] parts = eventURL.split("/");
		for (int i = 0; i < parts.length; i++) {
			if (parts[i].equalsIgnoreCase("events")) {
				return parts[i+1];
			}
		}
		return null;
	}
	
	private static String buildURL(String eventID) {
		StringBuilder url = new StringBuilder(BASE_URL);
		url.append(eventID);
		url.append("?access_token=");
		url.append(ACCESS_TOKEN);
		url.append("&fields=");
		url.append(FIELDS);
		return url.toString();
	}
}
