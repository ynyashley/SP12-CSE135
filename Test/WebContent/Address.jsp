<%@page import="support.*, java.util.*"  %>
<html>
<head>
<title>Address</title>
</head>
<body>
<% String country = request.getParameter("country"); %>
Country of Residence: <%=country%>
</body>
</html>