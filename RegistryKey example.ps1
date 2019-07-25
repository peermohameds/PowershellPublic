$Hashtable = [Ordered]@{}
$regkey = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion'
$removableName= "PSChildName","PSDrive","PSParentPath","PSPath","PSProvider"

$RegistryValue = Get-ItemProperty $regkey
$RegistryValue.PsObject.Properties | 
    ForEach-Object {
        $Hashtable[$_.Name] = $_.Value
    }
$removableName | ForEach-Object { $Hashtable.Remove($_) }
$Hashtable.Add("ComputerName",$env:COMPUTERNAME)
$Hashtable.Add("Regkey",$regkey)
$a = New-Object PSCustomObject -Property $Hashtable

$a | Format-List -GroupBy ComputerName 