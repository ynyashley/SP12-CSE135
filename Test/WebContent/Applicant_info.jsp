<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Applicant_info</title>
</head>
<body>

<%@ page import="java.sql.*"%>
<% String id = (String) request.getParameter("p_id");
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
		// Registering Postgresql JDBC driver with the DriverManager
		Class.forName("org.postgresql.Driver");

		// Open a connection to the database using DriverManager
		conn = DriverManager
				.getConnection("jdbc:postgresql://localhost:5432/Applicant?"
						+ "user=postgres&password=1234");
		// Create the support to get the Vector of the specializations 
		Statement stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();
		Statement stmt2 = conn.createStatement();
		Statement stmt3 = conn.createStatement();
		
		rs = stmt.executeQuery("SELECT * FROM personal_info Where p_id = '"+ id +"'" );
		while (rs.next()) {
			out.println("First Name: " +rs.getString(2)) ;
			out.println("<br>") ;
			out.println("Last Name: " +rs.getString(3)) ;
			out.println("<br>") ; 
			out.println("MI: " +rs.getString(4));
			out.println("<br>") ;
			rs_countries = stmt1
					.executeQuery("SELECT country FROM countries where c_id ='"
							+ rs.getInt(5) + "'");
			while (rs_countries.next()) {
				out.println("Residence : " + rs_countries.getString(1) + " ");
			}
			out.println("<br>") ;
			
			rs_countries = stmt1
					.executeQuery("SELECT country FROM countries where c_id ='"
							+ rs.getInt(6) + "'");
			while (rs_countries.next()) {
				out.println("Citizenship : " + rs_countries.getString(1) + " ");
			}
			out.println("<br>") ;
			rs_spec = stmt2
					.executeQuery("SELECT specialization FROM specializations where s_id ='"
							+ rs.getInt(8) + "'");
			while (rs_spec.next()) {
				out.println("Specialization : "+rs_spec.getString(1) + " ");
			}
			rs_address = stmt2
					.executeQuery("SELECT * FROM address where a_id ='"
							+ rs.getInt(7) + "'");
%> <br>
Address of Applicant: <br>
<%
	while (rs_address.next()) {
				out.println("Street : " +rs_address.getString(2));
				out.println("<br>") ;
				out.println("Zip : " +rs_address.getString(3));
				out.println("<br>") ; 
				if (rs_address.getString(4) != null) {
					out.println("State : " +rs_address.getString(4));
				}
				out.println("Area Code : " +rs_address.getString(5));
				out.println("<br>") ;
				out.println("City : " +rs_address.getString(6));
				out.println("<br>") ;
				if (rs_address.getString(7) != null) {
					out.println("Telephone Code : " + rs_address.getString(7));
				}

			}
%> <br>
Degrees of the Applicant: <br>
<%
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
					while (rs_uni.next()){
						out.println("University : "+ rs_uni.getString(1)) ;
					}
					out.println("<br>") ;
					rs_mj = stmt3
					.executeQuery("SELECT major FROM majors where m_id ='"
							+ rs_degree.getInt(3) + "'");
					while (rs_mj.next()){
						out.println("Major : "+ rs_mj.getString(1)) ;
					} 
					out.println("<br>") ;
					out.println("Title : "+rs_degree.getString(4));
					out.println("<br>") ;
					out.println("Award Month/Year : "+ rs_degree.getString(5)
					+"/"+rs_degree.getString(6));
					out.println("<br>") ;
					out.println("GPA : "+rs_degree.getString(7));
				}
				out.println("<br>") ; 
			}
			

	} // for while ( rs.next() )
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


</body>
</html>