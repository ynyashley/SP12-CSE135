<%@page import="support.*, java.util.*"  %>
<html>
<head>
<title>Provide Degree -- Choose Discipline</title>
</head>
<body>
<%
//Get information from session and the Address object and print them out

String Residence_test = (String)session.getAttribute("residence") ;
String c_ship = (String)session.getAttribute("citizenship");%>

First Name: <%=session.getAttribute("first") %> </br >
Middle Initial: <%=session.getAttribute("middle") %> </br>
Last Name: <%=session.getAttribute("last") %> </br>
Citizenship: <%=session.getAttribute("citizenship") %> </br>
Country of Residence: <%=session.getAttribute("residence")%> </br>
<% String counter = (String)session.getAttribute("counter"); %>
<% 
// set those element to the Address object 
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
<% 
//Displays Country Tel Code if applicant does not reside in the U.S.
if(!(Residence_test.equals("United States"))) { %>
	Country Telephone Code: <%=ctc%> </br>
<%} 
else{ %>
	State: <%=state%>
<%} %>
<br>

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
 * Get the Degree object from session so we can access the location and
 * that has previously been provided by the applicant and then set the 
 * newly obtained university field into the existing Degree object.s 
 */
String university = request.getParameter("university");
Degree d = (Degree)session.getAttribute("degree");
d.setUniversity(university);
String loc = (String)d.getLocation();
String uni = (String)d.getUniversity();

%>

<%
   /* 
 	* Get the ArrayList object from session and use a loop to print out
 	* all the information of the degree(s) that have previously been
 	* entered
 	*/
	ArrayList<Degree> d_array = (ArrayList<Degree>)session.getAttribute("degreeArray") ;
	int count_t = Integer.parseInt(counter);
	String StringCount, l, u, title, major, GPA, year, month;
	if (count_t > 0) {
		for (int i = 0 ; i < d_array.size(); i++ ){ 
		StringCount = Integer.toString(i+1) ;
		l = d_array.get(i).getLocation();
		u = d_array.get(i).getUniversity() ;
		title = d_array.get(i).getTitle();
		major = d_array.get(i).getDiscipline() ;
		GPA = d_array.get(i).getGPA() ;
		month = d_array.get(i).getMonth() ;
		year = d_array.get(i).getYear();
		%>
		University <%=StringCount %> in <%=l %> <br>
		Name of University: <%=u%> <br>
		Major : <%= major %><br>
		Title : <%= title %><br>
		GPA/Expected GPA: <%=GPA%> <br>
		Month/Year: <%=month %>/<%=year %> <br>
		<br>	
	<%	}
	}
%>



<!-- display the form for the applicant to specific their major, Gpa and the date -->
Location of University <%=counter %>: <%=loc %> </br>
University <%=counter %>: <%=uni%> 
<% 
String path3 = config.getServletContext().getRealPath("majors.txt");
support s = new support();  
Vector majors = s.getMajors(path3); %>
<form action="more_degrees.jsp" method="POST">

<% for(int i=0; i< majors.size(); i++)
{ %>
	<INPUT TYPE="RADIO" NAME="major" value="<%=majors.get(i)%>">
	<%=majors.get(i)%><br>
<%} %>
Discipline not on the list:
<input type="text" name="major"/>
</br>
Month and year degree was awarded/expected to be awarded: <input type="text" name="month" size="6"/>
/ <input type="text" name="year" size= "6" /><br />
Title of Degree:
<select name="title">
  <option value="BS">BS</option>
  <option value="MS">MS</option>
  <option value="PhD">PhD</option>
</select>
</br>
GPA/Expected GPA: <input type="text" name="GPA" size= "3" /><br />
</br>
	
<input type = "submit" name = "action" value = "submit" />
</form>
</body>
</html>