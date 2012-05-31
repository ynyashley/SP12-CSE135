<%@page import="support.*, java.util.*"%>
<html>
<head>
<title>Applicant Name</title>
</head>
<body>
	<!-- Initialize Applicant with first name, last name, middle name -->
	<p>Please enter your information:</p>
	<form name="myForm" action="Citizenship.jsp" method="POST" onsubmit="return validate()">
		First name: <input type="text" name="first" /><br /> Middle Initial:
		<input type="text" name="middle" /><br /> Last name: <input
			type="text" name="last" /> <br /> <input type="submit"
			name="action" value="submit" />
	</form>
<!-- This javascript function checking the validation of the text box: last name, first name, middle using for loop-->
<script type="text/JavaScript">
	function validate() {
		var first = document.forms["myForm"]["first"].value;
		var last = document.forms["myForm"]["last"].value;
		var middle = document.forms["myForm"]["middle"].value;
		if (first == "" || first == null) { // check if the box of first name is empty or not
			alert("Please enter your first name");
			return false;
		}
		var iChars = "*|,\":<>[]{}`\';()@&$#%/+=-_~!^&?0123456789."; //store all the special characters
		for ( var i = 0; i < first.length; i++) {
			if (iChars.indexOf(first.charAt(i)) != -1) {// checking illegal character
				alert("First name contains illegal characters!");
				return false;
			}
		}
		if (last == "" || last == null) { // check if the box of last name is empty or not
			alert("Please enter your last name");
			return false;
		}
		for ( var i = 0; i < last.length; i++) { // checking illegal character
			if (iChars.indexOf(last.charAt(i)) != -1) {
				alert("Last name contains illegal characters!");
				return false;
			}
		}
		for ( var i = 0; i < middle.length; i++) { // checking illegal character
			if (iChars.indexOf(middle.charAt(i)) != -1) {
				alert("Middle initial contains illegal characters!");
				return false;
			}
		}
		return true;
	}
</script>


</body>
</html>