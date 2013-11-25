<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="employees.css" rel="stylesheet" type="text/css">
<title>Search employee results Update</title>
</head>

<body>
<cfoutput>
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
		<cfif url.employeeName NEQ "">
			AND employee.firstName LIKE '%#url.employeeName#%'
		</cfif>
		<cfif url.departmentID NEQ "All">
			AND employee.departmentID = #url.departmentID#
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
</cfoutput>
</body>
</html>