$Head =@"
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
`$(document).ready(function(){
  `$("#myInput").on("keyup", function() {
		var value = `$(this).val().toLowerCase();
		`$("#mytable tr").filter(function() {
			`$(this).toggle(`$(this).text().toLowerCase().indexOf(value) > -1);
			var numOfVisibleRows = `$("#mytable tr:visible").length;
			`$("#resbox").val(numOfVisibleRows);
		});
  
	});
	`$("#mybtn").click(function(){
		alert ("Hello");	
	});
});
</script>
<script>
`$(document).ready(function(){
	
});
</script>

<script src="sortable.js"></script>
<script>
`$(document).ready(function () {

	`$('#datatable').sortable({
		divBeforeTable: '#divbeforeid',
		divAfterTable: '#divafterid',
		initialSort: 4,
		locale: 'th',
		negativeSort: [1, 2]
	});

});
</script>
<Style>
body { 
    font-family:Tahoma, Geneva, sans-serif;
    font-size:10pt; }
table {
    font-family: Tahoma, Geneva, sans-serif;
    border: 0px solid #772953;
    width: 60%;
    text-align: left;
    border-collapse: collapse;
  }
td, th {
    border: 1px solid #772953;
    padding: 5px 4px;
  }
td {
    font-size: 11px;
  }

th {
    background: #772953;
    border-bottom: 0px solid #772953;
    font-size: 12px;
    font-weight: bold;
    color: #FFFFFF;
    text-align: center;
    border-left: 0px solid #D0E4F5;
  }
.alert {
    color: red;
    font-weight: bold;
}
.good {
    color: green;
    font-weight: bold;
}
</Style>
</head>
<body>
<h2>Filterable Table</h2>
<p>Type something in the input field to search the table.</p>  
<input id="myInput" type="text" placeholder="Search..">
No of records : <input id="resbox" type="text" placeholder="# records">
<br><br>
<Button id="mybtn">Copy</button>
</body>
</html>
"@

#[xml]$Services = Get-Service | Select-Object Name,DisplayName,Status | ConvertTo-Html -As Table -Fragment
[xml]$Services = Get-Service | Select-Object Name,DisplayName,Status,StartType -First 20 | ConvertTo-Html -As Table -Fragment
$col=for($i=2; $i -le $Services.table.ChildNodes.Count-1;$i++){ "<tr>"+$Services.table.ChildNodes[$i].InnerXml+"</tr>" }
$thead="<thead><tr>"+$Services.table.ChildNodes[1].InnerXml+"</tr></thead>"
$col ="<tbody id=`"mytable`">"+$col+"</tbody>"
$temp =$thead+$col
$Services.table.InnerXml=$temp
$class = $Services.CreateAttribute("ID")
$class.value = 'datatable'
$Services.table.Attributes.Append($class)
ConvertTo-Html -Body $Services.InnerXml -Head $Head| Out-File D:\sample.html -Force