<%@page import="support.*,java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Confirmation</title>
</head>
<body>
	<%@ page import="java.sql.*"%>

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
							+ "user=postgres&password=YUNGp12594");

			// Insert Applicant information

			// TESTING 
			Statement stmt = conn.createStatement();

			/* String first = (String)session.getAttribute("first");
			String middle = (String)session.getAttribute("middle");
			String last = (String)session.getAttribute("last");
			String citizenship = (String)session.getAttribute("citizenship");
			String residence = (String)session.getAttribute("residence");
			pstmt = conn.prepareStatement("INSERT INTO personal_info (first_name, last_name, MI,"
					+ ") VALUES (?,?,?)");
			pstmt.setString(1, first);
			pstmt.setString(2, last);
			pstmt.setString(3, middle); */
			//Get attributes from Address class
			Address a = (Address) session.getAttribute("address");
			String add = (String) a.getAddress();
			String city = (String) a.getCity();
			String zip = (String) a.getZip();
			String area = (String) a.getAreaCode();
			String state = (String) a.getState();
			String ctc = (String) a.getTel();
			Degree d = (Degree) session.getAttribute("degree");
			pstmt = conn
					.prepareStatement("INSERT INTO address (street, city, area_code,"
							+ " zip, state, tele_code) VALUES (?,?,?,?,?,?)");
			pstmt.setString(1, add);
			pstmt.setString(2, city);
			pstmt.setString(3, area);
			pstmt.setString(4, zip);

			if (session.getAttribute("residence").equals("United States")) {
				pstmt.setString(5, state);
				pstmt.setString(6, "0");

			} else {

				pstmt.setString(5, "0");
				pstmt.setString(6, ctc);
			}

			pstmt.executeUpdate();

			pstmt = conn
					.prepareStatement("INSERT INTO degrees (uni, major, title, month_award, year_award, gpa)"
							+ " VALUES (?,?,?,?,?,?)");
			String counter = (String) session.getAttribute("counter");
			ArrayList<Degree> d_array = (ArrayList<Degree>) session
					.getAttribute("degreeArray");
			int count_t = Integer.parseInt(counter);
			String l, u, t, m, G, y, mo;
			//String command_university, command_major;
			//int u_id, m_id;
			Statement stmt1 = conn.createStatement();
			Statement stmt2 = conn.createStatement();
			for (int i = 0; i < d_array.size(); i++) {
				//StringCount = Integer.toString(i+1) ;
				t = d_array.get(i).getTitle();
				pstmt.setString(3, t);
				G = d_array.get(i).getGPA();
				pstmt.setString(6, G);
				mo = d_array.get(i).getMonth();
				pstmt.setString(4, mo);
				y = d_array.get(i).getYear();
				pstmt.setString(5, y);
				ResultSet uni = stmt1
						.executeQuery("SELECT u_id FROM Universities WHERE university ='"
								+ d_array.get(i).getUniversity() + "'");
				ResultSet major = stmt2
						.executeQuery("SELECT m_id FROM Majors WHERE major ='"
								+ d_array.get(i).getDiscipline() + "'");
				pstmt.setInt(1,1);
				/*if(uni.next())
				{
					//System.err.println("klalfkjnslfjlaksjcnslkjnfsajfsd" + uni.getInt(1));
					pstmt.setInt(1, 1);
				} */
				if(major.next())
				{
					pstmt.setInt(2, major.getInt(1));
				}
			}

			/*pstmt = conn.prepareStatement("INSERT INTO universities (country_state, university)"
					+ " VALUES (?,?)");
			if (count_t > 0) {
				for (int i = 0 ; i < d_array.size(); i++ ){ 
					l = d_array.get(i).getLocation();
					u = d_array.get(i).getUniversity() ;
					pstmt.setString(1, l);
					pstmt.setString(2, u);
				}
			}
			
			pstmt.executeUpdate();
			 */
			pstmt.executeUpdate();

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

	<%
		// Catch exception
	%>



	Your application has been sent.
</body>
</html>