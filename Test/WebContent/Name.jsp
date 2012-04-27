<%@page import="support.*, java.util.*" %>
<html>
<head>
<title> Applicant Name </title>
</head>
<body>
	<!-- Initialize Applicant with first name, last name, middle name -->
	<p> Please enter your information: </p>
	<form action="Citizenship.jsp" method="POST">
	First name: <input type="text" name="first" /><br />
	Middle Initial: <input type="text" name="middle" /><br />
	Last name: <input type="text" name="last" /> <br />
	<input type = "submit" name = "action" value = "submit" />
	</form>

<%@ page import="java.sql.*"%>

<%
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            
            try {
                // Registering Postgresql JDBC driver with the DriverManager
                Class.forName("org.postgresql.Driver");

                // Open a connection to the database using DriverManager
                conn = DriverManager.getConnection(
                    "jdbc:postgresql://localhost:5432/test?" +
                    "user=postgres&password=YUNGp12594");
            %>
            
            <%-- -------- SELECT Statement Code -------- --%>
            <%
                // Create the statement
                Statement statement = conn.createStatement();

                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                rs = statement.executeQuery("SELECT * FROM students");
            %>
            
            <!-- Add an HTML table header row to format the results -->
            <table border="1">
            <tr>
                <th>ID</th>
                <th>PID</th>
                <th>First Name</th>
                <th>Middle Name</th>
                <th>Last Name</th>
            </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                // Iterate over the ResultSet
                while (rs.next()) {
            %>

            <tr>
                <%-- Get the id --%>
                <td>
                    <%=rs.getInt("id")%>
                </td>

                <%-- Get the pid --%>
                <td>
                    <%=rs.getInt("pid")%>
                </td>

                <%-- Get the first name --%>
                <td>
                    <%=rs.getString("first_name")%>
                </td>

                <%-- Get the middle name --%>
                <td>
                    <%=rs.getString("middle_name")%>
                </td>

                <%-- Get the last name --%>
                <td>
                    <%=rs.getString("last_name")%>
                </td>
            </tr>
            <%
                }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                // Close the ResultSet
                rs.close();

                // Close the Statement
                statement.close();

                // Close the Connection
                conn.close();
            } catch (SQLException e) {

                // Wrap the SQL exception in a runtime exception to propagate
                // it upwards
                throw new RuntimeException(e);
            }
            finally {
                // Release resources in a finally block in reverse-order of
                // their creation

                if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) { } // Ignore
                    rs = null;
                }
                if (pstmt != null) {
                    try {
                        pstmt.close();
                    } catch (SQLException e) { } // Ignore
                    pstmt = null;
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) { } // Ignore
                    conn = null;
                }
            }
            %>

</body>
</html>