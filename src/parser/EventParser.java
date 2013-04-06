package parser;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Scanner;


public class EventParser {
	
	private static final String TOKEN_URL = "https://graph.facebook.com/dialog/oauth?client_id=";
	private static final String ACCESS_TOKEN = "AAACEdEose0cBAHUO3ZALIGndZBPhOPr4e4LzqjUSFJLUW0RV8hXo5kakjsUUmiZCKNy5ZCbmeiXB0lHGfCFD1iFQZAJjf81CUyj33RyX2JQZDZD";
	private static final String FIELDS = "?id,owner,name,description,start_time,end_time,location,venue,privacy,picture";
	
	public static String parse(String eventURL) throws MalformedURLException, IOException {
		// get eventID
		String[] parts = eventURL.split("/");
		String eventID = "0";
		for (int i = 0; i < parts.length; i++) {
			if (parts[i].equalsIgnoreCase("events")) {
				eventID = parts[i+1];
				break;
			}
		}
		
		// make Facebook Graph API call
		StringBuilder url = new StringBuilder(TOKEN_URL);
		url.append(ACCESS_TOKEN);
		url.append("/" + eventID);
		url.append(FIELDS);
		InputStream response = new URL(url.toString()).openStream();
		
		Scanner in = new Scanner(response);
		StringBuilder json = new StringBuilder();
		while (in.hasNext()) {
			json.append(in.next());
		}
		in.close();
		response.close();
		
		return json.toString();
		
		
		// parse JSON object using GSON into separate fields
		// store event + fields in datastore object
	}
}
