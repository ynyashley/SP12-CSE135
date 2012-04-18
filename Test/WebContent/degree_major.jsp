<!-- TODO: Save all information to Degree object -->

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
String university = request.getParameter("university");
Degree d = (Degree)session.getAttribute("degree");
d.setUniversity(university);
String loc = (String)d.getLocation();
String uni = (String)d.getUniversity();
%>
Location of University <%=counter %>: <%=loc %> </br>
University <%=counter %>: <%=uni%> 
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
</br>
Month and year degree was awarded/expected to be awarded: <input type="text" name="month" size="6"/>
/ <input type="text" name="year" size= "6" /><br />
Title of Degree:
<select name="title">
  <option value="BS">BS</option>
  <option value="MS">MS</option>
  <option value="PhD">PhD</option>
</select>
</br>
GPA/Expected GPA: <input type="text" name="GPA" size= "3" /><br />
</br>
	
<input type = "submit" name = "action" value = "submit" />
</form>
</body>
</html>