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

		<!-- carousel using hero -->
		<div id="myCarousel" class="carousel slide">
	      	<div class="carousel-inner">
	        	<div class="item active">
	        		<div class="hero-unit">
	        			<h2>Finding events should be fun, not frustrating.</h2>
	        			<!-- <p>EventDevil makes it easy to share and find events.</p> -->
	        			<p>Tired of missing out on events or combing through incomplete listservs or the Duke Events Calendar? We're here to help you find and share events.</p>
						<p><a class="btn btn-large btn-primary" href="about.jsp">Learn more</a></p>
	        		</div> <!-- /.hero-unit -->
	        	</div> <!-- /.item active-->
	        	<div class="item">
	        		<div class="hero-unit">
	        			<h2>Browsing is easy and intuitive.</h2>
	        			<p>Search for upcoming events by time range, filter events by organization name, or search for events by keyword.</p>
	        			<p><a href="events.jsp" class="btn btn-large btn-primary">Browse now</a></p>
	        		</div> <!-- /.hero-unit -->
	        	</div> <!-- /.item -->
	        	<div class="item">
	        		<div class="hero-unit">
	        			<h2>We place you at the center of the event.</h2>
	        			<!-- <p>Our success depends on our users submitting events. By submitting an event to our database, you have the chance to share it with many more people.</p> -->
	        			<p>You submit events that you think other people would be interested in, and you find and attend events that others share. Call it crowdsourcing, call it amazing.</p>
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

	<!-- scripts -->
	<script src="../js/checklen.js"></script>
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