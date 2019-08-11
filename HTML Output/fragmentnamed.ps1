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
<p>Type something in the input field to search the table for first names, last names or emails:</p>  
<input id="myInput" type="text" placeholder="Search..">
<br><br>
<body>
</html>
"@
[String[]]$Search ="xbox","web"

$scriptblock={
        Param ($ser)
    $allservices = Get-CimInstance -ClassName Win32_Service
    Foreach($s in $Ser){
        
        $selected += $allservices | Where-Object {$_.Name -match $s -or $_.Displayname -match $s}
    }

    Write-Output $selected
}

[scriptblock]$customBlock={ Param ($ser)
    $allservices = Get-CimInstance -ClassName Win32_Service
    Foreach($s in $Ser){
        
        $selected += $allservices | Where-Object {$_.Name -match $s -or $_.Displayname -match $s}
    }
     $selected | ForEach-Object {
            [PSCustomObject][Ordered]@{
                Name = $_.Name
                DisplayName = $_.DisplayName
                Status = $_.State
                StartMode = $_.StartMode
            }
    }   
} 

$params = @{
    ScriptBlock = $scriptblock
    ArgumentList = (,$Search)
}

$result = Invoke-Command @params

$data = $result | Select-Object Name,DisplayName,State,StartMode
$alertString ="Stopped","Stopping"
$fragment =@()
$body=$null
[xml]$HTML = $data | Select-Object name,DisplayName,State,StartMode | ConvertTo-Html -Fragment -As Table

$id=$html.CreateAttribute("ID")
$id.Value = "mytable"
$html.table.Attributes.Append($id)

Clear-Content D:\sample.html
ConvertTo-Html -Body $HTML.InnerXml -Head $Head -PostContent "$(get-date -f "t")" | out-file D:\sample.html -Force
#Invoke-Item D:\sample.html
