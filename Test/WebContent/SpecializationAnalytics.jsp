<%@page import="support.*,java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Specialization Analysis</title>
</head>
<body>
<%@ page import="java.sql.*"%>
<FORM METHOD=GET ACTION="application.jsp">
<%
	// Connect to the postgreSQL             
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		// Registering Postgresql JDBC driver with the DriverManager
		Class.forName("org.postgresql.Driver");

		// Open a connection to the database using DriverManager
		conn = DriverManager
				.getConnection("jdbc:postgresql://localhost:5432/Applicant?"
						+ "user=postgres&password=1234");
		// Create the support to get the Vector of the specializations 
		support s = new support();
		String path4 = config.getServletContext().getRealPath(
				"specializations.txt");
		Vector specialization_list = s.getSpecializations(path4);
	
		// Create the statement and result, Ready for the SQL Operation 
		Statement stmt1 = conn.createStatement();
		//rs = stmt.executeQuery("SELECT specialization FROM specializations" ) ;
		int counter = 0;
		Statement stmt2 = conn.createStatement();
		// go through the specialization vector and find the corresponding name to find out 
		// how many applicants apply this Specialization.
		for (int i = 0; i < specialization_list.size(); i++) {
			
			out.println("\t" + specialization_list.elementAt(i) + "\t");
			ResultSet sp = stmt1
					.executeQuery("SELECT s_id FROM specializations WHERE specialization = '"
							+ specialization_list.elementAt(i) + "'");
			while (sp.next()) {
				counter = 0;  // set it to zero before search it in the personal_info Table
				rs = stmt2
						.executeQuery("SELECT p_id FROM personal_info WHERE spec = '"
								+ sp.getInt(1) + "'"); 
				// if the cursor doesn't point to null
				while (rs.next()) {
					counter++;
				}
			}
			// print out the count 
	%> 
	
	<a href="Application.jsp?specialization_analysis=<%=specialization_list.elementAt(i)%>"><%=counter%></a>
<br>
<%
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