package parser;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;
import java.util.Scanner;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

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
		
		// parse JSON object using GSON into separate fields
		Gson gson = new Gson();
	    BufferedReader br = new BufferedReader(new InputStreamReader(response, "UTF-8"));
	    HackBlueEvent tempEvent = gson.fromJson(br, HackBlueEvent.class);
	    br.close();
	    String key = "event";
        Key eventKey = KeyFactory.createKey("Event", key);
        Date date = new Date();
        //String name = "A";
        
        Entity event = new Entity(name, guestbookKey);
        event.setProperty("dateAdded",);
        event.setProperty("id", tempEvent.getId());
        event.setProperty("owner",  tempEvent.getOwner());
        event.setProperty("name",  tempEvent.getName());
        event.setProperty("description",  tempEvent.getDescription());
        event.setProperty("start_time",  tempEvent.getStart_time());
        event.setProperty("end_time",  tempEvent.getEnd_time());
        event.setProperty("location",  tempEvent.getLocation());
       // event.setProperty("venue",  tempEvent.getVenue());
        event.setProperty("privacy",  tempEvent.getPrivacy());
        event.setProperty("picture",  tempEvent.getPicture());
        
		// store event + fields in datastore object
        DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
        datastore.put(event);
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
