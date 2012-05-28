<%@ page contentType="text/xml" %>
<%@page import="support.*, java.util.*"  %>
<% response.setContentType("text/xml");
	String university = (String)request.getParameter("uni");
	//String message = null;
	support s = new support();
   	String path2 = config.getServletContext().getRealPath("universities.txt");
   	Vector universities = s.getUniversities(path2);
   	
	for(int i = 0; i < universities.size(); i++)
   	{
    	Vector universitiesList = (Vector)universities.get(i);
    	Vector u = (Vector)universitiesList.get(1);
    	for(int j = 0; j < u.size(); j++)
    	{
    		if(university.equals(u.get(j)))
    		{%>
    			<application> 
				<test>University already exists. Please choose from the list above.</test>
				</application>
    		<%}
    	}
   	}
	
%>


