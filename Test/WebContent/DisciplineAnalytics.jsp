<%@page import="support.*,java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Discipline Analysis</title>
</head>
<body>
<%@ page import="java.sql.*"%>

<FORM METHOD=GET ACTION="application.jsp">
<%
	// Connect to the postgreSQL             
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	ResultSet rs_1 = null;

	try {
		// Registering Postgresql JDBC driver with the DriverManager
		Class.forName("org.postgresql.Driver");

		// Open a connection to the database using DriverManager
		conn = DriverManager
				.getConnection("jdbc:postgresql://localhost:5432/Applicant?"
						+ "user=postgres&password=1234");
		// Create the support to get the Vector of the specializations 
		Statement stmt = conn.createStatement();
		ResultSet majors = stmt.executeQuery("SELECT * FROM majors");
		ArrayList major_list = new ArrayList();
		ArrayList m_id_list = new ArrayList();
		while (majors.next()) {
			m_id_list.add((majors.getInt(1)));
			major_list.add((majors.getString(2)));
		}

		ArrayList result_pid = new ArrayList();
		ArrayList result_mj = new ArrayList();

		// Create the statement and result, Ready for the SQL Operation 
		Statement stmt1 = conn.createStatement();
		//rs = stmt.executeQuery("SELECT specialization FROM specializations" ) ;
		int counter = 0;
		Statement stmt2 = conn.createStatement();
		Statement stmt3 = conn.createStatement();

		for (int i = 0; i < m_id_list.size(); i++) {
			out.println(major_list.get(i));
			counter = 0;
			ResultSet degree_id = stmt1
					.executeQuery("SELECT d_id from degrees where major = '"
							+ m_id_list.get(i) + "'");
			while (degree_id.next()) {
				ResultSet hd_id = stmt2
						.executeQuery("SELECT hd_id from has_degree where degree = '"
								+ degree_id.getInt(1) + "'");
				while (hd_id.next()) {
					if (result_pid.contains(hd_id.getInt(1)) == false
							&& result_mj.contains(major_list.get(i)) == false ) {
						result_pid.add(hd_id);
						result_mj.add(major_list.get(i));
						counter++;
					}
				}

			}
%> <a href="application.jsp?major=<%=major_list.get(i)%>"><%=counter%></a>
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