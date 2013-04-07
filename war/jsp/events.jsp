<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.List, java.util.ArrayList, extractor.EventExtractor, com.google.appengine.api.datastore.*" %>
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
                      <li><a tabindex="-1" href="#">Within 1 week</a></li>
                      <li><a tabindex="-1" href="#">Within 2 weeks</a></li>
                      <li><a tabindex="-1" href="#">After 2 weeks</a></li>
                    </ul>
                  </li><!--/.dropdown-submenu for date -->
                  <li><a href="#">Browse by organization</a></li>
                  <!-- tags dropdown submenu -->
                  <li class="dropdown-submenu">
                    <a tabindex="-1" href="#">Browse by tag</a>
                    <ul class="dropdown-menu">
                      <li><a tabindex="-1" href="#">academics</a></li>
                      <li><a tabindex="-1" href="#">arts</a></li>
                      <li><a tabindex="-1" href="#">career</a></li>
                      <li><a tabindex="-1" href="#">compsci</a></li>
                      <li><a tabindex="-1" href="#">fundraiser</a></li>
                      <li><a tabindex="-1" href="#">sports</a></li>
                      <li><a tabindex="-1" href="#">social</a></li>
                      <li><a tabindex="-1" href="#">dsg</a></li>
                      <li><a tabindex="-1" href="#">freshmen</a></li>
                      <li><a tabindex="-1" href="#">sophomores</a></li>
                      <li><a tabindex="-1" href="#">juniors</a></li>
                      <li><a tabindex="-1" href="#">seniors</a></li>
                    </ul>
                  </li><!--/.dropdown-submenu for tags -->
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
			List<Entity> events = EventExtractor.retrieve();
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
						for (String tag : allTags) {
							out.print("<a href='#'>#" + tag + "</a> ");
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