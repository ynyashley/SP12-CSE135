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
		String uni, major, title, month, year, gpa, loc;
		ArrayList<Degree> d_array = (ArrayList<Degree>)session.getAttribute("degreeArray");
	%>
	<!-- Initiate Connection to Postgres SQL Server -->
	<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		int p_id, u_id, m_id, a_id;
		ArrayList <Integer> d_id = new ArrayList <Integer>();
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

            // Create the prepared statement and use it to INSERT Address values INTO the Address table
            pstmt = conn.prepareStatement("INSERT INTO Address (street, zip, state, area_code, city, tel_code)" 
                               		     +" VALUES (?, ?, ?, ?, ?, ?) returning a_id");
			//Begin inserting information that we have gotten from previous pages into the Address table
            pstmt.setString(1, add);
            pstmt.setString(2, zip);
            /* 
             * If the applicant lives in the United State, we insert state into the Address table,
             * otherwise we insert null into the state field and populate the country telephone
             * code field into the Address table instead.
             */
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
            rs = pstmt.executeQuery();
			rs.next();
			/*
			 * Retrieve the Address ID so we can insert it into our personal_info table
			 * later on
			 */
            a_id = rs.getInt("a_id");
    		
            
          	//Begin inserting information that we have gotten from previous pages into the Degrees table
    		pstmt = conn.prepareStatement("INSERT INTO degrees (uni, major, title, month_award, year_award, gpa)" 
                                           +" VALUES (?, ?, ?, ?, ?, ?) returning d_id");
          	
          	/*
          	 * Insert all the degrees that the applicant has declared into the Degrees table
          	 * one by one by looping through the ArrayList of degrees that we have previously
          	 * populated.
          	 */
            for(int i = 0; i < d_array.size(); i++)
            {
            	uni = d_array.get(i).getUniversity();
            	major = d_array.get(i).getDiscipline();
            	title = d_array.get(i).getTitle();
            	month = d_array.get(i).getMonth();
            	year = d_array.get(i).getYear();
            	gpa = d_array.get(i).getGPA();
            	loc = d_array.get(i).getLocation();
            	
            	/* 
            	 * First search whether the university that the applicant has entered exists in
            	 * our database. If it doesn't, statement.executeQuery() should throw an exception
            	 * and our catch block will catch that exception and we will add that university
            	 * into our Universities table.
            	 */
            	try
            	{
        			rs = statement.executeQuery("SELECT u_id FROM Universities WHERE university='"+ uni + "'" +
        					                   "AND country_state= '" + loc + "'");
        			if(!rs.next())
            		{
            			throw new SQLException();
            		}
        			/*
        			 * The applicant has selected/entered a university that already exists in
        			 * our database and thus we just directly add the appropriate university
        			 * ID into our Degrees table.
        			 */
            		pstmt.setInt(1, rs.getInt("u_id"));
            		/* 
                	 * Search again to see whether the major that the applicant has entered exists in
                	 * our database. If it doesn't, statement.executeQuery() should throw an exception
                	 * and our catch block will catch that exception and we will add that major
                	 * into our Majors table.
                	 */
					try
					{
						rs = statement.executeQuery("SELECT m_id FROM Majors WHERE major='"+ major + "'");
            			if(!rs.next())
						{
        					throw new SQLException();
						}
            			pstmt.setInt(2, rs.getInt("m_id"));
            			pstmt.setString(3, title);
        				pstmt.setString(4, month);
        				pstmt.setString(5, year);
        				pstmt.setString(6, gpa);
        				rs = pstmt.executeQuery();
    					rs.next();
    					/*
    					 * Insert the Degree id that is returned into the d_id array so we can insert
    					 * the those IDs into our personal_info table later on.
    					 */
    					d_id.add(rs.getInt("d_id"));
					}
                	/*
                	 * At this point, we know that the major that the applicant has entered does not
                	 * exist in our database and thus we want to insert this major into our Majors table.
                	 */
					catch(SQLException e)
					{
						pstmt2 = conn.prepareStatement("INSERT INTO Majors (major) Values (?) returning m_id");
						pstmt2.setString(1, major);
						rs = pstmt2.executeQuery();
						rs.next();
						m_id = rs.getInt("m_id");
						pstmt.setInt(2, m_id);
            			pstmt.setString(3, title);
        				pstmt.setString(4, month);
        				pstmt.setString(5, year);
        				pstmt.setString(6, gpa);
        				rs = pstmt.executeQuery();
    					rs.next();
    					/*
    					 * Insert the Degree id that is returned into the d_id array so we can insert
    					 * the those IDs into our personal_info table later on.
    					 */
    					d_id.add(rs.getInt("d_id"));
					}
            	}
            	/*
            	 * At this point, we know that the university that the applicant has entered does not
            	 * exist in our database and thus we want to insert this university into our
            	 * Universities table.
            	 */
            	catch(SQLException e)
            	{
            		pstmt2 = conn.prepareStatement("INSERT INTO universities (university, country_state)"
            	                                 + "VALUES (?, ?) returning u_id");
            		pstmt2.setString(1, uni);
            		pstmt2.setString(2, loc);
            		rs = pstmt2.executeQuery();
            		rs.next();
            		u_id =  rs.getInt("u_id");
            		/*
            		 * After inserting the university into the Universities table, we retrieved the 
            		 * university ID (u_id) and then add that into our Degrees table.
            		 */
            		pstmt.setInt(1, u_id);
            		/* 
                	 * Search again to see whether the major that the applicant has entered exists in
                	 * our database. If it doesn't, statement.executeQuery() should throw an exception
                	 * and our catch block will catch that exception and we will add that major
                	 * into our Majors table.
                	 */
            		try
            		{
            			rs = statement.executeQuery("SELECT m_id FROM Majors WHERE major='"+ major + "'");
						if(!rs.next())
						{
        					throw new SQLException();
						}
						/*
	        			 * The applicant has selected/entered a major that already exists in
	        			 * our database and thus we just directly add the appropriate major
	        			 * ID into our Degrees table.
	        			 */
						pstmt.setInt(2, rs.getInt("m_id"));
        				pstmt.setString(3, title);
        				pstmt.setString(4, month);
        				pstmt.setString(5, year);
        				pstmt.setString(6, gpa);
        				rs = pstmt.executeQuery();
    					rs.next();
    					/*
    					 * Insert the Degree id that is returned into the d_id array so we can insert
    					 * the those IDs into our personal_info table later on.
    					 */
    					d_id.add(rs.getInt("d_id"));
            		}
                	 /*
                 	 * At this point, we know that the major that the applicant has entered does not
                 	 * exist in our database and thus we want to insert this major into our
                 	 * Majors table.
                 	 */
            		catch(SQLException e1)
            		{
            			pstmt2 = conn.prepareStatement("INSERT INTO Majors (major) Values (?) returning m_id");
						pstmt2.setString(1, major);
						rs = pstmt2.executeQuery();
						rs.next();
						m_id = rs.getInt("m_id");
						/*
	            		 * After inserting the major into the Majors table, we retrieved the major ID
	            		 * (m_id) and then add that into our Degrees table.
	            		 */
						pstmt.setInt(2, m_id);
            			pstmt.setString(3, title);
        				pstmt.setString(4, month);
        				pstmt.setString(5, year);
        				pstmt.setString(6, gpa);
        				rs = pstmt.executeQuery();
    					rs.next();
    					/*
    					 * Insert the Degree id that is returned into the d_id array so we can insert
    					 * the those IDs into our personal_info table later on.
    					 */
    					d_id.add(rs.getInt("d_id"));
            		}
            	}
            }
           
            //Inserting into personal_info table
    		pstmt = conn
            		.prepareStatement("INSERT INTO personal_info (first_name, last_name, MI, residence, citizenship, address, spec)" 
                                           +" VALUES (?, ?, ?, ?, ?, ?, ?) returning p_id");
    		
    		pstmt.setString(1, first);
    		pstmt.setString(2, last);
    		pstmt.setString(3, middle);
    		/*
    		 * Retrieve the country ID and then insert that into our personal_info 
    		 * table as a foreign key to residence.
    		 */
    		rs = statement.executeQuery("SELECT c_id FROM Countries WHERE country='"+ residence + "'");
    		rs.next();
    		pstmt.setInt(4, rs.getInt("c_id"));
    		/* 
    		 * Retrieve the country ID and then insert that into our personal_info 
    		 * table as a foreign key to citizenship.
    		 */
    		rs = statement.executeQuery("SELECT c_id FROM Countries WHERE country='"+ citizenship + "'");
    		rs.next();
    		pstmt.setInt(5, rs.getInt("c_id"));
    		/*
    		 * Insert the Address ID that we obtained earlier into our personal_info
    		 * table as a foreign key to the Address table.
    		 */
    		pstmt.setInt(6, a_id);
    		/* 
    		 * Retrieve the Specialization ID and then insert that into our personal_info 
    		 * table as a foreign key to specialization.
    		 */
    		rs = statement.executeQuery("SELECT s_id FROM Specializations WHERE specialization='"+ specialization + "'");
    		rs.next();
    		pstmt.setInt(7, rs.getInt("s_id"));
    		rs = pstmt.executeQuery();
    		rs.next();
    		/*
			 * Obtain the personal_info table key so we can use that as a foreign key to our
			 * has_degree table later on.
			 */
    		p_id =  rs.getInt("p_id"); 
    		
    		//Inserting into has_degree table
            pstmt = conn.prepareStatement("INSERT INTO has_degree (personal, degree) VALUES (?, ?)");
    		/*
    		 * With the d_id ArrayList that we have populated earlier, we can insert the p_id into
    		 * our has_degree table so we can match up the applicant and the all the degrees that
    		 * he or she has.
    		 */
            for(int i = 0; i < d_id.size(); i++)
            {
            	pstmt.setInt(1, p_id);
            	pstmt.setInt(2, d_id.get(i));
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
	Your application has been successfully sent. Your application ID is <%=p_id %>.
</body>
</html>