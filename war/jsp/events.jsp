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

		</style>
	</head>

	<body>

    <!-- header -->
		<div class="row-fluid">
      <div class="span2 pagination-right">
        <img class="logo" src="../images/logo.png" alt="">
      </div>
      <div class="span10">
        <!-- navbar -->
        <div class="navbar">
          <div class="navbar-inner">
            <ul class="nav">
              <li><a href="home.jsp">Home</a></li>
              <li><a href="about.jsp">About</a></li>
              <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown">Browse events<b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="events.jsp">Browse all events</a></li>
                  <li class="dropdown-submenu">
                    <a tabindex="-1" href="#">Browse by date</a>
                    <ul class="dropdown-menu">
                      <li><a tabindex="-1" href="#">Today</a></li>
                     <li><a tabindex="-1" href="events.jsp?upcomingWeeks=1">Within 1 week</a></li>
		    		<li><a tabindex="-1" href="events.jsp?upcomingWeeks=2">Within 2 weeks</a></li>
		    		<li><a tabindex="-1" href="events.jsp?upcomingWeeks=5">Within 5 weeks</a></li>
                    </ul>
                  </li><!--/.dropdown-submenu for date -->
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
      </div> <!-- /.span10 -->
    </div> <!-- /.row-fluid -->

		<div class="container">
<%		
			List<Entity> events;
			// checking for timeframe
			String numWeeks = (request.getParameter("upcomingWeeks"));
			if (numWeeks == null){
				events = EventExtractor.retrieve();
			}
			else{
				int tempWeeks = Integer.parseInt(numWeeks);
				events = EventExtractor.findUpcoming(tempWeeks);
			}
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
					<p class="host">Created by: <%=event.getProperty("owner") %></p>
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
			<form id="modal-form" method="post" action="addEvent.jsp">
				<div class="modal-header">
   					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
   					<h3>Add Event</h3>
   				</div>
   				<div class="modal-body">
   					<input class="input-semi-large" type="url" name="eventURL" placeholder="Event URL" required="required" />
            <p>Note: URL must be in the form http://www.facebook.com/events/123456789</p>
   				</div>
   				<div class="modal-footer">
   					<button class="btn" data-dismiss="modal">Cancel</button>
   					<input class="btn btn-primary" type="submit" value="Add Event"/>
   				</div>
   			</form>
   		</div> <!-- /.modal -->

        <!-- Footer -->
        <div class="footer">
            <p class="pagination-centered">Note: this website is best viewed using Google Chrome.</p>
            <p class="muted pagination-centered">EventDevil &copy; 2013 Peggy Li, Eric Mercer, &amp; Michael Hsueh</p>
        </div><!-- /.footer -->

		<script src="../js/jquery.js"></script>
    	<script src="../js/bootstrap.js"></script>
   	    <script src="../js/holder.js"></script>
	</body>
</html>