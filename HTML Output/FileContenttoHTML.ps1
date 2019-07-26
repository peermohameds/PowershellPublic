$file =(Get-Content D:\sample.css) | Select-String -Pattern "Table" | Select-Object LineNumber,Line
$content=Get-Content D:\sample.css | % { $i = 1 } { [PSCustomObject]@{
                                                        LineNumber = $i
                                                        Line = $_
                                                        } 
                                                        $i++
                                                    }

$a = $content| ConvertTo-Html -As Table -Fragment

$head=@"
<Style>
table {
    font-family: Tahoma, Geneva, sans-serif;
    border: 0px solid #772953;
    width: 50%;
    text-align: left;
    border-collapse: collapse;
  }
  table td, th {
    border: 1px solid #772953;
    padding: 5px 4px;
  }
  table tbody td {
    font-size: 11px;
  }

  table thead th {
    background: #772953;
    border-bottom: 0px solid #772953;
    font-size: 12px;
    font-weight: bold;
    color: #FFFFFF;
    text-align: center;
    border-left: 0px solid #D0E4F5;
  }
</Style>
"@
 
$result = [PSCustomObject]@{
    Name = $env:COMPUTERNAME
    File = $a
}

$body = "<h1>ComputerName : $($result.Name)</H1>"
$body += $a

ConvertTo-Html -Head $head -Body $body | Out-File D:\file.html