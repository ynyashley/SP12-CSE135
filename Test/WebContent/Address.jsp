<%@page import="support.*, java.util.*"  %>
<html>
<head>
<title>Address</title>
</head>
<body>
<% String residenceCountry = request.getParameter("country"); %>
<%
session.setAttribute("residence", residenceCountry);
%>
First Name: <%=session.getAttribute("first") %> </br >
Middle Initial: <%=session.getAttribute("middle") %> </br>
Last Name: <%=session.getAttribute("last") %> </br>
Citizenship: <%=session.getAttribute("ciztizenship") %> </br>
Country of Residence: <%=residenceCountry%> </br>
<% session.setAttribute("residence", residenceCountry); %>

<% 
	if (residenceCountry.equals("United States") ){
%>		
    <form action="degree.jsp" method="POST">
		address: <input type="text" name="address" /><br />
		State: <input type="text" name="state" /><br />
		Zip: <input type="text" name="zip" /> <br />
		City: <input type="text" name="city" /><br />
		Area Code: <input type="text" name="areaCode" /><br />

		<input type = "submit" name = "action" value = "submit" />
	</form>
	<% 
	}
	else {
	%>
	<form action="degree.jsp" method="POST">
		address: <input type="text" name="address" /><br />
		Country Tel code: <input type="text" name="countryTelCode" /><br />
		Zip: <input type="text" name="zip" /> <br />
		City: <input type="text" name="city" /><br />
		Area Code: <input type="text" name="areaCode" /><br />

		<input type = "submit" name = "action" value = "submit" />
	</form>
	<% 	
	}
	%>
</body>
</html>