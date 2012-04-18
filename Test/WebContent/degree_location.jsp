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
	String counter = (String)session.getAttribute("counter");
	String address = (String)request.getParameter("address");
	if(counter.equals("0"))
	{
	   Address a = new Address();
	   a.setAddress(address);
	
	   String city = (String)request.getParameter("city");
	   a.setCity(city);
	
		String zip = (String)request.getParameter("zip");
		a.setZip(zip);
	
		String areaCode = (String)request.getParameter("areaCode");
		a.setAreaCode(areaCode);
	
		String ctc = null;
		String state1 = null;
		if(request.getParameter("state") == null)
		{
			ctc = (String)request.getParameter("countryTelCode");
			a.setTel(ctc);
		}
		else
		{
			state1 = (String)request.getParameter("state");
			a.setState(state1);
		}
	
		session.setAttribute("address", a);
	}
%>
<% 
Address a1 = (Address)session.getAttribute("address");
String add = a1.getAddress(); 
String city1 = a1.getCity();
String zip1 = a1.getZip();
String area = a1.getAreaCode();
String ctc1 = a1.getTel();
String state2 = a1.getState();
%>
Address: <%=add %> <br>
City: <%=city1 %> <br>
Zip: <%=zip1 %> <br>
Area code: <%=area %> <br>
<% if(ctc1 != null){ %>
Country Tel Code: <%=ctc1 %>
<%} 
else{ %>
State: <%=state2 %>
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