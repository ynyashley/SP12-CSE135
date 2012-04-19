<%@page import="support.*, java.util.*"  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Residence</title>
</head>
<body>
<!-- Get the information from the session and display them -->
<% String country = request.getParameter("country"); %>

<%
session.setAttribute("citizenship", country);
%>
First Name: <%=session.getAttribute("first") %> </br >
Middle Initial: <%=session.getAttribute("middle") %> </br>
Last Name: <%=session.getAttribute("last") %> </br>
Citizenship: <%=country%> </br>
<br>
<!-- provide the hyperlink if the residence is the same as citizenship -->
<a href="Address.jsp?country=<%=country%>">Same as country of citizenship</a><br>
	<% 
   	support s = new support();   	
   	
   	String path1 = config.getServletContext().getRealPath("countries.txt");
	
    //getCountries returns a vector of the countries to be used for choosing citizenship
    Vector countries = s.getCountries(path1); %>
    
   <table border="1">
	<% for(int i=0; i<countries.size()/3; i++) {
		String c_1 = (String)countries.get(i); 
		String c_2 = (String)countries.get(countries.size()/3 + i);
		String c_3 = (String)countries.get(2 * countries.size()/3 + i); %>
		<tr>
      	<td><a href="Address.jsp?country=<%=c_1%>"><%=countries.get(i) %></a><br></td>
      	<td><a href="Address.jsp?country=<%=c_2%>"><%=countries.get(countries.size()/3 + i)%></a><br></td>
      	<td><a href="Address.jsp?country=<%=c_3%>"><%=countries.get(2 * countries.size()/3 + i)%></a><br></td>
      	</tr>
     <% 
     } 
     
     %>
     <% String extra_country = (String) countries.get(countries.size()-1) ;  %>
     <td><a href="Address.jsp?country=<%=extra_country%>"><%=extra_country%></a><br></td>

    
    </table>	
</body>
</html>