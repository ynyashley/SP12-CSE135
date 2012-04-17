<%@page import="support.*, java.util.*"  %>
<html>
<head>
<title>Provide Degree -- Choose Discipline</title>
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
	State: <%= session.getAttribute("location")%>
<%} %>
<br>

<% 
String path3 = config.getServletContext().getRealPath("majors.txt");
support s = new support();  
Vector majors = s.getMajors(path3); %>
<form action="more_degrees.jsp" method="POST">

<% for(int i=0; i< majors.size(); i++)
{ %>
	<INPUT TYPE="RADIO" NAME="major" value="<%=majors.get(i)%>">
	<%=majors.get(i)%><br>
<%} %>
Discipline not on the list:
<input type="text" name="major"/>

Month and year degree was awarded/expected to be awarded: <input type="text" name="month" size="6"/>
/ <input type="text" name="year" size= "6" /><br />
Title of Degree:
<select name="title">
  <option value="BS">BS</option>
  <option value="MS">MS</option>
  <option value="PhD">PhD</option>
</select>
</br>
	
<input type = "submit" name = "action" value = "submit" />
</form>
</body>
</html>