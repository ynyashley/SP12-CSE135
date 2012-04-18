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