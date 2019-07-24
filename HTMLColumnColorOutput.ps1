[String[]]$Search ="xbox","web"

$scriptblock={
    Param ($ser)
$allservices = Get-CimInstance -ClassName Win32_Service
Foreach($s in $Ser){
    
    $selected += $allservices | Where-Object {$_.Name -match $s -or $_.Displayname -match $s}
}

Write-Output $selected
}

$params = @{
    ScriptBlock = $customBlock
    ArgumentList = (,$Search)
}

$result = Invoke-Command @params

<#$head = @"
 <Title>Event Log Report</Title>
<style>
body { 
       font-family:Tahoma, Geneva, sans-serif;
       font-size:10pt; }
td, th { border:0px solid black; 
         border-collapse:collapse;
         white-space:pre; }
th { color:white;
     background-color:#772953; }
table, tr, td, th { padding: 2px; margin: 0px ;white-space:pre; }
tr:nth-child(odd) {background-color: lightgray}
table { width:95%;margin-left:5px; margin-bottom:20px;}
h2 {
 font-family:Tahoma, Geneva, sans-serif;
 color:#6D7B8D;
}
.alert {
 color: red;

 }
.footer 
{ color:green; 
  margin-left:10px; 
  font-family:Tahoma;
  font-size:8pt;
  font-style:italic;
}
</style>
"@ #>

$Head =@"
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
</Style>
"@
[String[]]$alertString ="Stopped"#,"Running"
$fragments = @()
$fragments+= "<H1>$($env:COMPUTERNAME)</H1>"
[XML]$html=$result | ConvertTo-Html  -Fragment -As Table  #-Head $head | Out-File D:\Result.htm

for ($i=1;$i -le $html.table.tr.count-1;$i++) {
    if ($html.table.tr[$i].td[2] -in $alertString) {
      $class = $html.CreateAttribute("class")
      $class.value = 'alert'
      #Seleted cell foreground color in red
      $html.table.tr[$i].childnodes[2].attributes.append($class) | out-null
      #makes the entire Row red
      #$html.table.tr[$i].attributes.append($class) | out-null
    }
  }
  $fragments+= $html.InnerXml

  ConvertTo-Html -Head $head -Body $fragments | Out-File D:\Result.htm
