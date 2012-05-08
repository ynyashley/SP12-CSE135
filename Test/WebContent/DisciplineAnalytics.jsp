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
		Statement stmt = conn.createStatement();
		ResultSet majors = stmt.executeQuery("SELECT * FROM majors");
		// Create two array list to store the major and its id which make the rest more 
		// convenience
		
		ArrayList major_list = new ArrayList(); 
		ArrayList m_id_list = new ArrayList();
		while (majors.next()) {
			m_id_list.add((majors.getInt(1)));
			major_list.add((majors.getString(2)));
		}

		// This ArrayList is for storing the p_id when we try to find the depulicate p_id
		ArrayList result_pid = new ArrayList();

		// Create the statement and result, Ready for the SQL Operation 
		Statement stmt1 = conn.createStatement();
		int counter = 0;
		Statement stmt2 = conn.createStatement();
		Statement stmt3 = conn.createStatement();

		for (int i = 0; i < m_id_list.size(); i++) {
			counter = 0; // reset the counter to zero
			out.println(major_list.get(i)) ; // get the name of the major
			result_pid.clear() ;// reset the result_pid arrayList
			// write the query for finding the personal (p_id) for specific major 
			ResultSet degree_id = stmt1
					.executeQuery("SELECT personal from has_degree Inner Join degrees on degrees.major = has_degree.degree where degrees.major = '"
							+ m_id_list.get(i) + "'");
			while (degree_id.next()) {
				// it might have one p_id has multi degree with same major and we count it as one. 
				// if the p_id is not found in result_pid, put p_id into result_pid 
				if (result_pid.contains(degree_id.getInt(1)) == false ) {
					result_pid.add(degree_id.getInt(1));
					counter++; // increase the counter 
				}
			}
			if ( counter ==  0 ){ // if it is zero , dont display the hyperlink
				%>
				0
				<% 
			} else {// else display the counter as hyperlink
			%> 			
			<a href="Application.jsp?major=<%=major_list.get(i)%>"><%=counter%></a>
		<br>
		<%}
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