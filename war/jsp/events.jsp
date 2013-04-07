<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.Date, org.joda.time.format.ISODateTimeFormat, org.joda.time.DateTime, java.util.List, java.util.ArrayList, extractor.EventExtractor, com.google.appengine.api.datastore.*" %>
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
	    					<!-- tags dropdown submenu -->
	    					<li class="dropdown-submenu">
	    						<a tabindex="-1" href="#">Browse by tag</a>
	    						<ul class="dropdown-menu">
	    							<li><a tabindex="-1" href="events.jsp?tag=academic">academic</a></li>
	    							<li><a tabindex="-1" href="events.jsp?tag=arts">arts</a></li>
	    							<li><a tabindex="-1" href="events.jsp?tag=career">career</a></li>
	    							<li><a tabindex="-1" href="events.jsp?tag=compsci">compsci</a></li>
	    							<li><a tabindex="-1" href="events.jsp?tag=fundraiser">fundraiser</a></li>
	    							<li><a tabindex="-1" href="events.jsp?tag=sports">sports</a></li>
	    							<li><a tabindex="-1" href="events.jsp?tag=social">social</a></li>
	    							<li><a tabindex="-1" href="events.jsp?tag=dsg">dsg</a></li>
	    							<li><a tabindex="-1" href="events.jsp?tag=freshmen">freshmen</a></li>
	    							<li><a tabindex="-1" href="events.jsp?tag=sophomores">sophomores</a></li>
	    							<li><a tabindex="-1" href="events.jsp?tag=juniors">juniors</a></li>
	    							<li><a tabindex="-1" href="events.jsp?tag=seniors">seniors</a></li>
	    						</ul>
	    					</li><!--/.dropdown-submenu for tags -->
	    				</ul> <!-- /.dropdown-menu -->
	    			</li> <!-- /.dropdown -->
	    			<li><a href="#addEventModal" data-toggle="modal">Add an event</a>
	    		</ul> <!-- /.nav --> 
				<!-- Search bar -->
		  		<form class="navbar-search pull-right" method="post" action="events.jsp">			  		
		 			<input type="text" name="tag" class="search-query" autocomplete="off" data-provide="typeahead" placeholder="Search tags"
		 				data-source='["academic", "arts", "career", "compsci", "fundraiser", "sports", "social", "dsg", "freshmen", "sophomores", "juniors", "seniors"]'>
		  			<button type="submit" class="btn">Search</button>
				</form>
	  		</div> <!-- /.navbar-inner-->
			</div> <!-- /.navbar --> 
		</div> <!-- /.span10 -->
	</div> <!-- /.row-fluid -->

		<div class="container">
<%		
			List<Entity> events;
			
           	// checking for parameters
			String numWeeks = request.getParameter("upcomingWeeks");
           	String tag = request.getParameter("tag");
			if (numWeeks != null){
				int tempWeeks = Integer.parseInt(numWeeks);
				events = EventExtractor.findUpcoming(tempWeeks);
			}
			else if (tag != null) {
				events = EventExtractor.filter("tags", tag, "ascending", 50);
			}
			else {
				events = EventExtractor.retrieve("start_time", "ascending", 50);
			}
			if (events.isEmpty()) {
				out.print("<p>No events found.</p>");
			}
			for (Entity event : events) {
				// don't display old events
				if (!((String) event.getProperty("end_time")).equals("")){
				DateTime d2 = ISODateTimeFormat.dateTimeNoMillis().parseDateTime((String) event.getProperty("end_time"));
				DateTime d1 = new DateTime(new Date());
				if (d1.getMillis() > d2.getMillis()){
				continue;
				}
				}
%>
			<div class="event row-fluid">
				<div class="left">
					<img src=<%=event.getProperty("picture") %> class="img-polaroid">
				</div> <!-- /.left -->
				<div class="right">
					<p class="name"><a href=<%=event.getProperty("url") %> target="_blank"><%=event.getProperty("name") %></a></p>
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
					<p>
<%
					Object obj = event.getProperty("tags");
					if (obj != null) {
						ArrayList<String> allTags = (ArrayList<String>) obj;
						out.print("Tags: ");
						for (String t : allTags) {
							out.print("<a href='#'>#" + t + "</a> ");
						}
					}
%>
					</p>
				</div> <!-- /.right -->
			</div> <!-- /.event -->
<%
			}
%>
 		</div> <!-- /.container -->

 		<!-- Modal for adding event -->
		<div id="addEventModal" class="modal hide fade" tabindex="-1" role="dialog">
			<form id="modal-form" name="modal-form" method="post" action="addEvent.jsp">
				<div class="modal-header">
   					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
   					<h3>Add Event</h3>
   				</div>
   				<div class="modal-body">
   					<input class="input-semi-large" type="url" name="eventURL" placeholder="Event URL" required="required" />
   					<p>Note: URL must be in the form http://www.facebook.com/events/123456789</p>
   					<div class="control-group">
    					<p class="pull-left">Add tags (choose up to 3): </p>
    					<div class="controls span2">
        					<label class="checkbox">
            					<input type="checkbox" name="tags[]" value="academic" onchange='checkLen(this);'> Academic
        					</label>
       						<label class="checkbox">
            					<input type="checkbox" name="tags[]" value="arts" onchange='checkLen(this);'> Arts
        					</label>
        					<label class="checkbox">
            					<input type="checkbox" name="tags[]" value="career" onchange='checkLen(this);'> Career
        					</label>
        					<label class="checkbox">
            					<input type="checkbox" name="tags[]" value="compsci" onchange='checkLen(this);'> Compsci
        					</label>
        					<label class="checkbox">
            					<input type="checkbox" name="tags[]" value="fundraiser" onchange='checkLen(this);'> Fundraiser
        					</label>
        					<label class="checkbox">
            					<input type="checkbox" name="tags[]" value="sports" onchange='checkLen(this);'> Sports
        					</label>
    					</div> <!-- /.controls -->
    					<div class="controls span2">
    					    <label class="checkbox">
            					<input type="checkbox" name="tags[]" value="social" onchange='checkLen(this);'> Social
        					</label>
        					<label class="checkbox">
            					<input type="checkbox" name="tags[]" value="dsg" onchange='checkLen(this);'> DSG
        					</label>
       						<label class="checkbox">
            					<input type="checkbox" name="tags[]" value="freshmen" onchange='checkLen(this);'> Freshmen
        					</label>
        					<label class="checkbox">
            					<input type="checkbox" name="tags[]" value="sophomores" onchange='checkLen(this);'> Sophomores
        					</label>
        					<label class="checkbox">
            					<input type="checkbox" name="tags[]" value="juniors" onchange='checkLen(this);'> Juniors
        					</label>
        					<label class="checkbox">
            					<input type="checkbox" name="tags[]" value="seniors" onchange='checkLen(this);'> Seniors
        					</label>
    					</div> <!-- /.controls -->
    				</div> <!--  /.control-group -->
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