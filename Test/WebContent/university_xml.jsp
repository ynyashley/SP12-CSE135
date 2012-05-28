<%@ page contentType="text/xml"%>
<%@page import="support.*,java.util.*, java.sql.*"%>
<%
	response.setContentType("text/xml");
	String p_id = request.getParameter("id");
%>
<%
		String uni = "";
		String loc = "";
		ArrayList<Degree> d_array = (ArrayList<Degree>)session.getAttribute("degreeArray");
		String message = "adfl;ksf";
%>
	<!-- Initiate Connection to Postgres SQL Server -->
	<%
		Connection conn = null;
		ResultSet rs = null;
		int u_id;
		try 
		{
			// Registering Postgresql JDBC driver with the DriverManager
			Class.forName("org.postgresql.Driver");

			// Open a connection to the database using DriverManager
			conn = DriverManager
					.getConnection("jdbc:postgresql://localhost:5432/Applicant?"
							+ "user=postgres&password=1234");
			Statement statement = conn.createStatement();
			
            for(int i = 0; i < d_array.size(); i++)
            {
            	uni = d_array.get(i).getUniversity();
            	loc = d_array.get(i).getLocation();
            	
            	/* 
            	 * First search whether the university that the applicant has entered exists in
            	 * our database. If it doesn't, statement.executeQuery() should throw an exception
            	 * and our catch block will catch that exception and we will add that university
            	 * into our Universities table.
            	 */
            	try
            	{
        			rs = statement.executeQuery("SELECT Universities.university FROM Universities WHERE university='"+ uni + "'" +
        					                   "AND country_state= '" + loc + "'");
        			if(!rs.next())
            		{
            			throw new SQLException();
            		}
        			message = "University already exists in the database";
        			
            	}
            	/*
            	 * At this point, we know that the university that the applicant has entered does not
            	 * exist in our database and thus we want to insert this university into our
            	 * Universities table.
            	 */
            	catch(SQLException e)
            	{
            		message = "University does not exist in the database";
            	}
                	 /*
                 	 * At this point, we know that the major that the applicant has entered does not
                 	 * exist in our database and thus we want to insert this major into our
                 	 * Majors table.
                 	 */
            }
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

<application>
<message><%=message%></message>
</application>