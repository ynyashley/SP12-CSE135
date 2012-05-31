<%@ page contentType="text/xml" %>
<%@page import="support.*, java.util.*"  %>
<% response.setContentType("text/xml");
    /*
     * Obtain the university that the user enters in the text box
     * from degree_university.jsp
     */
	String university = (String)request.getParameter("uni");
	//ready to get the vector list of the university from universities.txt
	support s = new support();
   	
	String path2 = config.getServletContext().getRealPath("universities.txt");
   	Vector universities = s.getUniversities(path2);
   	// check if the university exists or not
	for(int i = 0; i < universities.size(); i++)
   	{
    	Vector universitiesList = (Vector)universities.get(i);
    	Vector u = (Vector)universitiesList.get(1);
    	for(int j = 0; j < u.size(); j++)
    	{
    		/*
    		 * Creates tags for our error message only if the university exists so that
    		 * in degree_university we know whether we have found an error or not.
    		 */
    		if(university.equals(u.get(j)))
    		{%>
    			<application> 
				<test>University already exists. Please choose from the list above.</test>
				</application>
    		<%}
    	}
   	}
	
%>


