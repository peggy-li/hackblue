<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="parser.EventParser" %>
<%@ page session="false" %>

<html>
<head>
  <title>Add Event</title>
</head>

<body>
<div>


  <div class="content">

<%
	String eventURL = request.getParameter("eventURL");
	String[] tags = request.getParameterValues("tags[]");
	EventParser.parse(eventURL, tags);
	response.sendRedirect("events.jsp");
%>

  </div>
</div>
</body>
</html>