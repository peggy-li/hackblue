<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<html>
<head>
  <title>Add Event</title>
</head>

<body>
<div>


  <div class="content">

<%
	String eventURL = request.getParameter("eventURL");
	out.println(eventURL);
%>

  </div>
</div>
</body>
</html>