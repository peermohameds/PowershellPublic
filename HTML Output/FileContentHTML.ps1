$Head =@"
<head> sample File </head>
<Style>
body { 
    font-family:Tahoma, Geneva, sans-serif;
    font-size:10pt; }
table {
    font-family: Tahoma, Geneva, sans-serif;
    border: 0px solid #772953;
    width: 100%;
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

textarea {
    width: 80%;
    height: 400px;
    padding: 12px 20px;
    
    border: 2px solid #ccc;
    border-radius: 4px;
    background-color: #f8f8f8;
    
}
</Style>
"@
Function Escape{
      Param ($inputObject)
    $hashtable =@{
        ">" = '&gt;'
        "<" = '&lt;'
        "&" = '&amp;'
        "`"" = '&quot;'
        "`'" = '&apos;'
   }

   Foreach ($key in $hashtable.Keys){
    #"$key - $($hashtable.Item($key))"
    $inputObject =$inputObject.Replace($key, $($hashtable[$key]))  
  } 
   $inputObject
}
$customobject = [PSCustomObject]@{
    Name = Get-Item 'D:\PSGit\PowershellPublic\HTML Output\Books.xml' | Select -ExpandProperty Name
    Content = Get-Content 'D:\PSGit\PowershellPublic\HTML Output\Books.xml' | Out-String}

[xml]$html = $customobject | ConvertTo-Html -As Table -Fragment
$temp = Escape -inputObject ($html.table.Tr.Td[2])
#$res = "<textarea> `&quot`;"+[System.Environment]::NewLine+ $temp+"`&quot`;</textarea>"
$res = "<pre>"+[System.Environment]::NewLine+ $($temp)+"</pre>"
$html.table.tr.childnodes[3].Innerxml=$res
$html.table.tr.childnodes[3].Innerxml
#Set-Variable $html.table.tr.childnodes[3].Innerxml -Value $res 

ConvertTo-Html -Body $HTML.InnerXml -Head $Head | Out-File D:\Result.htm -Force