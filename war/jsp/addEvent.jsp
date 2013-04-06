<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="parser.EventParser" %>

<html>
<head>
  <title>Add Event</title>
</head>

<body>
<div>


  <div class="content">

<%
	String eventURL = request.getParameter("eventURL");
	out.println(EventParser.parse(eventURL));
	//response.sendRedirect("../index.html");
%>

  </div>
</div>
</body>
</html>