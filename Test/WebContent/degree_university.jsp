<%@page import="support.*, java.util.*"  %>
<html>
<head>
<title>Provide Degrees -- Choose University</title>
</head>
<body>
<% String Residence_test = (String)session.getAttribute("residence") ; 
String c_ship = (String)session.getAttribute("citizenship");%>

First Name: <%=session.getAttribute("first") %> </br >
Middle Initial: <%=session.getAttribute("middle") %> </br>
Last Name: <%=session.getAttribute("last") %> </br>
Citizenship: <%=session.getAttribute("citizenship") %> </br>
Country of Residence: <%=session.getAttribute("residence")%> </br>
<% Address a = (Address)session.getAttribute("address");
   String add = a.getAddress();
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
<% if (!(Residence_test.equals("United States")) ){ %>
	Country Telephone Code: <%=ctc%> </br>
<%} 
else{ %>
	State: <%=state %>
<%} %>
<% 
if ( c_ship.equals("United States")|| Residence_test.equals("United States") ){
%>
	Identity of the Applicant: Domestic Applicant <br>	
<%
}
else {%>
	Identity of the Applicant: International Applicant<br>
<%
}
%>
<% String location = request.getParameter("location"); 
%>
<% String counter = (String)session.getAttribute("counter");
int count = Integer.parseInt(counter);
count++;
counter = Integer.toString(count);
session.setAttribute("counter", counter); %>
<!-- CREATES NEW DEGREE OBJECT RIGHT HERE -->
<%
Degree d = new Degree();
d.setLocation(location);


session.setAttribute("degree", d);
Degree d1 = (Degree)session.getAttribute("degree");
String loc = (String)d1.getLocation();
%>

<%
	ArrayList<Degree> d_array = (ArrayList<Degree>)session.getAttribute("degreeArray") ;
	int count_t = Integer.parseInt(counter);
	String StringCount, l, university, title, major, GPA, year, month;
	if (count_t > 0) {
		for (int i = 0 ; i < d_array.size(); i++ ){ 
		StringCount = Integer.toString(i+1) ;
		l = d_array.get(i).getLocation();
		university = d_array.get(i).getUniversity() ;
		title = d_array.get(i).getTitle();
		major = d_array.get(i).getDiscipline() ;
		GPA = d_array.get(i).getGPA() ;
		month = d_array.get(i).getMonth() ;
		year = d_array.get(i).getYear();
		%>
		University <%=StringCount %> in <%=l %> <br>
		Name of University: <%=university%> <br>
		major : <%= major %><br>
		title : <%= title %><br>
		GPA/Expect GPA: <%=GPA%> <br>
		Month/Year: <%=month %>/<%=year %> <br>
		<br>	
	<%	}
	}
%>


<br> 
University <%=counter %> in <%=loc %>:
<p>
<% 
   	support s = new support();
   	String path2 = config.getServletContext().getRealPath("universities.txt");
   	Vector universities = s.getUniversities(path2);
%>
   	<table border="1">
<%
   	for(int i = 0; i < universities.size(); i++)
   	{
    	Vector universitiesList = (Vector)universities.get(i);
    	String country = (String)universitiesList.get(0);
    	if(country.equals(location))
    	{
    		Vector u = (Vector)universitiesList.get(1);
    		for(int j = 0; j < u.size(); j++)
    		{ %>
    			<td><a href="degree_major.jsp?university=<%=u.get(j)%>"><%=u.get(j)%></a></td>
    			<% if( (j+1)%3 == 0) { %>
				<tr>
	    		<%} %>
    	<% } %>
   	     
   	 <% } %>
  <% } %>

</table>
If your university is not listed above, please enter it in the text box below:
<form action="degree_major.jsp" method="POST">
<input type="text" name="university" />
<input type = "submit" name = "action" value = "submit" />
</form>


</body>
</html>