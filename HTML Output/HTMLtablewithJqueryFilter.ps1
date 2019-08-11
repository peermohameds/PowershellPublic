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
      `$(this).toggle(`$(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
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
.sortable {
	margin: 0;
	padding: 0;
	border-collapse: collapse;
	border-style: none;
	border-width: 0;
	border-spacing: 0;
}
.sortable thead,
.sortableth2 {
	height: 40px;
	line-height: 40px;
	background: #effbf8;
	white-space: nowrap;
	overflow: hidden;
}
.sortableth2 {
	box-shadow: 0px 5px 5px rgba( 0,0,0,0.1 ) inset, 
		0px 5px 5px rgba( 0,0,0,0.5 );
	opacity: 0.95;
}
.sortable tr {
	height: 30px;
	cursor: default;
}
.sortableth2 a,
.sortable td {
	padding: 0 3px;
}

.sortable thead td { /* ios safari 'thead', 'tbody' - not support 'box-shadow' */
	box-shadow: 0px 9px 5px -6px rgba( 0,0,0,0.1 ) inset;
}
.sortable thead td {
/*	font-weight: bold;
	text-align: center;*/ /* default */
}
.sortable tbody {
/*	background: #fff;*/
}

/* reponsive ------------------------------------------------------------------------------------------------------------------------------------- */
/*
	min-width: 0 !important - required for column with 'max-width'
	:nth-child( n ) - column# start with left 'tdpad', n=1, table 1st column, n=2
*/

@media( max-width: 569px ) {
/*	.sortable td:nth-child( 4 ) { min-width: 0 !important; display: none !important; }
	.sortable td:nth-child( 5 ) { min-width: 0 !important; max-width: 300px; }*/
}
@media( max-width: 414px ) {
/*	.sortable td:nth-child( 3 ) { min-width: 0 !important; display: none !important; }
	.sortable td:nth-child( 5 ) { min-width: 0 !important; max-width: 220px; }*/
}
@media( max-width: 320px ) {
/*	.sortable td:nth-child( 6 ) { display: none !important; }
	.sortable td:nth-child( 5 ) { min-width: 0 !important; max-width: 200px; }*/
}
@media( max-height: 414px ) {
	.sortable thead td {
		border-bottom: 1px solid rgba( 0,0,0,0.05 );
	}
}


/* SHOULD NOT change below this line ------------------------------------------------------------------------------------------- */
.sortableth2 a,
.sortable td { /* 3 lines for ellipsis: 'td max-width' must be set */
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
.sortable tbody tr:nth-child( even ) { /* zebra stripe */
	background: rgba( 0,0,0,0.05 );
}
.sortable tbody tr:hover {
	background: rgba( 0,0,0,0.15 );
}
.sorted { /* sorted column */
	background: rgba( 0,0,0,0.05 );
}
.asc:before, .asctmp:before {
	content: '▲';
	color: green;
}
.desc:before {
	content: '▼';
	color: crimson;
}
.asctmp:before {
	opacity: 0;
}
/* custom <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< */

/* DO NOT change below this line ---------------------------------------------------------------------------------------------------- */
body {
	width: 100% !important;
}
.divbefore,
.divafter {
	position: fixed;
	z-index: 10;
}
.divafter {
	bottom: 0;
}
.sortable thead,
.sortableth2 {
	cursor: pointer;
	user-select: none;
}
.sortableth2 {
	position: fixed;
	width: 100%;
	z-index: 1;
}
.sortableth2 a {
	display: inline-block;
}
.sortable thead {
	visibility: hidden;
}
.sortable thead td:empty {
	pointer-events: none;
}
.sortable tbody {
	overflow: auto;
	-webkit-overflow-scrolling: touch; /* ios momentum scroll */
}
.sortable .tdpad {
	width: 50%; /* oversize for centering table */
	padding: 0;
}
</Style>
</head>
<body>
<h2>Filterable Table</h2>
<p>Type something in the input field to search the table for first names, last names or emails:</p>  
<input id="myInput" type="text" placeholder="Search..">
<br><br>
</body>
</html>
"@

#[xml]$Services = Get-Service | Select-Object Name,DisplayName,Status | ConvertTo-Html -As Table -Fragment
[xml]$Services = Get-ChildItem C:\Windows | Select-Object -First 20 | ConvertTo-Html -As Table -Fragment
$col=for($i=2; $i -le $Services.table.ChildNodes.Count-1;$i++){ "<tr>"+$Services.table.ChildNodes[$i].InnerXml+"</tr>" }
$thead="<thead><tr>"+$Services.table.ChildNodes[1].InnerXml+"</tr></thead>"
$col ="<tbody id=`"mytable`">"+$col+"</tbody>"
$temp =$thead+$col
$Services.table.InnerXml=$temp
$class = $Services.CreateAttribute("ID")
$class.value = 'datatable'
$Services.table.Attributes.Append($class)
ConvertTo-Html -Body $Services.InnerXml -Head $Head| Out-File D:\sample.html -Force