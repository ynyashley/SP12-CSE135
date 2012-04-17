<%@page import="support.*, java.util.*" %>
<html>
<head>
<title>More Degrees</title>
</head>
<body>
Major: <%= request.getParameter("major") %>
<% String title = request.getParameter("title"); %>
Title: <%=title %>
</body>
</html>