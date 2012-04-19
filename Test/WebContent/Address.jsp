<%@page import="support.*, java.util.*"  %>
<html>
<head>
<title>Address</title>
</head>

<body>
<% String residenceCountry = (String)request.getParameter("country"); 
String c_ship = (String)session.getAttribute("citizenship");%>
<%
/* Get the information for the residence and creating the counter for 
*  the arrayList of Degree object. Also set the ArrayList of Degree to 
*  session.
*/
session.setAttribute("residence", residenceCountry);
String counter = "0";
session.setAttribute("counter", counter);
ArrayList<Degree> Degree_array=new ArrayList<Degree>();
session.setAttribute("degreeArray", Degree_array);

%>
First Name: <%=session.getAttribute("first") %> </br >
Middle Initial: <%=session.getAttribute("middle") %> </br>
Last Name: <%=session.getAttribute("last") %> </br>
Citizenship: <%=session.getAttribute("citizenship") %> </br>
Country of Residence: <%=residenceCountry%> </br>
<% // check if the applicant is Demostic Applicant or not
if ( c_ship.equals("United States")|| residenceCountry.equals("United States") ){
%>
	Identity of the Applicant: Domestic Applicant <br>	
<%
}
else {%>
	Identity of the Applicant: International Applicant<br>
<%
}
%>

<% session.setAttribute("residence", residenceCountry); %>

<% /* if the residence is in United States, provide a US address form to applicant
	* , else provide a form of international address
	*/
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
		Area Code: <input type="text" name="areaCode" size="3" /><br />

		<input type = "submit" name = "action" value = "submit" />
	</form>
	<% 	
	}
	%>
</body>
</html>