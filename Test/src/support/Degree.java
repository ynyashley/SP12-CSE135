package support;
import java.lang.String;
/*
 * Class for storing Applicant's Degree information which contain location for 
 * the university, name of university, major, title, GPA/expected GPA, awarded date
 */
public class Degree 
{
	private String location;
	private String university;
	private String discipline;
	private String title;
	private String GPA ;
	private String month;
	private String year;
	// empty constructor 
	public Degree()
	{
		this.location = "";
		this.university = "";
		this.discipline = "";
	}
	// constructor with 4 parameters (may use it later)
	public Degree(String location, String university, String discipline,String title)
	{
		this.location = location;
		this.university = university;
		this.discipline = discipline;
		this.title = title;
	
	}
	/*********** GETTERS AND SETTERS ***********/
	public String getLocation()
	{
		return this.location;
	}
	public String getUniversity()
	{
		return this.university;
	}
	public String getDiscipline()
	{
		return this.discipline;
	}
	public String getTitle()
	{
		return this.title;
	}
	public String getGPA()
	{
		return this.GPA;
	}
	public String getYear()
	{
		return this.year;
	}
	public String getMonth()
	{
		return this.month;
	}
	public void setLocation(String location)
	{
		this.location = location;
	}
	public void setUniversity(String university)
	{
		this.university = university;
	}
	public void setDiscipline(String discipline)
	{
		this.discipline = discipline;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
	public void setGPA(String GPA)
	{
		this.GPA = GPA;
	}
	public void setYear(String year){
		this.year = year ;
	}
	public void setMonth(String month){
		this.month = month ;
	}
}
