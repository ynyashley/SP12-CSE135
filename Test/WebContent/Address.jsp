<%@page import="support.*, java.util.*"  %>
<html>
<head>
<title>Address</title>
</head>
<body>
<% String country = request.getParameter("country"); %>
Country of Residence: <%=country%>
<% 
	if (country.equals("United States") ){
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