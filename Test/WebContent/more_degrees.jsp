<%@page import="support.*, java.util.*" %>
<html>
<head>
<title>More Degrees</title>
</head>
<body>
First Name: <%=session.getAttribute("first") %> </br >
Middle Initial: <%=session.getAttribute("middle") %> </br>
Last Name: <%=session.getAttribute("last") %> </br>
Citizenship: <%=session.getAttribute("citizenship") %> </br>
Country of Residence: <%=session.getAttribute("residence")%> </br>
Address: <%=session.getAttribute("address") %></br>
City: <%=session.getAttribute("city") %></br>
Zip: <%=session.getAttribute("zip") %> </br>
Area Code: <%=session.getAttribute("areaCode") %> </br>
<% if(session.getAttribute("state") == null) { %>
	Country Telephone Code: <%=session.getAttribute("countryTelCode")%> </br>
<%} 
else{ %>
	State: <%=session.getAttribute("state") %>
<%} %>
<% 
   Degree d = (Degree)session.getAttribute("degree");
   String loc = (String)d.getLocation();
   String uni = (String)d.getUniversity();
%>
<% String major = request.getParameter("major");
   String title = request.getParameter("title");
%>
Location of University: <%=loc %> </br>
University: <%=uni %> </br>
Major: <%=major %> </br>
Title: <%=title %>
<% 
d.setDiscipline(major);
d.setTitle(title);
%>

<form action="degree_location.jsp" method="POST">
Do you wish to add more degrees? </br>
<input type = "submit" name = "action" value = "Add more degrees"/>
</form>
<form action="specialization.jsp" method="POST">
<input type = "submit" name = "action" value = "Done" />
</form>

</body>
</html>