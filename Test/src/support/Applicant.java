package support;

import java.lang.String;

public class Applicant 
{
	private String firstName;
	private String lastName;
	private String middleName;
	
	private String citizenship;
	private String residency;
	private boolean international;
	
	/********* Constructors **********/
	public Applicant()
	{
		this("", "", "");
		setCitizenship ("");
		setResidency("");
	}
	
	public Applicant(String first, String last, String middle)
	{
		setFirstName(first);
		setLastName(last);
		setMiddleName(middle);
	}
	
	
	/******* Getters and Setters *******/
	public String getFirstName()
	{
		return this.firstName;
	}
	
	public String getLastName()
	{
		return this.lastName;
	}
	
	public String getMiddleName()
	{
		return this.middleName;
	}
	
	public String getCitizenship()
	{
		return this.citizenship;
	}
	
	public String getResidency()
	{
		return this.residency;
	}
	
	public boolean getInternational()
	{
		return this.international;
	}
	
	public void setFirstName(String first)
	{
		this.firstName = first;
	}
	
	public void setLastName(String last)
	{
		this.lastName = last;
	}
	
	public void setMiddleName(String middle)
	{
		this.middleName = middle;
	}
	
	public void setCitizenship(String citizenship)
	{
		this.citizenship = citizenship;
	}
	
	public void setInternational(boolean international)
	{
		this.international = international;
	}
	
	public void setResidency(String residency)
	{
		this.residency = residency;
	}
	/***************** BEGINS ADDRESS INNER CLASS ************************/
	public class Address
	{
		private String street;
		private String zip;
		private String city;
		private String state;
		private String tel;
		
		public Address()
		{
			this("", "", "");
		}
		
		public Address(String st, String zip, String city)
		{
			this.street = st;
			this.zip = zip;
			this.city = city;
		}
		
		/******* Getters ********/
		public String getStreet()
		{
			return this.street;
		}
		
		public String getZip()
		{
			return this.zip;
		}
		
		public String getCity()
		{
			return this.city;
		}
		
		public String getState()
		{
			return this.state;
		}
		
		public String getTel()
		{
			return this.tel;
		}
		
		/******** SETTERS *********/
		public void setStreet (String street)
		{
			this.street = street;
		}
		public void setZip (String zip)
		{
			this.zip = zip;
		}
		public void setState (String state)
		{
			this.state = state;
		}
		public void setCity (String city)
		{
			this.city = city ;
		}
		public void setTel (String tel)
		{
			this.tel = tel;
		}
	}
	/********************BEGINS INNER CLASS DEGREE **********************/
	public class Degree
	{
		private String gpa;
		private String major;
		private String schoolLocation;
		private String university;
		private String specialization;
		private String degree;  /* BS/MS/PhD */
		
		public Degree()
		{
			setGPA("");
			setMajor("");
			setSchoolLocation("");
			setUniversity("");
			setSpecialization("");
			setDegree("");
		}
		/******* GETTERS AND SETTERS *******/
		public String getGPA()
		{
			return this.gpa;
		}
		public String getMajor()
		{
			return this.major;
		}
		public String getSchoolLocation()
		{
			return this.schoolLocation;
		}
		public String getUniversity()
		{
			return this.university;
		}
		public String getSpecialization()
		{
			return this.specialization;
		}
		public String getDegree()
		{
			return this.degree;
		}
		
		public void setGPA(String gpa)
		{
			this.gpa = gpa;
		}
		public void setMajor(String major)
		{
			this.major = major;
		}
		public void setSchoolLocation(String schoolLocation)
		{
			this.schoolLocation = schoolLocation;
		}
		public void setUniversity(String university)
		{
			this.university = university;
		}
		public void setSpecialization(String specialization)
		{
			this.specialization = specialization;
		}
		public void setDegree(String degree)
		{
			this.degree = degree;
		}
	}
}
