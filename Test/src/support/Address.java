package support;
/*
 * Class for storing Applicant's address which contain address(street), city,
 * state, country telephone code and also area code.
 */
public class Address
{
	private String address;
	private String zip;
	private String city;
	private String state;
	private String tel;
	private String areaCode;
	// empty constructor
	public Address()
	{
		this("", "", "");
		this.state = "";
		this.tel = "";
	}
	// constructor with 3 parameters (may use it later)
	public Address(String st, String zip, String city)
	{
		this.address = st;
		this.zip = zip;
		this.city = city;
	}
	
	/******* Getters ********/
	public String getAddress()
	{
		return this.address;
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
	public void setAddress (String address)
	{
		this.address = address;
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

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
}