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
							+ "user=postgres&password=1234");

			// Insert Applicant information

			Statement stmt = conn.createStatement();

			//Get attributes from Address class
			
			Address a = (Address) session.getAttribute("address");
			String add = (String) a.getAddress();
			String city = (String) a.getCity();
			String zip = (String) a.getZip();
			String area = (String) a.getAreaCode();
			String state = (String) a.getState();
			String ctc = (String) a.getTel();
			
			// using the prepareStatement to insert the current address to the SQL table Address
			pstmt = conn
					.prepareStatement("INSERT INTO address (street, city, area_code,"
							+ " zip, state, tele_code) VALUES (?,?,?,?,?,?)");
			// SetString to SQL table
			pstmt.setString(1, add);
			pstmt.setString(2, city);
			pstmt.setString(3, area);
			pstmt.setString(4, zip);
			// if the residence is not United State, store data "state" into the SQL Table and set tele_code to 0"
			if (session.getAttribute("residence").equals("United States")) {
				pstmt.setString(5, state);
				pstmt.setString(6, "0");

			} else {
				// if the residence is not United States, save the tele code and set state to "0"
				pstmt.setString(5, "0");
				pstmt.setString(6, ctc);
			}

			pstmt.executeUpdate();
			
			// finish adding the address into the SQL table
						
			// Now Inserting the Applicant infromation to the SQL table personal_info
			
			pstmt = conn
					.prepareStatement("INSERT INTO personal_info (first_name, last_name, MI, residence,"
							+ " citizenship, address, spec) VALUES (?,?,?,?,?,?,?)");
			// Get first name, last name, mi, from Session  
			String first = (String)session.getAttribute("first") ;
			String last = (String)session.getAttribute("last") ;
			String middle = (String)session.getAttribute("middle") ;
			String citizen =(String)session.getAttribute("citizenship") ;
			String residence = (String)session.getAttribute("residence") ;
			String special = (String)session.getAttribute("specialization") ;
			
			// use pstmt to insert the data to SQL table (personal_info)
			pstmt.setString(1,first) ;
			pstmt.setString(2,last) ;
			pstmt.setString(3,middle) ;
			
			
			// creat result set and statement for selecting the country from table countries 
			Statement stmt5 = conn.createStatement();
			ResultSet resi = stmt5
			.executeQuery("SELECT c_id FROM countries WHERE country ='"
					+ residence + "'");
			resi.next();
			// insert into personal_info 
			pstmt.setInt(4,resi.getInt(1)) ;
			
			// creat result set and statement for selecting the country from table countries 
			Statement stmt6 = conn.createStatement();
			ResultSet citz = stmt6
			.executeQuery("SELECT c_id FROM countries WHERE country ='"
					+ citizen + "'");
			citz.next();
			// insert into personal_info
			pstmt.setInt(5,citz.getInt(1)) ;
			
			// creat result set and statement for selecting the country from table countries 
			Statement stmt7 = conn.createStatement();
			ResultSet address_info = stmt7
			.executeQuery("SELECT a_id FROM Address WHERE street ='"
					+ a.getAddress() + "'");
			address_info.next();
			pstmt.setInt(6,address_info.getInt(1)) ;
			
			// creat result set and statement for selecting the specialization from table specialization 
			Statement stmt8 = conn.createStatement();
			ResultSet sp = stmt8
			.executeQuery("SELECT s_id FROM specializations WHERE specialization ='"
					+ special + "'");
			sp.next();
			pstmt.setInt(7,sp.getInt(1)) ;
			
			// execute the query ()
			pstmt.executeUpdate();
			
			// Get degree from Session and start Inserting the degree to SQL table degrees
			Degree d = (Degree) session.getAttribute("degree");
			
			String counter = (String) session.getAttribute("counter");
			ArrayList<Degree> d_array = (ArrayList<Degree>) session
					.getAttribute("degreeArray");
			
			String l, u, t, m, G, y, mo;
			// create the statement for inserting the SQL table
			Statement stmt1 = conn.createStatement();
			Statement stmt2 = conn.createStatement();
			Statement stmt3 = conn.createStatement();
			Statement stmt4 = conn.createStatement();
			Statement stmt9 = conn.createStatement();
			
			
			/* REMEMBER 
			Statement must be declare out side the for loop 
			result set need to .next() before call .getInt()
			execute the query after you finish add .
			I know you can make it since I trust you =)
			*/
			
			
			for (int i = 0; i < d_array.size(); i++) {
				//StringCount = Integer.toString(i+1) ;
				pstmt = conn
					.prepareStatement("INSERT INTO degrees (uni, major, title, month_award, year_award, gpa)"
							+ ", address, spec VALUES (?,?,?,?,?,?,?,?)");
				ResultSet uni = stmt1
						.executeQuery("SELECT u_id FROM Universities WHERE university ='"
								+ d_array.get(i).getUniversity() + "'");
				// TODO: check if it is in the SQL table
				uni.next();
				
				pstmt.setInt(1,uni.getInt(1));
				
				ResultSet major = stmt2
						.executeQuery("SELECT m_id FROM Majors WHERE major ='"
								+ d_array.get(i).getDiscipline() + "'");				
				major.next();
				pstmt.setInt(2, major.getInt(1));
				
				t = d_array.get(i).getTitle();
				pstmt.setString(3, t);
				
				mo = d_array.get(i).getMonth();
				pstmt.setString(4, mo);
				y = d_array.get(i).getYear();
				pstmt.setString(5, y);
				
				G = d_array.get(i).getGPA();
				pstmt.setString(6, G);
				
				
				pstmt.executeUpdate();
			
					
				// Insert the relationship with d_id (table degrees)and p_id (table personal_info) 
				
				pstmt = conn
				.prepareStatement("INSERT INTO has_degree (degree, personal)"
						+ " VALUES (?,?)");
			
				ResultSet relation = stmt3.executeQuery("SELECT d_id FROM degrees WHERE gpa ='"
						+ d_array.get(i).getGPA() + "'");
				relation.next() ;
				
				ResultSet person = stmt4.executeQuery("SELECT p_id FROM degrees WHERE first_name ='"
						+ session.getAttribute("first") + "'");
				
				person.next() ;
				
				pstmt.setInt(1,relation.getInt(1)) ;
				pstmt.setInt(2,person.getInt(1)) ;
				pstmt.executeUpdate();
				
				
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

	<%
		// Catch exception
	%>



	Your application has been sent.
</body>
</html>