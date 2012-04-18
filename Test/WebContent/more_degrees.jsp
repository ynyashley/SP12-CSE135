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
<% String counter = (String)session.getAttribute("counter"); %>
<% 
Address a = (Address)session.getAttribute("address");
String add = (String)a.getAddress();
String city = (String)a.getCity();
String zip = (String)a.getZip();
String area = (String)a.getAreaCode();
String state = (String)a.getState();
String ctc = (String)a.getTel();
%>
Address: <%=add %></br>
City: <%=city %></br>
Zip: <%=zip %> </br>
Area Code: <%=area %> </br>
<% if(session.getAttribute("state") == null) { %>
	Country Telephone Code: <%=ctc%> </br>
<%} 
else{ %>
	State: <%=state%>
<%} %>
<br>
<% 
   Degree d = (Degree)session.getAttribute("degree");
   String loc = (String)d.getLocation();
   String uni = (String)d.getUniversity();
%>
<% String major = request.getParameter("major");
   String title = request.getParameter("title");
%>
Location of University <%=counter %>: <%=loc %> </br>
University <%=counter %>: <%=uni %> </br>
Major <%=counter %>: <%=major %> </br>
Title <%=counter %>: <%=title %>
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