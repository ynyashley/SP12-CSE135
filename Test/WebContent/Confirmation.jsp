<%@page import="support.*, java.util.*"  %>
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
                    "jdbc:postgresql://localhost/Applicant?" +
                    "user=postgres&password=1234");
                
               // Insert Applicant information
               
                // TESTING 
                Statement stmt = conn.createStatement();
                
                Address a = (Address)session.getAttribute("address");
                String add = (String)a.getAddress();
                String city = (String)a.getCity();
                String zip = (String)a.getZip();
                String area = (String)a.getAreaCode();
                String state = (String)a.getState();
                String ctc = (String)a.getTel();
                Degree d = (Degree)session.getAttribute("degree");
    			pstmt = conn.prepareStatement("INSERT INTO address (street, city, area_code,"
    					+ " zip, state) VALUES (?,?,?,?,?)");
       	        pstmt.setString(1, add);
        	    pstmt.setString(2, city);
    			pstmt.setString(3, area);
    			pstmt.setString(4, zip);
    			
    			if(session.getAttribute("residence").equals("United States")) {
    				pstmt.setString(5,state);
    				//pstmt.setString(6,"0");

    			} else {
    				
    				//pstmt.setString(5, "0");
    				pstmt.setString(6, ctc);
    			}
    			pstmt = conn.prepareStatement("INSERT INTO degrees (title, year_award, gpa)"
    					+ " VALUES (?,?,?)");
    			String counter = (String)session.getAttribute("counter");
    			ArrayList<Degree> d_array = (ArrayList<Degree>)session.getAttribute("degreeArray") ;
    			int count_t = Integer.parseInt(counter);
    			String l, u, t, m, G, y, mo;
    			if (count_t > 0) {
    				for (int i = 0 ; i < d_array.size(); i++ ){ 
    					//StringCount = Integer.toString(i+1) ;
    					t = d_array.get(i).getTitle();
    					pstmt.setString(1,t);
    					G = d_array.get(i).getGPA();
    					pstmt.setString(3,G);
    					//still need to insert month
    					mo = d_array.get(i).getMonth();
    					y = d_array.get(i).getYear();
    					pstmt.setString(2,y);
    				}
    			}
    			pstmt = conn.prepareStatement("INSERT INTO universities (country_state, university)"
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
            

                
                
                
                
            }catch (SQLException e){
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
            
<%
// Catch exception
    
%>



Your application has been sent.
</body>
</html>