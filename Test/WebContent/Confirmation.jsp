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
	%>
	<!-- Initiate Connection to Postgres SQL Server -->
	<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		int p_id, u_id, m_id;
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
            pstmt.executeUpdate();
    		ArrayList<Degree> d_array = (ArrayList<Degree>)session.getAttribute("degreeArray");
    		
    		
    		// insert degree SQL begin
    		pstmt = conn
            		.prepareStatement("INSERT INTO degrees (uni, major, title, month_award, year_award, gpa)" 
                                           +" VALUES (?, ?, ?, ?, ?, ?) returning d_id");
    		// end
            for(int i = 0; i < d_array.size(); i++)
            {
            	uni = d_array.get(i).getUniversity();
            	major = d_array.get(i).getDiscipline();
            	title = d_array.get(i).getTitle();
            	month = d_array.get(i).getMonth();
            	year = d_array.get(i).getYear();
            	gpa = d_array.get(i).getGPA();
            	loc = d_array.get(i).getLocation();
            	
            	try
            	{
        			rs = statement.executeQuery("SELECT u_id FROM Universities WHERE university='"+ uni + "'" +
        					                   "AND country_state= '" + loc + "'");
        			if(!rs.next())
            		{
            			throw new SQLException();
            		}
            		pstmt.setInt(1, rs.getInt("u_id"));
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
    					d_id.add(rs.getInt("d_id"));
					}
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
    					d_id.add(rs.getInt("d_id"));
					}
            	}
            	catch(SQLException e)
            	{
            		pstmt2 = conn.prepareStatement("INSERT INTO universities (university, country_state)"
            	                                 + "VALUES (?, ?) returning u_id");
            		pstmt2.setString(1, uni);
            		pstmt2.setString(2, loc);
            		rs = pstmt2.executeQuery();
            		rs.next();
            		u_id =  rs.getInt("u_id");
            		pstmt.setInt(1, u_id);
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
    					d_id.add(rs.getInt("d_id"));
            		}
            		catch(SQLException e1)
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
    					d_id.add(rs.getInt("d_id"));
            		}
            	}
            }
           
            /* Inserting into personal_info table */
            
    		pstmt = conn
            		.prepareStatement("INSERT INTO personal_info (first_name, last_name, MI, residence, citizenship, address, spec)" 
                                           +" VALUES (?, ?, ?, ?, ?, ?, ?) returning p_id");
    		
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
    		rs = pstmt.executeQuery();
    		rs.next();
    		p_id =  rs.getInt("p_id"); 
    		         
            pstmt = conn.prepareStatement("INSERT INTO has_degree (personal_id, degree) VALUES (?, ?)");
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