<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.List, extractor.EventExtractor, com.google.appengine.api.datastore.*" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>EventDevil</title>

		<!-- styles -->
		<link href="../css/bootstrap.css" rel="stylesheet">
   	<link href="../css/main.css" rel="stylesheet">
		
		<style>

    	.container{
    		width: 80%;
    		margin-left: auto;
    		margin-right: auto;
    		position: relative;
    	}

    	/* CUSTOMIZE EACH EVENT OBJECT */

    	.event {
    		margin-top: 40px;
    	}

    	.event img {
    		width: 200px;
    		height: 200px;
    		text-align: left;
    	}

    	.event .name {
    		font-size: 200%;
    		margin-top: 10px;
    	}

    	.event .host {
    		font-size: 140%;
    		margin-bottom: 20px;
    	}

    	.event .date {
    		font-size: 160%;
    	}

    	.event .location {
    		font-size: 160%;
    	}

    	.event .left {
    		float: left;
    		width: 50%;
    		text-align: center;
    	}

    	.event .right{
    		float: right;
    		width: 50%
    	}

		</style>
	</head>

	<body>

		<!-- navbar -->
		<div class="navbar">
	  		<div class="navbar-inner">
	    		<ul class="nav">
	    			<li><a href="../index.html">Home</a></li>
	    			<li><a href="../about.html">About</a></li>
	    			<li class="dropdown">
	    				<!-- <a href="events.html" class="dropdown-toggle" data-toggle="dropdown">Browse Events</a> -->
	    				<a href="events.jsp" class="dropdown-toggle" data-toggle="dropdown">Browse events<b class="caret"></b></a>
	    				<ul class="dropdown-menu">
	    					<li><a href="events.jsp">Browse all events</a></li>
	    					<li><a href="#">Browse by date</a></li>
	    					<li><a href="#">Browse by organization</a></li>
	    				</ul> <!-- /.dropdown-menu -->
	    			</li> <!-- /.dropdown -->
	    			<li><a href="#addEventModal" data-toggle="modal">Add an event</a>
	    		</ul> <!-- /.nav --> 
				<!-- Search bar -->
		  		<form class="navbar-search pull-right">
		 			<input type="text" class="search-query" placeholder="Search events">
		  			<button type="submit" class="btn">Search</button>
				</form>
	  		</div> <!-- /.navbar-inner-->
		</div> <!-- /.navbar -->

		<div class="container">
		
<%		
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Query query = new Query("event").addSort("start_time", Query.SortDirection.DESCENDING);
			List<Entity> events = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(50));
			if (events.isEmpty()) {
				out.print("<p>No events found.</p>");
			}
			for (Entity event : events) {
%>
			<div class="event row-fluid">
				<div class="left">
					<img src=<%=event.getProperty("picture") %> class="img-polaroid">
				</div> <!-- /.left -->
				<div class="right">
					<p class="name"><a href=<%=event.getProperty("url") %>><%=event.getProperty("name") %></a></p>
					<p class="host"><%=event.getProperty("owner") %></p>
					<p class="date"><%=EventExtractor.formatDate((String) event.getProperty("start_time")) %>
<%
					if (!event.getProperty("end_time").equals(new String(""))) {
						out.print(" - " + EventExtractor.formatDate((String) event.getProperty("end_time")) + "</p>");
					}
					else {
						out.print("</p>");
					}
%>
					<p class="location"><%=event.getProperty("location") %></p>
				</div> <!-- /.right -->
			</div> <!-- /.event -->
<%
			}
%>
 		</div> <!-- /.container -->
 		
 		<!-- Modal for adding event -->
		<div id="addEventModal" class="modal hide fade" tabindex="-1" role="dialog">
			<form id="modal-form" method="post" action="../jsp/addEvent.jsp">
				<div class="modal-header">
   					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
   					<h3>Add Event</h3>
   				</div>
   				<div class="modal-body">
   					<input class="input-large" type="url" name="eventURL" placeholder="Event URL" required="required" />
            <p>Note: URL must be in the form http://www.facebook.com/events/123456789</p>
   				</div>
   				<div class="modal-footer">
   					<button class="btn" data-dismiss="modal">Cancel</button>
   					<input class="btn btn-primary" type="submit" value="Add Event"/>
   				</div>
   			</form>
   		</div> <!-- /.modal -->

		<script src="../js/jquery.js"></script>
    	<script src="../js/bootstrap.js"></script>
   	<script src="../js/holder.js"></script>
	</body>
</html>