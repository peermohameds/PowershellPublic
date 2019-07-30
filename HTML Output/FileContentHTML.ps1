$key = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\'

Test-Path $key

if(!(Test-Path $key)){


    $Split = Split-Path -Path $key -Parent
    $leaf = Split-Path -Path $key -Leaf
    $splitreult= Test-Path -Path $Split

    if ($splitreult){

        Get-ItemProperty -Path $Split -Name $leaf | Select-Object -ExpandProperty $leaf
    }
}Else{

    $a=Get-ItemProperty $key | Select-Object * -ExcludeProperty PSPath,PSParentPath,PSChildName,PSDrive,PSProvider

}

$check = Get-Item -Path $key

Get-ItemProperty -Path $key

$check.PSIsContainer