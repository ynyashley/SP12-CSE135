<html>
<head>
<script type="text/javascript">
	function showapp(str) {
		var xmlHttp;
		var clicked = false;
		alert(str);
		xmlHttp = new XMLHttpRequest();
		if (xmlHttp == null) {
			alert("Your browser does not support AJAX!");
			return;
		}
		var url = "application_xml.jsp";
		url = url + "?id=" + str;
		url = url + "&sid=" + Math.random();
		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4) {
				var xmlDoc = xmlHttp.responseXML.documentElement;
				alert('ready');
				clicked = true;
				document.getElementById("first").innerHTML= xmlDoc.getElementsByTagName("first")[0].childNodes[0].nodeValue;
				document.getElementById("last").innerHTML= xmlDoc.getElementsByTagName("last")[0].childNodes[0].nodeValue;
				document.getElementById("middle").innerHTML= xmlDoc.getElementsByTagName("middle")[0].childNodes[0].nodeValue;
				document.getElementById("reside").innerHTML= xmlDoc.getElementsByTagName("reside")[0].childNodes[0].nodeValue;
				document.getElementById("citizen").innerHTML= xmlDoc.getElementsByTagName("citizen")[0].childNodes[0].nodeValue;
				document.getElementById("spec").innerHTML= xmlDoc.getElementsByTagName("spec")[0].childNodes[0].nodeValue;
				document.getElementById("street").innerHTML= xmlDoc.getElementsByTagName("street")[0].childNodes[0].nodeValue;
				document.getElementById("city").innerHTML= xmlDoc.getElementsByTagName("city")[0].childNodes[0].nodeValue;
				document.getElementById("zip").innerHTML= xmlDoc.getElementsByTagName("zip")[0].childNodes[0].nodeValue;
				if(xmlDoc.getElementsByTagName("state")[0].childNodes[0] == null)
				{
					document.getElementById("tele").innerHTML= xmlDoc.getElementsByTagName("tele")[0].childNodes[0].nodeValue;
				}
				else
				{
					document.getElementById("state").innerHTML= xmlDoc.getElementsByTagName("state")[0].childNodes[0].nodeValue;
				}
				document.getElementById("major").innerHTML= xmlDoc.getElementsByTagName("major")[0].childNodes[0].nodeValue;
				document.getElementById("title").innerHTML= xmlDoc.getElementsByTagName("title")[0].childNodes[0].nodeValue;
				document.getElementById("uni").innerHTML= xmlDoc.getElementsByTagName("uni")[0].childNodes[0].nodeValue;
				document.getElementById("month").innerHTML= xmlDoc.getElementsByTagName("month")[0].childNodes[0].nodeValue;
				document.getElementById("year").innerHTML= xmlDoc.getElementsByTagName("year")[0].childNodes[0].nodeValue;
				alert("Done");
			}
		}
		xmlHttp.open("GET", url, true);
		xmlHttp.send();
	}
	function hideapp(str)
	{
		var xmlHttp;
		alert(str);
		xmlHttp = new XMLHttpRequest();
		if (xmlHttp == null) {
			alert("Your browser does not support AJAX!");
			return;
		}
		var url = "blank.jsp";
		url = url + "?id=" + str;
		url = url + "&sid=" + Math.random();
		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4) {
				var xmlDoc = xmlHttp.responseXML.documentElement;
				alert('ready');
				document.getElementById("first").innerHTML= "";
				document.getElementById("last").innerHTML= "";
				document.getElementById("middle").innerHTML= "";
				document.getElementById("reside").innerHTML= "";
				document.getElementById("citizen").innerHTML= "";
				document.getElementById("spec").innerHTML= "";
				document.getElementById("street").innerHTML= "";
				document.getElementById("city").innerHTML= "";
				document.getElementById("zip").innerHTML= "";
				if(xmlDoc.getElementsByTagName("state")[0].childNodes[0] == null)
				{
					document.getElementById("tele").innerHTML= "";
				}
				else
				{
					document.getElementById("state").innerHTML= "";
				}
				document.getElementById("major").innerHTML= xmlDoc.getElementsByTagName("major")[0].childNodes[0].nodeValue;
				document.getElementById("title").innerHTML= xmlDoc.getElementsByTagName("title")[0].childNodes[0].nodeValue;
				document.getElementById("uni").innerHTML= xmlDoc.getElementsByTagName("uni")[0].childNodes[0].nodeValue;
				document.getElementById("month").innerHTML= xmlDoc.getElementsByTagName("month")[0].childNodes[0].nodeValue;
				document.getElementById("year").innerHTML= xmlDoc.getElementsByTagName("year")[0].childNodes[0].nodeValue;
				alert("Done");
			}
		}
		xmlHttp.open("GET", url, false);
		xmlHttp.send(null);
	}
	
	function GetXmlHttpObject() {
		var xmlHttp = null;
		try {
			// Firefox, Opera 8.0+, Safari
			xmlHttp = new XMLHttpRequest();
		} catch (e) {
			// Internet Explorer
			try {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		return xmlHttp;
	}
</script>

</head>

<body>
<table>
<%
for(int i = 1; i <= 3 ; i++)
{
out.println("<tr>");
out.println("<td>"+"<input type=\"button\"" + " value=\"Show Application " + i + "\"" 
		    + " onclick=\"showapp(" + Integer.toString(i) + ")\"/></td>");


out.println("</tr>");

}
%>
</table>
<br>
<span id="application"></span><br>

<span id="first"></span><br>
<span id="last"></span><br>
<span id="middle"></span><br>
<span id="reside"></span><br>
<span id="citizen"></span><br>
<span id="spec"></span><br>
<span id="street"></span><br>
<span id="city"></span><br>
<span id="zip"></span><br>
<span id="state"></span>
<span id ="tele"></span><br>
<span id ="major"></span><br>
<span id ="year"></span><br>
<span id ="month"></span><br>
<span id ="uni"></span><br>
<span id = "title"></span>
</body>
</html>
