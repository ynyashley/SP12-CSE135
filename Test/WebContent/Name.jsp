<%@page import="support.*, java.util.*" %>
<html>
<head>
<title> Applicant Name </title>
</head>
<body>
	<!-- Initialize Applicant with first name, last name, middle name -->
	<p> Please enter your information: </p>
	<form action="Citizenship.jsp" method="POST">
	First name: <input type="text" name="first" /><br />
	Middle Initial: <input type="text" name="middle" /><br />
	Last name: <input type="text" name="last" /> <br />
	<input type = "submit" name = "action" value = "submit" />
	</form>



</body>
</html>