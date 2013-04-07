package extractor;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.joda.time.DateTime;
import org.joda.time.LocalDate;
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
		return retrieveHelper(query, 50);
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
	public static List<Entity> retrieve(String sortKey, String sortDirection, int limit){
		SortDirection dir = (sortDirection.equalsIgnoreCase("ascending"))? SortDirection.ASCENDING :SortDirection.DESCENDING;
		Query query = new Query("event").addSort(sortKey, dir);
		return retrieveHelper(query, limit);
	}
	
	public static List<Entity> retrieveHelper(Query query, int limit){
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		List<Entity> events = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(limit));
		return events;	
	}
	
	/**
	 * Returns the events falling within the number of upcoming weeks from current date.
	 * @param numWeeks
	 * @return
	 */
	public static List<Entity> findUpcoming(int numWeeks){
		List<Entity> rawResult = retrieve();
		List<Entity> result = new ArrayList<Entity>();
		// filter results
		for (Entity event: rawResult){
			if (isInRange((String) event.getProperty("start_time"), numWeeks)){
			result.add(event);
			}
		}
		return result;
	}
	
	/**
	 * Returns events starting today, or currently running today.
	 * @return
	 */
	public static List<Entity> findEventsToday(){
		List<Entity> allEvents = retrieve();
		List<Entity> result = new ArrayList<Entity>();
		for(Entity e: allEvents){
			if (spansToday((String) e.getProperty("start_time"), (String) e.getProperty("end_time"))){
				result.add(e);
			}
		}
		return result;
	}
	
	/**
	 * returns true if a date falls within X weeks of current date
	 * @return
	 */
	private static boolean isInRange(String otherDate, int numWeeks){
		DateTimeFormatter fmt = DateTimeFormat.forPattern("yyyy-MM-dd");
		DateTime dateTime1 = ISODateTimeFormat.dateTimeNoMillis().parseDateTime(otherDate);
		DateTime dateTime2 = new DateTime(new Date());
		dateTime2 = dateTime2.plusWeeks(numWeeks);
		long d1 = dateTime1.getMillis();
		long d2 = dateTime2.getMillis();
		return (d1 < d2);
	}
	
	private static boolean isToday(String otherDate){
		DateTime d1 = ISODateTimeFormat.dateTimeNoMillis().parseDateTime(otherDate);
		DateTime d2 = new DateTime(new Date());
		return (d1.getDayOfYear() == d2.getDayOfYear() && d1.getYear()==d2.getYear());
	}
	
	/**
	 * returns true if an event spans through today
	 * @param otherDate
	 * @return
	 */
	private static boolean spansToday(String iStart, String iEnd){
		DateTime start = ISODateTimeFormat.dateTimeNoMillis().parseDateTime(iStart);
		DateTime d2 = new DateTime(new Date());
		DateTime end = ISODateTimeFormat.dateTimeNoMillis().parseDateTime(iEnd);
		return (start.getDayOfYear() == d2.getDayOfYear() && start.getYear()==d2.getYear() ||
				(start.getDayOfYear() <= d2.getDayOfYear() && start.getYear()<=d2.getYear() &&
				 end.getDayOfYear() >= d2.getDayOfYear() && end.getYear() >= d2.getYear()));
	}
	
}
