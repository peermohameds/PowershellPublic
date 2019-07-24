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

$data = $result | Select-Object Name,DisplayName,State,StartMode | Group-Object -Property StartMode


$body=$null
Foreach($item in $data){
    $body += "<H2>Start Mode : $($item.Name)</H2>"
    $body += $item.Group | Select-Object name,DisplayName,State,StartMode | ConvertTo-Html -Fragment -As Table 
}

Clear-Content D:\sample.html
ConvertTo-Html -Body $body -CssUri D:\Output.css -PostContent "$(get-date -f "t")" | out-file D:\sample.html -Force
Invoke-Item D:\sample.html
