<%@page import="support.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title> Citizenship </title>
</head>
<body>
	<form action="Name.jsp" method="GET">
	<%
       String first = request.getParameter("first");
	   String middle = request.getParameter("middle");
	   String last = request.getParameter("last");
    %>
	<%= "First Name: " +  first %> </br> 
	<%= "Middle Initial: " +  middle %> </br> 
	<%= "Last Name: " +  last %>
	</form>
</body>
</html>