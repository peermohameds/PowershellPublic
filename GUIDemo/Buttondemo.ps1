<#[XML]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="MainWindow" Height="250" Width="350">
    <ListView Name="listView">
        <ListView.View>
            <GridView>
                <GridViewColumn Header="ID" DisplayMemberBinding="{Binding Path=Id}" Width="60"/>
                <GridViewColumn Header="Name" DisplayMemberBinding="{Binding Path=Name}" Width="60"/>
                <GridViewColumn Header="Address"  Width="200">
                    <GridViewColumn.CellTemplate>
                        <DataTemplate>
                            <TextBox Text="{Binding Path=Memo}" TextWrapping="Wrap" Width="150"/>
                        </DataTemplate>
                    </GridViewColumn.CellTemplate>
                </GridViewColumn>
            </GridView>
        </ListView.View>
    </ListView>
</Window>
"@ #>

[XML]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="MainWindow" Height="450" Width="650">
       
        <StackPanel>
        <Button Name="Btn" Width ="80" Height="30">Click Me</Button>
        <WebBrowser Name="mybrowser" Margin="5 5 5 5" MinWidth="300" MinHeight="500"/> 
        </StackPanel>
</Window>
"@

$HTML=@"
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=10" /> 
<style> 
div {
  width: 100px;
  height: 100px;
  background-color: red;
  -webkit-animation-name: example; /* Safari 4.0 - 8.0 */
  -webkit-animation-duration: 4s; /* Safari 4.0 - 8.0 */
  animation-name: example;
  animation-duration: 4s;
}

/* Safari 4.0 - 8.0 */
@-webkit-keyframes example {
  from {background-color: red;}
  to {background-color: yellow;}
}

/* Standard syntax */
@keyframes example {
  from {background-color: red;}
  to {background-color: yellow;}
}
</style>
</head>
<body>

<p><b>Note:</b> This example does not work in Internet Explorer 9 and earlier versions.</p>

<div></div>

<p><b>Note:</b> When an animation is finished, it changes back to its original style.</p>

</body>
</html>
"@
$jspath='D:\jquery\jquery-3.4.1.min.js'

$htmllayout=@"
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
`$(document).ready(function(){
      var numOfVisibleRows = `$("#mytable tr:visible").length;
      `$("#resbox").val(numOfVisibleRows);
      
  `$("#myInput").on("keyup", function() {
     var value = `$(this).val().toLowerCase();
		`$("#mytable tr").filter(function() {
			`$(this).toggle(`$(this).text().toLowerCase().indexOf(value) > -1);
			var numOfVisibleRows = `$("#mytable tr:visible").length;
			`$("#resbox").val(numOfVisibleRows);
		});
	});
});
</script>
<script>
`$(document).ready(function() {

  function exportTableToCSV(`$table, filename) {

    var `$rows = `$table.find('tr:has(td),tr:has(th)'),

        // Temporary delimiter characters unlikely to be typed by keyboard
        // This is to avoid accidentally splitting the actual contents
        tmpColDelim = String.fromCharCode(11), // vertical tab character
        tmpRowDelim = String.fromCharCode(0), // null character

        // actual delimiter characters for CSV format
        colDelim = '","',
        rowDelim = '"\r\n"',

        // Grab text from table into CSV formatted string
        csv = '"' + `$rows.map(function (i, row) {
            var `$row = `$(row), `$cols = `$row.find('td,th');

            return `$cols.map(function (j, col) {
                var `$col = `$(col), text = `$col.text();

                return text.replace(/"/g, '""'); // escape double quotes

            }).get().join(tmpColDelim);

        }).get().join(tmpRowDelim)
            .split(tmpRowDelim).join(rowDelim)
            .split(tmpColDelim).join(colDelim) + '"',



        // Data URI
        csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);

        console.log(csv);

        if (window.navigator.msSaveBlob) { // IE 10+
            alert('IE' + csv);
            window.navigator.msSaveOrOpenBlob(new Blob([csv], {type: "text/plain;charset=utf-8;"}), "csvname.csv")
        } 
        else {
            `$(this).attr({ 'download': filename, 'href': csvData, 'target': '_blank' }); 
        }
}
  // This must be a hyperlink
  `$("#exportcsv").on('click', function(event) {
    // CSV
    var args = [`$("#dtBasicExample"), 'export.csv'];
    
    exportTableToCSV.apply(this, args);

    // If CSV, don't do event.preventDefault() or return false
    // We actually need this to be a typical hyperlink
  });
});
</script>
<script>
`$(document).ready(function(){
  `$("exportxls").click(function(){
    alert ("export xls clicked"); 
  });

});
</script>
<style>
* {
  box-sizing: border-box;
}

body {
  font-family: Arial, Helvetica, sans-serif;
}

/* Style the header */
header {
  background-color: #666;
  padding: 30px;
  text-align: center;
  font-size: 35px;
  color: white;
}

/* Create two columns/boxes that floats next to each other */
nav {
  float: left;
  width: 30%;
  height: 300px; /* only for demonstration, should be removed */
  background: #ccc;
  padding: 20px;
}

/* Style the list inside the menu */
nav ul {
  list-style-type: none;
  padding: 0;
}

article {
  float: left;
  padding: 20px;
  width: 70%;
  background-color: #f1f1f1;
  height: 300px; /* only for demonstration, should be removed */
}

/* Clear floats after the columns */
section:after {
  content: "";
  display: table;
  clear: both;
}

/* Style the footer */
footer {
  background-color: #777;
  padding: 10px;
  text-align: center;
  color: white;
}

/* Responsive layout - makes the two columns/boxes stack on top of each other instead of next to each other, on small screens */
@media (max-width: 600px) {
  nav, article {
    width: 100%;
    height: auto;
  }
}
</style>

</head>
<body>
<h2>Filterable Table</h2>
<p>Type something in the input field to search the table.</p>  
<input id="myInput" type="text" placeholder="Search..">
No of records : <input id="resbox" type="text" placeholder="# records">
<br><br>
Export Table as :
<Button id="exportcsv" class="btn btn-primary btn-sm">CSV</button>
<Button id="exportxls" class="btn btn-success btn-sm">XLS</button>
<Button id="exportpdf" class="btn btn-info btn-sm">PDF</button>
<br>
</body>
</html>
"@

Add-Type -AssemblyName PresentationFramework
$FormReader = New-Object System.Xml.XmlNodeReader $XAML
$WebForm = [Windows.MarkUp.XamlReader]::Load($FormReader)


$Xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name $_.Name -Value $WebForm.FindName($_.Name)}

$Btn.Add_Click({
       
  [xml]$Services = Get-Service | Select-Object Name,DisplayName,Status,StartType | ConvertTo-Html -As Table -Fragment
  $col=for($i=2; $i -le $Services.table.ChildNodes.Count-1;$i++){ "<tr>"+$Services.table.ChildNodes[$i].InnerXml+"</tr>" }
  $thead="<thead><tr>"+$Services.table.ChildNodes[1].InnerXml+"</tr></thead>"
  $col ="<tbody id=`"mytable`">"+$col+"</tbody>"
  $temp =$thead+$col
  $Services.table.InnerXml=$temp
  $class = $Services.CreateAttribute("class")
  $class.value = 'table'
  $ID = $Services.CreateAttribute("id")
  $ID.value = 'dtBasicExample'
  $Services.table.Attributes.Append($class)
  $Services.table.Attributes.Append($ID)
  ConvertTo-Html -Body $Services.InnerXml -Head $htmllayout | Out-File D:\sample.html -Force 
        $uri = [uri]::new("D:\sample.html")
        #$mybrowser.Navigate($uri)
        #$uri
        $mybrowser.Navigate($uri)
        #$mybrowser.NavigateToString($uri)
})
#$mybrowser.Navigate("www.google.com")

$person = [PSCustomObject]@{
    ID = 1 
    Name = "Peer Mohamed"
    Memo = "sample address"
}

#$listView.Items.Add($person)

$uri = [uri]::new("https://www.google.com")
$mybrowser.Navigate($uri)

$WebForm.ShowDialog()

