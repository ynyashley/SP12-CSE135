<%@page import="support.*,java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">
	// this function is for showing the applicant's application by using Ajax, sending the request to the 
	// server and display the hide application button.
	// str: applicant id, num: number of the degree for that particular applicant
	function showapp(str, num) { 
		var xmlHttp;
		xmlHttp = new XMLHttpRequest();
		if (xmlHttp == null) {
			alert("Your browser does not support AJAX!");
			return;
		}
	
		var url = "application_xml.jsp";
		url = url + "?id=" + str;
		url = url + "&sid=" + Math.random();
		var count_degree = 0 ;
		var ele = document.getElementById("displayPage"+str);
		var button_show = document.getElementById("showbutton"+str);
		var button_hide = document.getElementById("hidebutton"+str);
		ele.style.display = "block" ; // make the displayPage to be viewed 
		button_show.style.display ="none" ; // hide the show application button 
		button_hide.style.display ="block" ; // make the hide application button to be viewed 
			xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4) {
				var xmlDoc = xmlHttp.responseXML.documentElement;
				document.getElementById("first"+str).innerHTML= xmlDoc.getElementsByTagName("first")[0].childNodes[0].nodeValue;
				document.getElementById("last"+str).innerHTML= xmlDoc.getElementsByTagName("last")[0].childNodes[0].nodeValue;
				document.getElementById("middle"+str).innerHTML= xmlDoc.getElementsByTagName("middle")[0].childNodes[0].nodeValue;
				document.getElementById("reside"+str).innerHTML= xmlDoc.getElementsByTagName("reside")[0].childNodes[0].nodeValue;
				document.getElementById("citizen"+str).innerHTML= xmlDoc.getElementsByTagName("citizen")[0].childNodes[0].nodeValue;
				document.getElementById("spec"+str).innerHTML= xmlDoc.getElementsByTagName("spec")[0].childNodes[0].nodeValue;
				document.getElementById("street"+str).innerHTML= xmlDoc.getElementsByTagName("street")[0].childNodes[0].nodeValue;
				document.getElementById("city"+str).innerHTML= xmlDoc.getElementsByTagName("city")[0].childNodes[0].nodeValue;
				document.getElementById("zip"+str).innerHTML= xmlDoc.getElementsByTagName("zip")[0].childNodes[0].nodeValue;
				document.getElementById("area"+str).innerHTML= xmlDoc.getElementsByTagName("area")[0].childNodes[0].nodeValue;
				
				alert(xmlDoc.getElementsByTagName("state")[0] == null)
				if(xmlDoc.getElementsByTagName("state")[0] == null){
					document.getElementById("tele"+str).innerHTML= xmlDoc.getElementsByTagName("tele")[0].childNodes[0].nodeValue;
				}else{
					document.getElementById("state"+str).innerHTML= xmlDoc.getElementsByTagName("state")[0].childNodes[0].nodeValue;
				} // since the applicant may have multi degrees so we need to create the tag dynamically
				for (count_degree = 0 ; count_degree < num ; count_degree++) {
					document.getElementById("major"+str+count_degree).innerHTML= xmlDoc.getElementsByTagName("major"+count_degree)[0].childNodes[0].nodeValue;
					document.getElementById("title"+str+count_degree).innerHTML= xmlDoc.getElementsByTagName("title"+count_degree)[0].childNodes[0].nodeValue;
					document.getElementById("uni"+str+count_degree).innerHTML= xmlDoc.getElementsByTagName("uni"+count_degree)[0].childNodes[0].nodeValue;
					document.getElementById("month"+str+count_degree).innerHTML= xmlDoc.getElementsByTagName("month"+count_degree)[0].childNodes[0].nodeValue;
					document.getElementById("year"+str+count_degree).innerHTML= xmlDoc.getElementsByTagName("year"+count_degree)[0].childNodes[0].nodeValue;

				}
			}
		}
		xmlHttp.open("GET", url, true); // send the request to the server
		xmlHttp.send();
	}
	// this function is for hide the application and show the show application button 
	// by using the div display = block and none 
	// str: applicant id, num: number of the degree for that particular applicant
	function hideapp(str,num)
	{
		var xmlHttp;
		//alert(str);
		xmlHttp = new XMLHttpRequest();
		if (xmlHttp == null) {
			alert("Your browser does not support AJAX!");
			return;
		}
		var url = "blank.jsp";
		url = url + "?id=" + str;
		url = url + "&sid=" + Math.random();
		var ele = document.getElementById("displayPage"+str);
		var button_show = document.getElementById("showbutton"+str);
		var button_hide = document.getElementById("hidebutton"+str);
		// set the visibality for the button and the div tag 
		button_show.style.display ="block" ;
		button_hide.style.display ="none" ;
		ele.style.display ="none" ;
		var count_degree = 0 ;
		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4) { 
				// reset the content of the tag to ""
				var xmlDoc = xmlHttp.responseXML.documentElement;
				document.getElementById("first"+str).innerHTML= "";
				document.getElementById("last"+str).innerHTML= "";
				document.getElementById("middle"+str).innerHTML= "";
				document.getElementById("reside"+str).innerHTML= "";
				document.getElementById("citizen"+str).innerHTML= "";
				document.getElementById("spec"+str).innerHTML= "";
				document.getElementById("street"+str).innerHTML= "";
				document.getElementById("city"+str).innerHTML= "";
				document.getElementById("zip"+str).innerHTML= "";
				document.getElementById("area"+str).innerHTML= "";
				if(xmlDoc.getElementsByTagName("state")[0].childNodes[0] == null)
				{
					document.getElementById("tele"+str).innerHTML= "";
				}
				else
				{
					document.getElementById("state"+str).innerHTML= "";
				}
				// reseting the multi degree tag to ""
				for (count_degree = 0 ; count_degree < num ; count_degree++) {
					document.getElementById("major"+str+count_degree).innerHTML= "";
					document.getElementById("title"+str+count_degree).innerHTML= "";
					document.getElementById("uni"+str+count_degree).innerHTML= "";
					document.getElementById("month"+str+count_degree).innerHTML= "";
					document.getElementById("year"+str+count_degree).innerHTML= "";

				}
			}
		}
		xmlHttp.open("GET", url, true); // send the request to the server
		xmlHttp.send();
		
	}
	// ajax basic function
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
<title>Application</title>
</head>
<body>
<%
	String spec = (String) request
			.getParameter("specialization_analysis");
	String major = (String) request.getParameter("major");
	//out.println(spec) ;
%>

<%@ page import="java.sql.*"%>

<FORM METHOD=GET ACTION="application.jsp">
<%
	// Connect to the postgreSQL and set up the result set 
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	ResultSet rs_countries = null;
	ResultSet rs_spec = null;
	ResultSet rs_address = null;
	ResultSet rs_pid = null;
	ResultSet rs_degree = null;
	ResultSet rs_uni = null;
	ResultSet rs_mj = null;
	ResultSet rs_param = null;
	ResultSet rs_param_1 = null;
	ResultSet rs_param_2 = null;
	ResultSet rs_degree_major = null;

	try {
		// Registering Postgresql JDBC driver with the DriverManager
		Class.forName("org.postgresql.Driver");

		// Open a connection to the database using DriverManager
		conn = DriverManager
				.getConnection("jdbc:postgresql://localhost:5432/Applicant?"
						+ "user=postgres&password=1234");
		
		Statement stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();
		Statement stmt2 = conn.createStatement();
		Statement stmt3 = conn.createStatement();
		Statement stmt4 = conn.createStatement();
		Statement stmt5 = conn.createStatement();
		Statement stmt6 = conn.createStatement();
		// if spec and major is null, it means we access the application directly and it suppose to show the hyperlink of the name
		%> <% 
		if (spec == null && major == null) {
			rs = stmt.executeQuery("SELECT* FROM personal_info");
			String FullName = "";
			out.println("Names of Applicants: <br>");
			int i = 1 ;
			int count = 0 ;
			int num = 0 ;
			while (rs.next()) {
				FullName = rs.getString(2) + " " + rs.getString(3)
						+ " " + rs.getString(4);
				count = 0 ;
				// count how many degree does the current applicant have.
				rs_pid = stmt2
				.executeQuery("SELECT degree FROM has_degree where personal ='"
						+ rs.getString(1) + "'");
				while (rs_pid.next()) {
					count++ ;
				}
				%>
				<!-- This are the show applicantion button and hide applicaton button
					The default setting is displaying the show application button and hide
					another one. When the user click show application, it will send the request to 
					javaScript function and display all the information of the applicant. Then display the 
					hide application button and hide show application button-->
				<div id="showbutton<%=Integer.toString(rs.getInt(1))%>"  style = "display: block">
				<%out.print(FullName + " ") ; %><td><input type="button" value="Show Application"  
				    onclick="showapp(<%=Integer.toString(rs.getInt(1))%>,<%=Integer.toString(count)%> )"/></td>
				</div>
				
				<div id="hidebutton<%=Integer.toString(rs.getInt(1))%>"  style = "display: none">
				<%out.print(FullName + " ") ; %><td><input type="button" value="Hide Application"  
				    onclick="hideapp(<%=Integer.toString(rs.getInt(1))%>,<%=Integer.toString(count)%>)"/></td>
				</div>
			
		
			<!--  this are html codes for creating mult div tags. 
			The default setting for displaying is none which is not shown at the beginning  -->
<div id="displayPage<%=rs.getInt(1)%>" style="display: none"> 
			<span id="application<%=rs.getInt(1)%>"></span><br>
			<span id="first<%=rs.getInt(1)%>"></span><br>
			<span id="last<%=rs.getInt(1)%>"></span><br>
			<span id="middle<%=rs.getInt(1)%>"></span><br>
			<span id="reside<%=rs.getInt(1)%>"></span><br>
			<span id="citizen<%=rs.getInt(1)%>"></span><br>
			<span id="spec<%=rs.getInt(1)%>"></span><br>
			<span id="street<%=rs.getInt(1)%>"></span><br>
			<span id="city<%=rs.getInt(1)%>"></span><br>
			<span id="zip<%=rs.getInt(1)%>"></span><br>
			<span id="state<%=rs.getInt(1)%>"></span>
			<span id ="tele<%=rs.getInt(1)%>"></span><br>
			<span id ="area<%=rs.getInt(1)%>"></span><br>
			
<%
			num = 0 ; // reset 0 for every applicant
			// Creating the multi degree since the applicant may have more than one degree
			while ( num < count ) { 
%>
			<span id ="uni<%=rs.getInt(1)%><%=num%>"></span><br>
			<span id ="major<%=rs.getInt(1)%><%=num%>"></span><br>
			<span id ="year<%=rs.getInt(1)%><%=num%>"></span><br>
			<span id ="month<%=rs.getInt(1)%><%=num%>"></span><br>
			<span id = "title<%=rs.getInt(1)%><%=num%>"></span><br>
		<%    num++ ;
			} 
		%>
</div>
		<% 	i++ ;
			}
		} else if (spec != null && major == null) { // the access from specialization analytics
			// get the s_id from specialization 
			rs_param = stmt4
					.executeQuery("SELECT s_id FROM specializations where specialization = '"
							+ spec + "'");
			
			rs_param.next();
			// get all the stuff from personal_info using the spec 
			rs = stmt
					.executeQuery("SELECT* FROM personal_info where spec = '"
							+ rs_param.getInt(1) + "'");
			// print out the applicant information
			while (rs.next()) {
				
				out.println("Name of the Applicant: ");
				out.println("<br>");
				out.println("First Name: " + rs.getString(2));
				out.println("<br>");
				out.println("Last Name: " + rs.getString(3));
				out.println("<br>");
				out.println("MI: " + rs.getString(4));
				out.println("<br>");
				rs_countries = stmt1
						.executeQuery("SELECT country FROM countries where c_id ='"
								+ rs.getInt(5) + "'");
				while (rs_countries.next()) {
					out.println("Residence : "
							+ rs_countries.getString(1) + " ");
				}
				out.println("<br>");
				// print out the residence and citizenship 
				rs_countries = stmt1
						.executeQuery("SELECT country FROM countries where c_id ='"
								+ rs.getInt(6) + "'");
				while (rs_countries.next()) {
					out.println("Citizenship : "
							+ rs_countries.getString(1) + "<br>");
				}
				// print out the specialization of applicant
				rs_spec = stmt1
						.executeQuery("SELECT specialization FROM specializations where s_id ='"
								+ rs.getInt(8) + "'");
				while (rs_spec.next()) {
					out.println("Specialization : "
							+ rs_spec.getString(1) + "<br>");
				}

				rs_address = stmt2
						.executeQuery("SELECT * FROM address where a_id ='"
								+ rs.getInt(7) + "'");

				out.println("<br> Address of Applicant: <br>");
				// display the address of applicant 
				while (rs_address.next()) {
					out.println("Street : " + rs_address.getString(2));
					out.println("<br>");
					out.println("Zip : " + rs_address.getString(3));
					out.println("<br>");
					if (rs_address.getString(4) != null) {
						out.println("State : "
								+ rs_address.getString(4));
					}
					out.println("Area Code : "
							+ rs_address.getString(5));
					out.println("<br>");
					out.println("City : " + rs_address.getString(6));
					out.println("<br>");
					if (rs_address.getString(7) != null) {
						out.println("Telephone Code : "
								+ rs_address.getString(7));
					}

				}

				out.println("<br>Degrees of the Applicant: <br>");
				// print out the applicant's degree information including GPA, university, title, year and month
				rs_pid = stmt2
						.executeQuery("SELECT degree FROM has_degree where personal ='"
								+ rs.getString(1) + "'");
				while (rs_pid.next()) {
					rs_degree = stmt1
							.executeQuery("SELECT * FROM degrees where d_id='"
									+ rs_pid.getInt(1) + "'");
					while (rs_degree.next()) {
						rs_uni = stmt3
								.executeQuery("SELECT university FROM universities where u_id ='"
										+ rs_degree.getInt(2) + "'");
						while (rs_uni.next()) {
							out.println("University : "
									+ rs_uni.getString(1));
						}
						out.println("<br>");
						rs_mj = stmt3
								.executeQuery("SELECT major FROM majors where m_id ='"
										+ rs_degree.getInt(3) + "'");
						while (rs_mj.next()) {
							out.println("Major : " + rs_mj.getString(1));
						}
						out.println("<br>");
						out.println("Title : " + rs_degree.getString(4));
						out.println("<br>");
						out.println("Award Month/Year : "
								+ rs_degree.getString(5) + "/"
								+ rs_degree.getString(6));
						out.println("<br>");
						out.println("GPA : " + rs_degree.getString(7));
					}
					out.println("<br>");
				}
				out.println("<br>");
			} // for while ( rs.next() )
		} else { // spec == null and major is not null it means accessing application from Discipline Analytics 
			// get the major id from major 
			rs_param = stmt4
					.executeQuery("SELECT m_id FROM majors where major = '"
							+ major + "'");

			rs_param.next();
			// get the degree id from the major table and find it may have many degree having same major 
			rs_param_1 = stmt5
					.executeQuery("SELECT d_id FROM degrees where major = '"
							+ rs_param.getInt(1) + "'");
			ArrayList temp = new ArrayList() ; // this arraylist is for preventing depulicated id to print out again 
			while (rs_param_1.next()) {
				// try to find out all the degrees with the specific major 
				rs_param_2 = stmt6
						.executeQuery("SELECT personal FROM has_degree where degree = '"
								+ rs_param_1.getInt(1) + "'");
				rs_param_2.next() ;
				if ( temp.contains(rs_param_2.getInt(1) )== false ) {
					temp.add(rs_param_2.getInt(1)) ;
					rs = stmt
							.executeQuery("SELECT * FROM personal_info where p_id = '"
									+ rs_param_2.getInt(1) + "'");
					// print out the personal information 
					while (rs.next()) {

						out.println("Name of the Applicant: ");
						out.println("<br>");
						out.println("First Name: " + rs.getString(2));
						out.println("<br>");
						out.println("Last Name: " + rs.getString(3));
						out.println("<br>");
						out.println("MI: " + rs.getString(4));
						out.println("<br>");
						
						// print out the residence and citizenship 
						rs_countries = stmt1
								.executeQuery("SELECT country FROM countries where c_id ='"
										+ rs.getInt(5) + "'");
						while (rs_countries.next()) {
							out.println("Residence : "
									+ rs_countries.getString(1) + " ");
						}
						out.println("<br>");

						rs_countries = stmt1
								.executeQuery("SELECT country FROM countries where c_id ='"
										+ rs.getInt(6) + "'");
						while (rs_countries.next()) {
							out.println("Citizenship : "
									+ rs_countries.getString(1)
									+ "<br>");
						}
						// display the specialization of the applicant
						rs_spec = stmt1
								.executeQuery("SELECT specialization FROM specializations where s_id ='"
										+ rs.getInt(8) + "'");

						while (rs_spec.next()) {
							out.println("Specialization : "
									+ rs_spec.getString(1) + "<br>");
						}

						rs_address = stmt2
								.executeQuery("SELECT * FROM address where a_id ='"
										+ rs.getInt(7) + "'");

						out.println("<br> Address of Applicant: <br>");
						// display the address of the applicant 
						while (rs_address.next()) {
							out.println("Street : "
									+ rs_address.getString(2));
							out.println("<br>");
							out.println("Zip : "
									+ rs_address.getString(3));
							out.println("<br>");
							if (rs_address.getString(4) != null) {
								out.println("State : "
										+ rs_address.getString(4));
							}
							out.println("Area Code : "
									+ rs_address.getString(5));
							out.println("<br>");
							out.println("City : "
									+ rs_address.getString(6));
							out.println("<br>");
							if (rs_address.getString(7) != null) {
								out.println("Telephone Code : "
										+ rs_address.getString(7));
							}

						}
						// print out the degree information of applicant including gpa, major, university, graduated year, month and title 
						out.println("<br>Degrees of the Applicant: <br>");

						rs_pid = stmt2
								.executeQuery("SELECT degree FROM has_degree where personal ='"
										+ rs.getString(1) + "'");

						while (rs_pid.next()) {
							rs_degree = stmt1
									.executeQuery("SELECT * FROM degrees where d_id='"
											+ rs_pid.getInt(1) + "'");
							while (rs_degree.next()) {
								rs_uni = stmt3
										.executeQuery("SELECT university FROM universities where u_id ='"
												+ rs_degree.getInt(2)
												+ "'");
								while (rs_uni.next()) {
									out.println("University : "
											+ rs_uni.getString(1));
								}
								out.println("<br>");
								rs_mj = stmt3
										.executeQuery("SELECT major FROM majors where m_id ='"
												+ rs_degree.getInt(3)
												+ "'");
								while (rs_mj.next()) {
									out.println("Major : "
											+ rs_mj.getString(1));
								}
								out.println("<br>");
								out.println("Title : "
										+ rs_degree.getString(4));
								out.println("<br>");
								out.println("Award Month/Year : "
										+ rs_degree.getString(5) + "/"
										+ rs_degree.getString(6));
								out.println("<br>");
								out.println("GPA : "
										+ rs_degree.getString(7));
							}
							out.println("<br>");
						}
						out.println("<br>");
					}
				}
			}
		}
	// close the result sets and prepare statement 
	} catch (SQLException e) { 
		throw new RuntimeException(e);
	} finally {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
			}
			rs = null;
		}
		if (rs_mj != null) {
			try {
				rs_mj.close();
			} catch (SQLException e) {
			}
			rs_mj = null;
		}
		if (rs_uni != null) {
			try {
				rs_uni.close();
			} catch (SQLException e) {
			}
			rs_uni = null;
		}
		if (rs_degree != null) {
			try {
				rs_degree.close();
			} catch (SQLException e) {
			}
			rs_degree = null;
		}
		if (rs_degree_major != null) {
			try {
				rs_degree_major.close();
			} catch (SQLException e) {
			}
			rs_degree_major = null;
		}
		if (rs_countries != null) {
			try {
				rs_countries.close();
			} catch (SQLException e) {
			}
			rs_countries = null;
		}
		if (rs_address != null) {
			try {
				rs_address.close();
			} catch (SQLException e) {
			}
			rs_address = null;
		}
		if (rs_spec != null) {
			try {
				rs_spec.close();
			} catch (SQLException e) {
			}
			rs_spec = null;
		}
		if (rs_param != null) {
			try {
				rs_param.close();
			} catch (SQLException e) {
			}
			rs_param = null;
		}
		if (rs_param_1 != null) {
			try {
				rs_param_1.close();
			} catch (SQLException e) {
			}
			rs_param_1 = null;
		}
		if (rs_param_2 != null) {
			try {
				rs_param_2.close();
			} catch (SQLException e) {
			}
			rs_param_2 = null;
		}
		if (rs_pid != null) {
			try {
				rs_pid.close();
			} catch (SQLException e) {
			}
			rs_pid = null;
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
			}
			pstmt = null;
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
			}
			conn = null;
		}

	}
%>
</FORM>
</body>
</html>