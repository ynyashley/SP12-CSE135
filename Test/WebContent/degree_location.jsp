<%@page import="support.*, java.util.*"  %>
<html>
<head>
<title>Provide Degrees -- Choose Location</title>
</head>
<%
/* Get the information from the session and display it 
 */
String Residence_test = (String)session.getAttribute("residence") ;  
String c_ship = (String)session.getAttribute("citizenship");%>
First Name: <%=session.getAttribute("first") %> </br >
Middle Initial: <%=session.getAttribute("middle") %> </br>
Last Name: <%=session.getAttribute("last") %> </br>
Citizenship: <%=session.getAttribute("citizenship") %> </br>
Country of Residence: <%=Residence_test%> </br>
<% 
	/* 
	 * Creates an Address object if the counter is "0".
	 * also set counter in session.
	 */
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
// put the elements to the address object and display them
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
Area Code: <%=area %> <br>
<% // check if the residence is in US or not. if so 
   // display state, otherwise display the country telephone code  
if(!(Residence_test.equals("United States")) ){ %>
Country Tel Code: <%=ctc1 %> <br>
<br>
<%} 
else{ %>
State: <%=state2 %>
<%} %>
<% 
/*
 * The applicant is considered as a domestic applicant if he/she either
 * resides in the U.S. or he/she owns a citizenship in the United States
 * Otherwise, the applicant is considered as an international applicant.
 */
if ( c_ship.equals("United States")|| Residence_test.equals("United States") ){
%>
	Identity of the Applicant: Domestic Applicant <br>	
<%
}
else {%>
	Identity of the Applicant: International Applicant <br>
<%
}
%>
<%
	/* 
	 * Get the ArrayList object from session and use a loop to print out
	 * all the information of the degree(s) that have previously been
	 * entered
	 */
	ArrayList<Degree> d_array = (ArrayList<Degree>)session.getAttribute("degreeArray") ;
	int count = Integer.parseInt(counter);
	String StringCount, loc, university, title, major, GPA, year, month;
	if (count > 0) {
		for (int i = 0 ; i < d_array.size(); i++ ){ 
		StringCount = Integer.toString(i+1) ;
		loc = d_array.get(i).getLocation();
		university = d_array.get(i).getUniversity() ;
		title = d_array.get(i).getTitle();
		major = d_array.get(i).getDiscipline() ;
		GPA = d_array.get(i).getGPA() ;
		month = d_array.get(i).getMonth() ;
		year = d_array.get(i).getYear();
		%>
		University <%=StringCount %> in <%=loc %> <br>
		Name of University: <%=university%> <br>
		Major : <%= major %><br>
		Title : <%= title %><br>
		GPA/Expected GPA: <%=GPA%> <br>
		Month/Year: <%=month %>/<%=year %> <br>
		<br>	
	<%	}
	}
%>
<body>
<p>
Please choose your school location.
<p>
States in United States :
<p>
<% 
   	// calling the methood from support to access the vector of university
	support s = new support();   	
   	String path2 = config.getServletContext().getRealPath("universities.txt");
   	Vector universities = s.getUniversities(path2); 
%>
<table border="1">
<%
		// print them out in 3 columns
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
   	// same as previous part
	String path3 = config.getServletContext().getRealPath("universities.txt");
   	Vector universities_country = s.getUniversities(path3); 
%>
<table border="1">
<%
		/* print them with 3 columns but only print out the Country other than US.
		 */
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