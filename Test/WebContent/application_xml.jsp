<%@ page contentType="text/xml"%>
<%@ page import="java.sql.*"%>
<%@page import="support.*, java.util.*"  %>
<%
	response.setContentType("text/xml");
	String p_id = request.getParameter("id");
%>
<%
	// This xml page displaying the information of the applicant by using SQL query  and JDBC
	String first_name = "";
	String last_name = "";
	String middle_name = "";
	String Residence = "";
	String Citizenship = "";
	String street = "";
	String zip = "";
	String Specialization = "";
	String state ="";
	String city = "";
	String areaCode = "";
	String tele = "";
	// Creating the Vector for different fields in the degree option
	Vector<String> major = new Vector<String>() ;
	Vector<String> title = new Vector<String>() ;
	Vector<String> year = new Vector<String>() ;
	Vector<String> month = new Vector<String>() ;
	Vector<String> gpa = new Vector<String>() ;
	Vector<String> uni = new Vector<String>() ;
	int num = 0 ;
%>
<%
	// Connect to the postgreSQL             
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
	try {
		Class.forName("org.postgresql.Driver");

		// Open a connection to the database using DriverManager
		conn = DriverManager
				.getConnection("jdbc:postgresql://localhost:5432/Applicant?"
						+ "user=postgres&password=1234");
		Statement stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();
		Statement stmt2 = conn.createStatement();
		Statement stmt3 = conn.createStatement();

		rs = stmt
				.executeQuery("SELECT * FROM personal_info Where p_id = '"
						+ p_id + "'");
		while (rs.next()) {
			// print out the personal information of the applicant
			first_name = rs.getString(2);
			last_name = rs.getString(3);
			middle_name = rs.getString(4);
			rs_countries = stmt1
					.executeQuery("SELECT country FROM countries where c_id ='"
							+ rs.getInt(5) + "'");
			// display the residence(country) of applicant
			while (rs_countries.next()) {
				Residence = rs_countries.getString(1);
			}
			// display the citizenship(country) of applicant 
			rs_countries = stmt1
					.executeQuery("SELECT country FROM countries where c_id ='"
							+ rs.getInt(6) + "'");
			while (rs_countries.next()) {
				Citizenship = rs_countries.getString(1);
			}
			rs_spec = stmt2
					.executeQuery("SELECT specialization FROM specializations where s_id ='"
							+ rs.getInt(8) + "'");
			while (rs_spec.next()) {
				Specialization = rs_spec.getString(1);
			}
			rs_address = stmt2
					.executeQuery("SELECT * FROM address where a_id ='"
							+ rs.getInt(7) + "'");
			while (rs_address.next()) {
				street = rs_address.getString(2);
				zip = rs_address.getString(3);
				if (rs_address.getString(4) != null) {
					state = rs_address.getString(4);
				}
				areaCode  = rs_address.getString(5);
				city = rs_address.getString(6);
				if (rs_address.getString(7) != null) {
					tele = rs_address.getString(7);
				}

			}
			rs_pid = stmt2
					.executeQuery("SELECT degree FROM has_degree where personal ='"
							+ rs.getString(1) + "'");
			while (rs_pid.next()) {
				rs_degree = stmt1
						.executeQuery("SELECT * FROM degrees, personal_info where d_id='"
								+ rs_pid.getInt(1) + "'" + "AND p_id = 1");
				while (rs_degree.next()) {
					rs_uni = stmt3
							.executeQuery("SELECT university FROM universities where u_id ='"
									+ rs_degree.getInt(2) + "'");
					while (rs_uni.next()) {
						uni.add(rs_uni.getString(1));
					}
					rs_mj = stmt3
							.executeQuery("SELECT major FROM majors where m_id ='"
									+ rs_degree.getInt(3) + "'");
					while (rs_mj.next()) {
						major.add(rs_mj.getString(1));
					}
					title.add(rs_degree.getString(4));
					month.add(rs_degree.getString(5));
					year.add(rs_degree.getString(6));
					gpa.add(rs_degree.getString(7));
				}
			}
		}
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
<!-- displaying tag for showing the application of the applicant-->
<application> 
<first>First Name: <%=first_name%></first> 
<last>Last Name: <%=last_name%></last>
<middle>MI: <%=middle_name%></middle> 
<reside>Residence: <%=Residence%></reside> 
<citizen>Citizenship: <%=Citizenship%></citizen>
<spec>Specialization: <%=Specialization%></spec> 
<street>Street: <%=street%></street> 
<city>City: <%=city%></city> 
<zip>Zip: <%=zip%></zip> 
<area>Area Code: <%=areaCode%></area>
<% if (state.equals("")==false) {%> 
<state>State: <%=state%></state>
<%}%> 
<%if (tele.equals("")==false) {%> 
<tele>Telephone Code: <%=tele%></tele> 
<%}%> 
<%while (num < uni.size()) { // creating the multi tag for multi degrees%>
<major<%=num%>>Major: <%=major.elementAt(num)%></major<%=num%>> 
<title<%=num%>>Title: <%=title.elementAt(num)%></title<%=num%>>
<month<%=num%>>Month: <%=month.elementAt(num)%></month<%=num%>>
<year<%=num%>>Year : <%=year.elementAt(num)%></year<%=num%>>
<uni<%=num%>>University : <%=uni.elementAt(num)%></uni<%=num%>>
<gpa<%=num%>>GPA : <%=gpa.elementAt(num)%></gpa<%=num%>>
<% num++ ;
}%>
</application>

