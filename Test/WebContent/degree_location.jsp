<%@page import="support.*, java.util.*"  %>
<html>
<head>
<title>Provide Degrees -- Choose Location</title>
</head>
First Name: <%=session.getAttribute("first") %> </br >
Middle Initial: <%=session.getAttribute("middle") %> </br>
Last Name: <%=session.getAttribute("last") %> </br>
Citizenship: <%=session.getAttribute("citizenship") %> </br>
Country of Residence: <%=session.getAttribute("residence")%> </br>
<% 
	String address = request.getParameter("address");
	session.setAttribute("address", address);
	
	String city = request.getParameter("city");
	session.setAttribute("city", city);
	
	String zip = request.getParameter("zip");
	session.setAttribute("zip", zip);
	
	String areaCode = request.getParameter("areaCode");
	session.setAttribute("areaCode", areaCode);
	
	String ctc = null;
	String state1 = null;
	if(request.getParameter("state") == null)
	{
		ctc = request.getParameter("countryTelCode");
		session.setAttribute("countryTelCode", ctc);
	}
	else
	{
		state1 = request.getParameter("state");
		session.setAttribute("state", state1);
	}
%>
Address: <%=address %> <br>
City: <%=city %> <br>
Zip: <%=zip %> <br>
Area code: <%=areaCode %> <br>
<% if(ctc != null){ %>
Country Tel Code: <%=ctc %>
<%} 
else{ %>
State: <%=state1 %>
<%} %>

<body>
<p>
Please choose your school location.
<p>
States in United States :
<p>
<% 
   	support s = new support();   	
   	String path2 = config.getServletContext().getRealPath("universities.txt");
   	Vector universities = s.getUniversities(path2); 
%>
<table border="1">
<%
		for (int i = 0; i < 51; i++) {
			Vector universityList = (Vector)universities.get(i);
			String state = (String)universityList.get(0);
			%>
			
			<td><a href="degree_university.jsp?location=<%=state%>"><%=state%></a></td>
			<%
			if( (i+1)%3 == 0) { %>
				<tr>
		<%	}
 	}
%>
</table>

<p>
Other Country :
<p>
<% 
 	
   	String path3 = config.getServletContext().getRealPath("universities.txt");
   	Vector universities_country = s.getUniversities(path3); 
%>
<table border="1">
<%
		for (int i = 0; i < universities.size(); i++) {
			Vector universityList = (Vector)universities_country.get(i);
			String country = (String)universityList.get(0);
			%>
			<% if ( i >= 51) { %>
			       <td><a href="degree_university.jsp?location=<%=country%>"><%=country%></a></td>
			<% }
			if(  ( (i+1)%3 == 0) && (i >= 51)){ %>
				<tr>
		<%	}
 	}
%>
</table>

<p>
</body>
</html>