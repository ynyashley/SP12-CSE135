<%@page import="support.*, java.util.*" %>
<html>
<head>
<title> Applicant Name </title>
</head>
<body>
	<!-- Initialize Applicant with first name, last name, middle name -->
	<% String action = request.getParameter("action"); %>
	<% if(action != null && action.equals("submit"))
	{
		Applicant newApplicant = new Applicant();
		
		newApplicant.setFirstName(request.getParameter("first"));
		newApplicant.setMiddleName(request.getParameter("middle"));
		newApplicant.setLastName(request.getParameter("last"));
	} %>
</body>
</html>