<%@page import="support.*, java.util.*" %>
<html>
<head>
<title>More Degrees</title>
</head>
<body>
<!-- Get information from previous pages and display them -->
<% String Residence_test = (String)session.getAttribute("residence") ;
String c_ship = (String)session.getAttribute("citizenship");%>

First Name: <%=session.getAttribute("first") %> </br >
Middle Initial: <%=session.getAttribute("middle") %> </br>
Last Name: <%=session.getAttribute("last") %> </br>
Citizenship: <%=session.getAttribute("citizenship") %> </br>
Country of Residence: <%=session.getAttribute("residence")%> </br>
<!-- Get counter that keeps track of how many degrees the applicant has entered -->
<% String counter = (String)session.getAttribute("counter"); %>
<% 
Address a = (Address)session.getAttribute("address");
String add = (String)a.getAddress();
String city = (String)a.getCity();
String zip = (String)a.getZip();
String area = (String)a.getAreaCode();
String state = (String)a.getState();
String ctc = (String)a.getTel();
%>
Address: <%=add %></br>
City: <%=city %></br>
Zip: <%=zip %> </br>
Area Code: <%=area %> </br>
<!-- Displays Country Tel Code if applicant does not reside in the U.S. -->
<% if(!Residence_test.equals("United States")) { %>
	Country Telephone Code: <%=ctc%> </br>
<%} 
//Displays State if applicant indicate that he/she resides in the U.S. 
else{ %>
	State: <%=state%>
<%} %>
<br>
<% 
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
   Degree d = (Degree)session.getAttribute("degree");
   String loc = (String)d.getLocation();
   String uni = (String)d.getUniversity();
%>
<% String major = request.getParameter("major");
   String title = request.getParameter("title");
   String GPA = request.getParameter("GPA");
   String month = request.getParameter("month") ;
   String year = request.getParameter("year") ;
%>
<%
	// display the array list if the count_t > 0 
	ArrayList<Degree> d_array = (ArrayList<Degree>)session.getAttribute("degreeArray") ;
	int count_t = Integer.parseInt(counter);
	String StringCount, l, u, t, m, G, y, mo;
	if (count_t > 0) {
		for (int i = 0 ; i < d_array.size(); i++ ){ 
		StringCount = Integer.toString(i+1) ;
		l = d_array.get(i).getLocation();
		u = d_array.get(i).getUniversity() ;
		t = d_array.get(i).getTitle();
		m = d_array.get(i).getDiscipline() ;
		G = d_array.get(i).getGPA() ;
		mo= d_array.get(i).getMonth() ;
		y = d_array.get(i).getYear();
		%>
		University <%=StringCount %> in <%=l %> <br>
		Name of University: <%=u%> <br>
		major : <%= m %><br>
		title : <%= t %><br>
		GPA/Expect GPA: <%=G%> <br>
		Month/Year: <%=mo %>/<%=y %> <br>
		<br>	
	<%	}
	}
%>


Location of University <%=counter %>: <%=loc %> </br>
University <%=counter %>: <%=uni %> </br>
Major <%=counter %>: <%=major %> </br>
Title <%=counter %>: <%=title %> </br>
Graduation Month/Year <%=counter %>: <%= month%>/<%= year %> </br>
GPA/Expected GPA <%=counter %>: <%=GPA %> </br>
<% 
d.setDiscipline(major);
d.setTitle(title);
d.setGPA(GPA) ;
d.setMonth(month) ;
d.setYear(year) ;

d_array.add(d) ;
%>

<!-- provide the botton to the applicant for adding more degree or finishing the application -->
<form action="degree_location.jsp" method="POST">
Do you wish to add more degrees? </br>
<input type = "submit" name = "action" value = "Submit Next Degree"/>
</form>
<form action="specialization.jsp" method="POST">
<input type = "submit" name = "action" value = "Done" />
</form>

</body>
</html>