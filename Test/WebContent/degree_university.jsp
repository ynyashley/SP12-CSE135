<%@page import="support.*, java.util.*"  %>
<html>
<head>
<title>Provide Degrees -- Choose University</title>
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
<% String location = request.getParameter("location"); 
%>
<%
Degree d = new Degree();
d.setLocation(location);
session.setAttribute("degree", d);
Degree d1 = (Degree)session.getAttribute("degree");
String loc = (String)d1.getLocation();
%>
<br> 
University in <%=loc %>:
<p>
<% 
   	support s = new support();
   	String path2 = config.getServletContext().getRealPath("universities.txt");
   	Vector universities = s.getUniversities(path2);
%>
   	<table border="1">
<%
   	for(int i = 0; i < universities.size(); i++)
   	{
    	Vector universitiesList = (Vector)universities.get(i);
    	String country = (String)universitiesList.get(0);
    	if(country.equals(location))
    	{
    		Vector u = (Vector)universitiesList.get(1);
    		for(int j = 0; j < u.size(); j++)
    		{ %>
    			<td><a href="degree_major.jsp?university=<%=u.get(j)%>"><%=u.get(j)%></a></td>
    			<% if( (j+1)%3 == 0) { %>
				<tr>
	    		<%} %>
    	<% } %>
   	     
   	 <% } %>
  <% } %>

</table>
If your university is not listed above, please enter it in the text box below:
<form action="degree_major.jsp" method="POST">
<input type="text" name="university" />
<input type = "submit" name = "action" value = "submit" />
</form>


</body>
</html>