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

    	/* CUSTOMIZE THE CAROUSEL */

    	.carousel-control {
	      margin: 0px;
	      font-size: 120px;
	      color: black;
	      background-color: transparent;
	      border: 0;
	      z-index: 10;
    	}

    	.carousel-control:hover,
		.carousel-control:focus {
			color: gray;
  			text-decoration: none;
  			opacity: 1.0;
		}

		/* Customize hero unit */

		.hero-unit h2 {
			margin-bottom: 20px;
			color: #0F4DA8;
			font-size: 48px;
			line-height: 1;
  			letter-spacing: -2px;
		}

    	/* CUSTOMIZE FEATURED EVENTS PANEL */

    	.featured {
    		margin: 0;
    		text-align: center;
    	}

    	.featured img {
    		width: 200px;
    		height: 200px;
    	}

    	.featured .span3 {
    		position: block;
    	}

    	.featured .caption {
    		margin: 20px;
    	}

		</style>

	</head>

	<body>
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
		    				<a href="events.jsp" class="dropdown-toggle" data-toggle="dropdown">Browse events<b class="caret"></b></a>
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

		<!-- carousel using hero -->
		<div id="myCarousel" class="carousel slide">
	      	<div class="carousel-inner">
	        	<div class="item active">
	        		<div class="hero-unit">
	        			<h2>Finding events should be fun, not frustrating.</h2>
	        			<p>EventDevil makes it easy to find events on Facebook.</p>
						<p><a class="btn btn-large btn-primary" href="about.jsp">Learn more</a></p>
	        		</div> <!-- /.hero-unit -->
	        	</div> <!-- /.item active-->
	        	<div class="item">
	        		<div class="hero-unit">
	        			<h2>Browsing is fun and easy!</h2>
	        			<p>Search for upcoming events or filter events by organization name.</p>
	        			<p><a href="events.jsp" class="btn btn-large btn-primary">Browse now</a></p>
	        		</div> <!-- /.hero-unit -->
	        	</div> <!-- /.item -->
	        	<div class="item">
	        		<div class="hero-unit">
	        			<h2>Your contributions matter.</h2>
	        			<p>Our success depends on our users submitting events. By submitting an event to our database, you have the chance to share it with many more people.</p>
	        			<p><a href="#addEventModal" class="btn btn-large btn-primary" data-toggle="modal">Add an event now</a></p>
	        		</div>
	        	</div>
	      	</div> <!-- carousel-inner -->
	      	<a class="left carousel-control" href="#myCarousel" data-slide="prev">&lsaquo;</a>
	      	<a class="right carousel-control" href="#myCarousel" data-slide="next">&rsaquo;</a>
    	</div> <!-- carousel -->


		<!-- featured events -->
		<div class="featured">
			<h1 class="text-left">Featured events</h1><hr>
			<div class="row-fluid">
<%
				List<Entity> events = EventExtractor.retrieve("attending_count", "descending", 4);
				if (events == null || events.size() == 0) {
%>
					<p>There are currently no events. Why don't you add one now?</p>
<%				}

				else {
					for (Entity event: events){
%>
		 		 	<div class="span3">
		 		 		<img src=<%=event.getProperty("picture") %> class="img-polaroid">
		 		 		<p><a href=<%=event.getProperty("url") %>><%=event.getProperty("name") %></a></p>
		 		 	</div> <!-- event -->

<%
				  	}
				}

%>	
			</div> <!-- /.row -->
		</div> <!-- /.featured -->



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

	<!-- scripts -->
	<script src="../js/jquery.js"></script>
	<script src="../js/bootstrap.js"></script>
   	<script src="../js/holder.js"></script>
   	<script>
      	!function ($) {
        $(function(){
          	// carousel demo
          	$('#myCarousel').carousel()
        })
     	}(window.jQuery);
    </script>
	</body>
</html>