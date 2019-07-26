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
    ScriptBlock = $customBlock
    ArgumentList = (,$Search)
}

$result = Invoke-Command @params

$data = $result | Select-Object Name,DisplayName,Status,StartMode | Group-Object -Property StartMode
$alertString ="Stopped","Stopping","Auto"
$fragment =@()
$body=$null
Foreach($item in $data){
    $body += "<H2>Start Mode : $($item.Name)</H2>"
    #$body += $item.Group | Select-Object name,DisplayName,Status,StartMode | ConvertTo-Html -Fragment -As Table 

    [XML]$HTML = $item.Group | Select-Object name,DisplayName,Status,StartMode | ConvertTo-Html -Fragment -As Table 
    $columnsCount =($HTML | Select-Xml -XPath "//th" | select -ExpandProperty Node).Count
    for ($i=1;$i -le $html.table.tr.count-1;$i++) {
        For ($j=2; $j -le $columnsCount; $j++){
        if ($html.table.tr[$i].td[$j] -in $alertString) {
          $class = $html.CreateAttribute("class")
          $class.value = 'alert'
          #Seleted cell foreground color in red
          $html.table.tr[$i].childnodes[$j].attributes.append($class) | out-null
          #makes the entire Row red
          #$html.table.tr[$i].attributes.append($class) | out-null
        }
    }

      }
      $body += $HTML.InnerXml

}

Clear-Content D:\sample.html
ConvertTo-Html -Body $body -Head $Head -PostContent "$(get-date -f "t")" | out-file D:\sample.html -Force
#Invoke-Item D:\sample.html
