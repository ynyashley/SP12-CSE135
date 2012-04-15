<%@page import="support.*, java.util.*" %>
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