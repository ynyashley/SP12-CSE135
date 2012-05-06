<%@page import="support.*,java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Application</title>
</head>
<body>
<%
	String spec = (String) request
			.getParameter("specialization_analysis");
	String major = request.getParameter("major");
	//out.println(spec) ;
%>
<%
	//session.getAttribute("specialization_analysis");
%>
<%@ page import="java.sql.*"%>

<FORM METHOD=GET ACTION="application.jsp">
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
	ResultSet rs_param = null;
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
		Statement stmt4 = conn.createStatement();

		if (spec == null && major == null) {
			rs = stmt
					.executeQuery("SELECT* FROM personal_info");
			String FullName = ""; 
			out.println("Names of Applicants: <br>");
			while (rs.next()) {
				FullName = rs.getString(2) + " "+ rs.getString(3)+" " + rs.getString(4);
				%>
				<a href="Applicant_info.jsp?p_id=<%=rs.getInt(1)%>"><%=FullName%></a> <br>
				<% 
			}
		} else {

			if (spec != null) {

				rs_param = stmt4
						.executeQuery("SELECT s_id FROM specializations where specialization = '"
								+ spec + "'");
				rs_param.next();
				rs = stmt
						.executeQuery("SELECT* FROM personal_info where spec = '"
								+ rs_param.getInt(1) + "'");

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

					rs_countries = stmt1
							.executeQuery("SELECT country FROM countries where c_id ='"
									+ rs.getInt(6) + "'");
					while (rs_countries.next()) {
						out.println("Citizenship : "
								+ rs_countries.getString(1) + " ");
					}
					out.println("<br>");
					out.println(spec + "<br>");

					rs_address = stmt2
							.executeQuery("SELECT * FROM address where a_id ='"
									+ rs.getInt(7) + "'");

					out.println("<br> Address of Applicant: <br>");

					while (rs_address.next()) {
						out.println("Street : "
								+ rs_address.getString(2));
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
				} // for while ( rs.next() )
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
		if (rs_param != null) {
			try {
				rs_param.close();
			} catch (SQLException e) {
			}
			rs_param = null;
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