<%@page import="support.*, java.util.*"  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Specialization</title>
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
<% 
   Degree d = (Degree)session.getAttribute("degree");
   String loc = (String)d.getLocation();
   String uni = (String)d.getUniversity();
   String major = (String)d.getDiscipline();
   String title = (String)d.getTitle();
%>
Location of University <%=counter %>: <%=loc %> </br>
University <%=counter %>: <%=uni %> </br>
Major <%=counter %>: <%=major %> </br>
Title <%=counter %>: <%=title %>
<br>

<% 
String path = config.getServletContext().getRealPath("specializations.txt");
support s = new support();  
Vector specialization = s.getSpecializations(path); %>
<form method = get action ="verification.jsp">
<SELECT name ="specialization">
<%
for (int i = 0 ; i < specialization.size(); i++){
%>
<option value = "<%=specialization.get(i)%>"><%=specialization.get(i)%></option>
<%} 
%>
</SELECT>
<p>
<input type = "submit" name = "action" value = "Done" />
</form>
</body>
</html>