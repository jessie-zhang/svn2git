function searchEmp(){
	
	var url = "empResults.cfm";
	url += "?employeeName=" + $("#employeeName").val(); 
	url += "&departmentID=" + $("#departmentID").val();
	
	$.ajax({
		type: "GET",
		url: url,
		success: function(html){
			displayResults(html);
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) {
			displayError(XMLHttpRequest, textStatus, errorThrown);
		}
	});
	//$("#searchResults").load(url,displayResults());
	return false;	
}

function displayResults(html) {
	$("#searchResults").html(html);
	$("#empResults").tableSorter();
	if($("#searchResults").is(':visible')) {
		$("#searchResults").slideUp('slow');
	}
	
	$("#searchResults").slideDown('slow');
}


function displayError(XMLHttpRequest, textStatus, errorThrown) {
	$("#searchResults").html("Problem retrieving data: " + XMLHttpRequest.statusText);
	$("#searchResults").slideDown('slow');
}

