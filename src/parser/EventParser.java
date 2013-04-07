package parser;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Text;
import com.google.gson.Gson;

public class EventParser {
	
	private static final String BASE_URL = "https://graph.facebook.com/";
	private static final String ACCESS_TOKEN = "356870157756071%7CZKRXp2JMaj8T6jg1nGTvRiDa1Xs";
	private static final String FIELDS = "id,owner,name,description,start_time,end_time,location,venue,privacy,picture.type(large)";

	public static void parse(String eventURL) throws MalformedURLException, IOException {
		// parse event ID
		String eventID = parseEventID(eventURL);
		if (eventID == null) {
			return;
		}
		
		// make Facebook Graph API call
		String url = buildURL(eventID);
		InputStream response = new URL(url).openStream();
		
	    // parse JSON response into event entity using GSON
	    BufferedReader br = new BufferedReader(new InputStreamReader(response, "UTF-8"));
	    Gson gson = new Gson();
	    HackBlueEvent tempEvent = gson.fromJson(br, HackBlueEvent.class);
	    br.close();
	    System.out.println(tempEvent.getPrivacy());
	    if (!tempEvent.getPrivacy().equalsIgnoreCase("OPEN")) {
	    	return;
	    }
	    Entity event = createEntity(tempEvent, eventURL);
        
		// store event entity in datastore
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
	
	private static Entity createEntity(HackBlueEvent tempEvent, String eventURL) {
        Entity event = new Entity("event", tempEvent.getID());
        event.setProperty("url", eventURL);
        event.setProperty("dateAdded", new Date().toString());
        event.setProperty("id", tempEvent.getID());
        event.setProperty("owner",  tempEvent.getOwner());
        event.setProperty("name",  tempEvent.getName());
        event.setProperty("description",  new Text(tempEvent.getDescription()));
        event.setProperty("start_time",  tempEvent.getStart_time());
        event.setProperty("end_time",  tempEvent.getEnd_time());
        event.setProperty("location",  tempEvent.getLocation());
        event.setProperty("venue",  tempEvent.getVenue());
        event.setProperty("privacy",  tempEvent.getPrivacy());
        event.setProperty("picture",  tempEvent.getPicture());
        return event;
	}
}
