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
Citizenship: <%=session.getAttribute("citizenship") %> </br>
Country of Residence: <%=residenceCountry%> </br>


<% session.setAttribute("residence", residenceCountry); %>

<% 
	if (residenceCountry.equals("United States") ){
%>		
    <form action="degree_location.jsp" method="POST">
		Address: <input type="text" name="address" /><br />
		State: <input type="text" name="state" /><br />
		Zip: <input type="text" name="zip" size="5" /> <br />
		City: <input type="text" name="city" /><br />
		Area Code: <input type="text" name="areaCode" size="3"><br />

		<input type = "submit" name = "action" value = "submit" />
	</form>
	<% 
	}
	else {
	%>
	<form action="degree_location.jsp" method="POST">
		Address: <input type="text" name="address" /><br />
		Country Telephone code: <input type="text" name="countryTelCode"  /><br />
		Zip: <input type="text" name="zip" size="5" maxlength="5"/> <br />
		City: <input type="text" name="city" /><br />
		Area Code: <input type="text" name="areaCode" size="3" maxlength="3" /><br />

		<input type = "submit" name = "action" value = "submit" />
	</form>
	<% 	
	}
	%>
</body>
</html>