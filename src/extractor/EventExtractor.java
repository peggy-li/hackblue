package extractor;

import java.util.ArrayList;
import java.util.Date;
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
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.datastore.Query.SortDirection;

public class EventExtractor {

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
	public static List<Entity> retrieve(String sortKey, String sortDirection, int limit) {
		SortDirection dir = (sortDirection.equalsIgnoreCase("ascending"))? SortDirection.ASCENDING :SortDirection.DESCENDING;
		Query query = new Query("event").addSort(sortKey, dir);
		return retrieveHelper(query, limit);
	}
	
	public static List<Entity> filter(String property, String keyword, String sortDirection, int limit) {
		SortDirection dir = (sortDirection.equalsIgnoreCase("ascending"))? SortDirection.ASCENDING :SortDirection.DESCENDING;
		Filter filter = new FilterPredicate(property, FilterOperator.EQUAL, keyword);
		Query query = new Query("event").setFilter(filter).addSort("start_time", dir);
		return retrieveHelper(query, limit);
	}
	
	/**
	 * Returns the events falling within the number of upcoming weeks from current date.
	 * @param numWeeks
	 * @return
	 */
	public static List<Entity> findUpcoming(int numWeeks) {
		List<Entity> rawResult = retrieve("start_time", "ascending", 50);
		List<Entity> result = new ArrayList<Entity>();
		// filter results
		for (Entity event: rawResult){
			if (isInRange((String) event.getProperty("start_time"), numWeeks)){
			result.add(event);
			}
		}
		return result;
	}
	
	private static List<Entity> retrieveHelper(Query query, int limit) {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		List<Entity> events = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(limit));
		return events;	
	}
	
	/**
	 * returns true if a date falls within X weeks of current date
	 * @return
	 */
	private static boolean isInRange(String otherDate, int numWeeks) {
		DateTimeFormatter fmt = DateTimeFormat.forPattern("yyyy-MM-dd");
		DateTime dateTime1 = ISODateTimeFormat.dateTimeNoMillis().parseDateTime(otherDate);
		DateTime dateTime2 = new DateTime(new Date());
		dateTime2 = dateTime2.plusWeeks(numWeeks);
		long d1 = dateTime1.getMillis();
		long d2 = dateTime2.getMillis();
		return (d1 < d2);
	}
	
}
