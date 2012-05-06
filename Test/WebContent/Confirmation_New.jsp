<%@page import="support.*,java.util.*, java.sql.*"%>
<html>
<head>
<title>Confirmation Page</title>
</head>
<body>
	<!-- Obtain the objects/info that we have initiated in the previous pages -->
	<%
		String first = (String)session.getAttribute("first");
		String middle = (String)session.getAttribute("middle");
		String last = (String)session.getAttribute("last");
		String citizenship = (String)session.getAttribute("citizenship");
		Address a = (Address)session.getAttribute("address");
		String add = (String)a.getAddress();
		String city = (String)a.getCity();
		String zip = (String)a.getZip();
		String area = (String)a.getAreaCode();
		String state = (String)a.getState();
		String ctc = (String)a.getTel();
		String residence = (String)session.getAttribute("residence");
		String specialization = (String)session.getAttribute("specialization"); 
		String uni, major, title, month, year, gpa;
	%>
	<!-- Initiate Connection to Postgres SQL Server -->
	<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int student_id ;
		int degree_id ;
		try 
		{
			// Registering Postgresql JDBC driver with the DriverManager
			Class.forName("org.postgresql.Driver");

			// Open a connection to the database using DriverManager
			conn = DriverManager
					.getConnection("jdbc:postgresql://localhost:5432/Applicant?"
							+ "user=postgres&password=1234");
			Statement statement = conn.createStatement();
			
			// Begin transaction
            conn.setAutoCommit(false);

            // Create the prepared statement and use it to
            // INSERT student values INTO the students table.
            pstmt = conn
            .prepareStatement("INSERT INTO Address (street, zip, state, area_code, city, tel_code)" 
                               +" VALUES (?, ?, ?, ?, ?, ?)");

            pstmt.setString(1, add);
            pstmt.setString(2, zip);
            if(residence.equals("United States"))
            {
            	pstmt.setString(3, state);
            }
            else
            {
            	pstmt.setString(3, null);
            }
            pstmt.setString(4, area);
            pstmt.setString(5, city);
            if(residence.equals("United States"))
            {
            	pstmt.setString(6, null);
            }
            else
            {
            	pstmt.setString(6, ctc);
            }
            int rowCount = pstmt.executeUpdate();
    		ArrayList<Degree> d_array = (ArrayList<Degree>)session.getAttribute("degreeArray");
    		
    		
    		// insert degree SQL begin
    		pstmt = conn
            		.prepareStatement("INSERT INTO degrees (uni, major, title, month_award, year_award, gpa)" 
                                           +" VALUES (?, ?, ?, ?, ?, ?)");
    		// end
            for(int i = 0; i < d_array.size(); i++)
            {
            	uni = d_array.get(i).getUniversity();
            	major = d_array.get(i).getDiscipline();
            	title = d_array.get(i).getTitle();
            	month = d_array.get(i).getMonth();
            	year = d_array.get(i).getYear();
            	gpa = d_array.get(i).getGPA();
            	

        		rs = statement.executeQuery("SELECT u_id FROM Universities WHERE university='"+ uni + "'");
            	while(rs.next())
            	{
            		pstmt.setInt(1, rs.getInt("u_id"));
            
            	}
				rs = statement.executeQuery("SELECT m_id FROM Majors WHERE major='"+ major + "'");
				while(rs.next())
				{
        			pstmt.setInt(2, rs.getInt("m_id"));
				}
        		pstmt.setString(3, title);
        		pstmt.setString(4, month);
        		pstmt.setString(5, year);
        		pstmt.setString(6, gpa);
            	pstmt.executeUpdate();
            }
           
            /* Inserting into personal_info table */
            
    		pstmt = conn
            		.prepareStatement("INSERT INTO personal_info (first_name, last_name, MI, residence, citizenship, address, spec)" 
                                           +" VALUES (?, ?, ?, ?, ?, ?, ?)");
    		
    		pstmt.setString(1, first);
    		pstmt.setString(2, last);
    		pstmt.setString(3, middle);
    		
    		rs = statement.executeQuery("SELECT c_id FROM Countries WHERE country='"+ residence + "'");
    		rs.next();
    		pstmt.setInt(4, rs.getInt("c_id"));
    		rs = statement.executeQuery("SELECT c_id FROM Countries WHERE country='"+ citizenship + "'");
    		rs.next();
    		pstmt.setInt(5, rs.getInt("c_id"));
    		if(residence.equals("United States"))
    		{
    			rs = statement.executeQuery("SELECT a_id FROM Address WHERE street='" + add + "'" +
    										"AND zip = '" + zip + "'" +
    										"AND state = '" + state + "'" +
    										"AND area_code = '" + area + "'" +
    										"AND city = '" + city + "'");
    			rs.next();
    			pstmt.setInt(6, rs.getInt("a_id"));
    		}
    		else
    		{
    			rs = statement.executeQuery("SELECT a_id FROM Address WHERE street='" + add + "'" +
						"AND zip = '" + zip + "'" +
						"AND city = '" + city + "'" +
						"AND area_code = '" + area + "'" +
						"AND tel_code = '" + ctc + "'");
				rs.next();
				pstmt.setInt(6, rs.getInt("a_id"));
    		}
    		
    		rs = statement.executeQuery("SELECT s_id FROM Specializations WHERE specialization='"+ specialization + "'");
    		rs.next();
    		pstmt.setInt(7, rs.getInt("s_id"));
    		pstmt.executeUpdate();
    		
            rs = statement.executeQuery("SELECT p_id FROM personal_info where first_name = '" + first +"'" +
            		"AND last_name ='"+last+"'" +
            		"AND mi ='"+middle + "'") ;
            rs.next() ;
            student_id = rs.getInt("p_id") ;
            
            
            pstmt = conn
            		.prepareStatement("INSERT INTO has_degree (personal, degree)" 
                                           +" VALUES (?, ?)");
            for(int i = 0; i < d_array.size(); i++)
            {
            	uni = d_array.get(i).getUniversity();
            	major = d_array.get(i).getDiscipline();
            	title = d_array.get(i).getTitle();
            	month = d_array.get(i).getMonth();
            	year = d_array.get(i).getYear();
            	gpa = d_array.get(i).getGPA();
            	

            	rs = statement.executeQuery("SELECT p_id FROM personal_info where first_name = '" + first +"'" +
                 		"AND last_name ='"+last+"'" +
                 		"AND mi ='"+middle + "'") ;
            	while(rs.next())
            	{
            		pstmt.setInt(1, rs.getInt("p_id"));
            
            	}
            	rs = statement.executeQuery("SELECT d_id FROM degrees where gpa='" + gpa +"'" +
                  		"AND title ='"+title+"'" +
                  		"AND month_award ='"+ month + "'" + 
                  		"AND year_award ='"+ year +"'") ;
				while(rs.next())
				{
					pstmt.setInt(2, rs.getInt("d_id"));
				}
            	pstmt.executeUpdate();
            }
            
    		// Commit transaction 
            conn.commit();
            conn.setAutoCommit(true);
			// Close the ResultSet
			
			rs.close();

			// Close the Statement
			statement.close();

			// Close the Connection
			conn.close();
		} 
		catch (SQLException e) 
		{
			// Wrap the SQL exception in a runtime exception to propagate it upwards
			throw new RuntimeException(e);
		} 
		finally 
		{
			// Release resources in a finally block in reverse-order of
			// their creation
			if (rs != null) 
			{
				try 
				{
					rs.close();
				} 
				catch (SQLException e) {} // Ignore
				rs = null;
			}
			if (pstmt != null) 
			{
				try {
					pstmt.close();
				} 
				catch (SQLException e) {} // Ignore
				pstmt = null;
			}
			if (conn != null) 
			{
				try {
					conn.close();
				} 
				catch (SQLException e) {} // Ignore
				conn = null;
			}
		}
	%>
	Your application has been successfully sent. Your application ID is <%=student_id %>.
</body>
</html>