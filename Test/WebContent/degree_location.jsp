<%@page import="support.*, java.util.*"  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
First Name: <%=session.getAttribute("first") %> </br >
Middle Initial: <%=session.getAttribute("middle") %> </br>
Last Name: <%=session.getAttribute("last") %> </br>
Citizenship: <%=session.getAttribute("citizenship") %> </br>
Country of Residence: <%=session.getAttribute("residence")%> </br>
<% 
	String address = request.getParameter("address"); 
	String city = request.getParameter("city");
	String zip = request.getParameter("zip");
	String areaCode = request.getParameter("areaCode");
	String ctc = null;
	String state1 = null;
	if(request.getParameter("state") == null)
	{
		ctc = request.getParameter("countryTelCode");
	}
	else
	{
		state1 = request.getParameter("state");
	}
%>
Address: <%=address %> <br>
City: <%=city %> <br>
Zip: <%=zip %> <br>
Area code: <%=areaCode %> <br>
<% if(ctc != null){ %>
Country Tel Code: <%=ctc %>
<%} 
else{ %>
State: <%=state1 %>
<%} %>


<body>
 <% 
   	support s = new support();   	
   	
   	String path1 = config.getServletContext().getRealPath("universities.txt");
	
    //getCountries returns a vector of the countries to be used for choosing university
    Vector universities = s.getUniversities(path1); 
  %>  	
   <%
    for (int i=0; i<universities.size(); i++){
      //each entry in the universities vector is a tuple with the first entry being the country/state
      //and the second entry being a vector of the universities as String's
      Vector tuple = (Vector)universities.get(i);
      String state = (String)tuple.get(0);
      out.println("<br>"+state+"<br>");    
            Vector u = (Vector)tuple.get(1);
            for(int j=0; j<u.size(); j++){%>
              <%=u.get(j)%><br>
          <%}
    } 
    
  %>
</body>
</html>