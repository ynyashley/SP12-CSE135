<%@page import="support.*, java.util.*"  %>
<html>
<head>
<title> Citizenship </title>
</head>
<body>
	
	<%
       String first = request.getParameter("first");
	   String middle = request.getParameter("middle");
	   String last = request.getParameter("last");
	   session.setAttribute("first", first);
	   session.setAttribute("middle", middle);
	   session.setAttribute("last", last);
	   
    %>
	<%= "First Name: " +  first %> </br> 
	<%= "Middle Initial: " +  middle %> </br> 
	<%= "Last Name: " +  last %> </br>
	
	Please choose your country of citizenship:
	
  <% 
   	support s = new support();   	
   	
   	String path1 = config.getServletContext().getRealPath("countries.txt");
	
    //getCountries returns a vector of the countries to be used for choosing citizenship
    Vector countries = s.getCountries(path1); 
    %>
    
    <table border="1">
	<% for(int i=0; i<countries.size()/3; i++) {
		String c_1 = (String)countries.get(i); 
		String c_2 = (String)countries.get(countries.size()/3 + i);
		String c_3 = (String)countries.get(2 * countries.size()/3 + i); %>
		<tr>
      	<td><a href="Residence.jsp?country=<%=c_1%>"><%=countries.get(i) %></a><br></td>
      	<td><a href="Residence.jsp?country=<%=c_2%>"><%=countries.get(countries.size()/3 + i)%></a><br></td>
      	<td><a href="Residence.jsp?country=<%=c_3%>"><%=countries.get(2 * countries.size()/3 + i)%></a><br></td>
      	</tr>
     <% 
     } 
     
     %>
     <% String extra_country = (String) countries.get(countries.size()-1) ;  %>
     <td><a href="Residence.jsp?country=<%=extra_country%>"><%=extra_country%></a><br></td>
		
    
    </table>	
    
    
    
   <br>
</body>
</html>