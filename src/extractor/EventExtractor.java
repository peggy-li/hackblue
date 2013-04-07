package extractor;

import java.util.List;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.SortDirection;

public class EventExtractor {
	
	public static List<Entity> retrieve() {
		Query query = new Query("event").addSort("start_time", SortDirection.ASCENDING);
		return retrieveHelper(query);
	}
	
	public static String formatDate(String timestring) {
		if (timestring.equals("")) {
			return timestring;
		}
		DateTime datetime = ISODateTimeFormat.dateTimeNoMillis().parseDateTime(timestring);
		DateTimeFormatter fmt = DateTimeFormat.forPattern("EEEE, MMMM d, YYYY h:mm a");
		return fmt.print(datetime);
	}
	
	/**
	 * 
	 * @param sortKey the key to sort entities by
	 * @param sortDirection ordering of results
	 * @return
	 */
	public static List<Entity> retrieve(String sortKey, String sortDirection){
		SortDirection dir = (sortDirection.equalsIgnoreCase("ascending"))? SortDirection.ASCENDING :SortDirection.DESCENDING;
		Query query = new Query("event").addSort("start_time", dir);
		return retrieveHelper(query);
	}
	
	public static List<Entity> retrieveHelper(Query query){
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		List<Entity> events = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(50));
		return events;	
	}
	
}
