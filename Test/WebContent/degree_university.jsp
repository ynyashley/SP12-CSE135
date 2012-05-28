<%@page import="support.*, java.util.*"  %>
<html>
<head>
<title>Provide Degrees -- Choose University</title>
</head>
<body>
<!-- Get information from session and the Address object and print them out-->
<% 
String Residence_test = (String)session.getAttribute("residence") ; 
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
<% 
//Displays Country Tel Code if applicant does not reside in the U.S.
if (!(Residence_test.equals("United States")) ){ %>
	Country Telephone Code: <%=ctc%> </br>
<%} 
//Displays the state otherwise
else{ %>
	State: <%=state %>
<%} %>
</br>
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
	Identity of the Applicant: International Applicant<br>
<%
}
%>
<% String location = request.getParameter("location"); %>
<!-- Creates a counter so we can keep track of how many degrees the applicant has entered -->
<% 
String counter = (String)session.getAttribute("counter");
/* Convert String into int so we can increment the counter */
int count = Integer.parseInt(counter);
count++;
/* Convert the int back into String so it can be passed into the session attribute */
counter = Integer.toString(count);
session.setAttribute("counter", counter); %>

<%
/*
 * Creates a new Degree object so we can save the location of the university,
 * name of the university, major, and title of degree into the same object,
 * which allows us to display all those information on the same page later
 * using session.getAttribute("degree").
 */
Degree d = new Degree();
d.setLocation(location);

session.setAttribute("degree", d);
Degree d1 = (Degree)session.getAttribute("degree");
String loc = (String)d1.getLocation();
%>

<%
/* 
 * Get the ArrayList object from session and use a loop to print out
 * all the information of the degree(s) that have previously been
 * entered
 */
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
		Major : <%= major %><br>
		Title : <%= title %><br>
		GPA/Expected GPA: <%=GPA%> <br>
		Month/Year: <%=month %>/<%=year %> <br>
		<br>	
	<%	}
	}
%>

<!-- in this area of coding, we use the support method and display it with 3 columns
     if the university doesn't exist in the list, provide the text box and require the 
     user to input -->
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
If your university is not listed above, please enter it in the text box below: <br>
<input type="text" name="university" id="university" onfocusout="detect()"/>
<input type="button" value="submit" onclick="detect()"/>
<script type="text/javascript">
	function detect()
	{
		var uni = document.getElementById("university");
		showapp(uni.value);
	}
	function showapp(str) {
		var xmlHttp;
		xmlHttp = new XMLHttpRequest();
		if (xmlHttp == null) {
			alert("Your browser does not support AJAX!");
			return;
		}
		var url = "university_xml.jsp";
		url = url + "?uni=" + str;
		url = url + "&sid=" + Math.random();
		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4) {
				var xmlDoc = xmlHttp.responseXML.documentElement;
				alert('ready');
				document.getElementById("test").innerHTML= xmlDoc.getElementsByTagName("test")[0].childNodes[0].nodeValue;
				alert("Done");
			}
		}
		xmlHttp.open("GET", url, true);
		xmlHttp.send();
	}
	
	function GetXmlHttpObject() {
		var xmlHttp = null;
		try {
			// Firefox, Opera 8.0+, Safari
			xmlHttp = new XMLHttpRequest();
		} catch (e) {
			// Internet Explorer
			try {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		return xmlHttp;
	}
</script>

</head>

<body>
<table>

</table>
<br>

<span id="test"></span>
</body>
</html>