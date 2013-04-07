<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>EventDevil - About</title>

		<!-- styles -->
		<link href="../css/bootstrap.css" rel="stylesheet">
   		<link href="../css/main.css" rel="stylesheet">

   		<style>

	    	/* CUSTOMIZE INFO SECTION AT TOP */
	    	.reason p {
	    		margin-bottom: 20px;
	    	}


   		</style>
	</head>

	<body>
	<!-- header -->
	<div class="row-fluid">
		<div class="span2 pagination-right">
			<img class="logo" src="../images/logo2.png" alt="">
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
	    							<li><a tabindex="-1" href="events.jsp?today=true">Today</a></li>
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


   		<div class="reason pagination-left"><h2>It's easy.</h2> <p>All you have to do is paste the URL of a public Facebook event. We'll handle the rest. No long or complicated forms!</p> <p>Our browsing is simple and intuitive, allowing you to search and filter by criteria that matter to you. </p> </div>

   		<div class="reason pagination-right"><h2>It's comprehensive.</h2> <p>The Duke Events Calendar, the largest aggregation of events at Duke, doesn't include many events organized by students or student organizations and includes many events that are generally not of great interest to students. Email listservs usually include only a small number of events specific to the group or have long blocks of text that most students don't want to read.</p> <p>At the same time, you might be inundated with event invitations on Facebook, some of which are to events you aren't really interested in, while missing out on events you aren't invited to or you don't see your friends RSVP to. It doesn't have to be that way. Why settle when you could have a large database of events for students, by students?</div>

   		<div class="reason pagination-left"><h2>It's social.</h2><p>Because each of the events shown links to a Facebook event, you can quickly see which of your friends are attending or invite your friends after you RSVP. </p></div>

   		<div class="reason pagination-right"><h2>It's by Duke students, for Duke students.</h2> <p>We know from experience that there's always a lot happening on campus and not enough time to do it all. That's why we want to help you find the events that matter the most to you and that most interest you, so you're making the most of your time (or finding more things to go to so you can procrastinate). </p><p>We also know that it's hard for organizations to advertise their events to a large number of students without "spamming" them on Facebook or by email, and we believe that our platform can help. </div>

   		<hr>


		<!-- FAQ -->
		<div class="faq">
			<h1>FAQ</h1>
				<p class="question"><strong>Q:</strong> What types of events can I submit?</p>
				<p class="answer"><strong>A:</strong> You can submit any public Facebook events that are open to the entire Duke community and that are of interest to Duke students. Events should not have passed and should take place on campus or in the Durham / Triangle area. Any events that are found to be irrelevant to Duke students or that are offensive or in violation of copyright laws will be removed. </p>
			
				<p class="question"><strong>Q:</strong> Who can submit an event? Do I have to be the host or attending an event to submit it?</p>
				<p class="answer"><strong>A:</strong> Nope! Anybody can submit an event as long as it meets the basic criteria described in above. You do not have to be a host or a member of the organization hosting the event, invited to, or planning to attend the event. </p>
			
				<p class="question"><strong>Q:</strong> What are featured events?</p>
				<p class="answer"><strong>A:</strong> The featured events displayed on the homepage are the three events with the most attendees on Facebook. We show them to help you find popular events. </p>
		
		</div> <!-- /.faq -->


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