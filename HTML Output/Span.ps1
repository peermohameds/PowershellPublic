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
.good {
    color: green;
    font-weight: bold;
}
</Style>
"@
$ser = Get-Service -Name w* |Select Status,Name,DisplayName | Group-Object -Property Status

[xml]$html = $ser | Select -ExpandProperty Group | ConvertTo-Html -As Table -Fragment


for ($i=1;$i -le $html.table.tr.count-1;$i++) {
    if ($html.table.tr[$i].td[0] -) {
      $class = $html.CreateAttribute("class")
      $class.value = 'alert'
      #Seleted cell foreground color in red
      $html.table.tr[$i].childnodes[2].attributes.append($class) | out-null
      #makes the entire Row red
      #$html.table.tr[$i].attributes.append($class) | out-null
    }
}
Clear-Content D:\sample.html
ConvertTo-Html -Body $body -Head $Head -PostContent "$(get-date -f "t")" | out-file D:\sample.html -Force
Invoke-Item D:\sample.html