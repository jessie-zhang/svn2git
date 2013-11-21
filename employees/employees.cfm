<cfquery name="qDepartment" datasource="employees">
SELECT
	departmentID,
	departmentName
FROM 
	department
</cfquery>

<cfparam name="form.employeeName" default="">
<cfparam name="form.departmentID" default="All">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="employees.css" rel="stylesheet" type="text/css">
<script src="javascript/jquery.js" language="javascript" type="text/javascript"></script>
<script src="javascript/jquery.tablesorter.js" language="javascript" type="text/javascript"></script>
<script src="javascript/employees.js" language="javascript" type="text/javascript"></script>
<title>Find a Gruden Employee</title>
</head>

<body>
<cfoutput>
Test	
<h1>Find a Gruden Employee</h1>
<fieldset>
	<legend>Search Form</legend>
		<form name="employeeSearch" action="employees.cfm" method="post" onsubmit="return searchEmp();">
			
		<label for="employeeName">Employee Name:</label>
		<input type="text" name="employeeName" id="employeeName" value="#form.employeeName#">
		
		<label for="departmentID">Department:</label>
		<select name="departmentID" id="departmentID">
			<option value="All">All</option>
			<cfloop query="qDepartment">
			<option value="#qDepartment.departmentID#" 
					<cfif form.departmentID EQ qDepartment.departmentID>
					selected
					</cfif>
			>#qDepartment.departmentName#</option>
			</cfloop>
		</select>
		<input type="submit" name="eSearch" value="Search">
	</form>
	
</fieldset>

<div id="searchResults">
</div>


<!--- If browser does not support AJAX, the code behind will be executed. --->
<cfif structKeyExists(form,"eSearch")>

	<cfquery name="qEmployees" datasource="employees" result="resultInfo">
	SELECT
		department.departmentID,
		department.departmentName,
		employee.firstName,
		employee.surName,
		employee.phoneExtension
	FROM
		department,
		employee
	WHERE
		department.departmentID = employee.departmentID
		<cfif form.employeeName NEQ "">
			AND employee.firstName LIKE '%#form.employeeName#%'
		</cfif>
		<cfif form.departmentID NEQ "All">
			AND employee.departmentID = #form.departmentID#
		</cfif>
	</cfquery>
	
	<h2>Search results</h2>
	<cfif resultInfo.RecordCount EQ 0>
		<p>No results found.</p>
		<cfelse>
		<p>Found #resultInfo.RecordCount# results.</p>

		<table id="empResults">
			<tr>
				<th>Name</th>
				<th>Email</th>
				<th>PhoneExtension</th>
				<th>Department</th>
			</tr>
			<cfloop query="qEmployees">
			<tr>
				<td>#qEmployees.firstName#&nbsp;#qEmployees.surName#</td>
				<td><a href="mailto:#lCase(qEmployees.firstName)#@gruden.com">#lCase(qEmployees.firstName)#@gruden.com</a></td>
				<td class="phoneExtension">#qEmployees.phoneExtension#</td>
				<td>#qEmployees.departmentName#</td>
			</tr>
			</cfloop>
		</table>
	</cfif>
</cfif>

</cfoutput>
</body>
</html>