<%@ page contentType="text/xml" %>
<%@page import="support.*, java.util.*"  %>
<% response.setContentType("text/xml");
	String university = (String)request.getParameter("uni");
	//ready to get the vector list of the university from universities.txt
	support s = new support();
   	
	String path2 = config.getServletContext().getRealPath("universities.txt");
   	Vector universities = s.getUniversities(path2);
   	// check if the university existed or not
	for(int i = 0; i < universities.size(); i++)
   	{
    	Vector universitiesList = (Vector)universities.get(i);
    	Vector u = (Vector)universitiesList.get(1);
    	for(int j = 0; j < u.size(); j++)
    	{
    		if(university.equals(u.get(j)))
    			// if so show the user the text that the university is existed already in the list
    		{%>
    			<application> 
				<test>University already exists. Please choose from the list above.</test>
				</application>
    		<%}
    	}
   	}
	
%>


