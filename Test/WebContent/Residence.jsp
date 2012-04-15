<%@page import="support.*, java.util.*"  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Residence</title>
</head>
<body>
<% String country = request.getParameter("country"); %>

<%
session.setAttribute("citizenship", country);
%>
First Name: <%=session.getAttribute("first") %> </br >
Middle: <%=session.getAttribute("middle") %> </br>
Last Name: <%=session.getAttribute("last") %> </br>
Citizenship: <%=country%> </br>
<br>
<a href="Address.jsp?country=<%=country%>">Same as country of citizenship</a><br>
	<% 
   	support s = new support();   	
   	
   	String path1 = config.getServletContext().getRealPath("countries.txt");
	
    //getCountries returns a vector of the countries to be used for choosing citizenship
    Vector countries = s.getCountries(path1); %>
    
   <table border="1">
	<% for(int i=0; i<countries.size()/3; i++) {
		String c = (String)countries.get(i); %>
		<tr>
      	<td><a href="Address.jsp?country=<%=c%>"><%=countries.get(i) %></a><br></td>
      	<td><a href="Address.jsp?country=<%=c%>"><%=countries.get(countries.size()/3 + i)%></a><br></td>
      	<td><a href="Address.jsp?country=<%=c%>"><%=countries.get(2 * countries.size()/3 + i)%></a><br></td>
      	</tr>
     <% 
     } 
     
     %>
     <% String extra_country = (String) countries.get(countries.size()-1) ;  %>
     <td><a href="Address.jsp?country=<%=extra_country%>"><%=extra_country%></a><br></td>

    
    </table>	
</body>
</html>