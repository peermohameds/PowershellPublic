$head=@"
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>jQuery sortable.js: Sortable Table Demo</title>

<link href="sortable.css" rel="stylesheet" type="text/css">
	<style>
	html {
		box-sizing: border-box;
	}
	*, *:before, *:after {
		box-sizing: inherit;
	}
	body {
		margin: 0;
		padding: 0;
    font-family:'Roboto';
	}
	pre {
		width: 300px;
		margin: 0 auto;
		text-align: left;
	}
	#divbeforeid {
		height: 200px;
		width: 100%;
		text-align: center;
		background: #faf3f3;
	}
	#divafterid {
		height: 100px;
		line-height: 100px;
		width: 100%;
		text-align: center;
		background: #effbf8;
	}
	
	</style>
</head>

<body>

<script src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
<script src="sortable.js"></script>
<script>
`$(document).ready(function () {

	`$('#tableid').sortable({
		divBeforeTable: '#divbeforeid',
		divAfterTable: '#divafterid',
		initialSort: 4,
		locale: 'th',
		negativeSort: [1, 2]
	});

});
</script>
</body>
</html>
"@
[xml]$Services = Get-ChildItem C:\Windows | Select-Object -First 20 | ConvertTo-Html -As Table -Fragment
$col=for($i=2; $i -le $Services.table.ChildNodes.Count-1;$i++){ "<tr>"+$Services.table.ChildNodes[$i].InnerXml+"</tr>" }
$thead="<thead><tr>"+$Services.table.ChildNodes[1].InnerXml+"</tr></thead>"
$col ="<tbody id=`"mytable`">"+$col+"</tbody>"
$temp =$thead+$col
$Services.table.InnerXml=$temp
$class = $Services.CreateAttribute("ID")
$class.value = 'tableid'
$Services.table.Attributes.Append($class)
ConvertTo-Html -Body $Services.InnerXml -Head $Head| Out-File D:\sample.html -Force