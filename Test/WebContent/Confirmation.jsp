
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
                conn = DriverManager.getConnection(
                    "jdbc:postgresql://localhost:5432/test?" +
                    "user=postgres&password=fdctmc4u30");
                
               // Insert Applicant information
               
                
                pstmt = conn.prepareStatement("INSERT INTO student (first,last,MI,"+
  						"address,spec,residence,citizenship) VALUES (?,?,?,?,?)");
                
            }
            %>
            
<%
// Catch exception
catch (SQLException e){
	throw new RuntimeException(e);
}
finally{
	if(rs != null){
				try{ 
					rs.close();
				}catch (SQLException e){ }
				rs = null;
			}
			if(pstmt != null){
				try{
					pstmt.close();
				}catch(SQLException e){}
				pstmt = null;
			}
			if(conn != null){
				try{
					conn.close();
				}catch (SQLException e) { }
				conn = null;
			}

	}


%>



Your application has been sent.
</body>
</html>