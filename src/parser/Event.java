package parser;

public class Event {
	
	private String url = "";
	private String id = "";
	private Owner owner;
	private String name = "";
	private String description = "";
	private String start_time = "";
	private String end_time = "";
	private String location = "";
	private Venue venue;
	private String privacy = "";
	private Picture picture;
	
	public Event() {}

	public String getID() {
		return id;
	}

	public String getOwner() {
		return owner.name;
	}

	public String getName() {
		return name;
	}

	public String getDescription() {
		return description;
	}

	public String getStart_time() {
		return start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public String getLocation() {
		return location;
	}
	
	public String getVenue() {
		return venue.name;
	}
	
	public String getPrivacy() {
		return privacy;
	}
	
	public String getPicture() {
		return picture.data.url;
	}
	
	public String getURL() {
		return url;
	}
	
	public static class Owner {
		private String name = "";
		private String id = "";
		
		public Owner() {}
	}
	
	public static class Venue {
		private String name = "";
		
		public Venue() {}
	}
	
	public static class Picture {
		private Data data;
		
		public Picture() {}
	}
	
	public static class Data {
		private String url = "";
		private boolean is_silhouette = false;
		
		public Data() {}
	}
}
