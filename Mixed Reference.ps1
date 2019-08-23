# Example to pull ODBC Customized output
$res = Get-OdbcDsn 
foreach ($r in $res){
        $val = $r.Attribute
        $prop=($val.GetEnumerator() | %{ "$($_.Name)=$($_.Value)"}) -join ";"
        [pscustomobject]@{
        
            Name = $r.Name
            DriverName = $r.DriverName
            DSNType = 
            Properties = $prop
        }
}

# testing ODBC Connection 
$DSN = "DSN name Goes here"
$ODBCTest = New-Object System.Data.Odbc.OdbcConnection
$ODBCTest.ConnectionString = "(DSN=$DSN)"
Try{
        $status=$ODBCTest.Open()
        if ($status){
            $true
            $ODBCTest.Close()
        }else {
            $false
        }
} catch{
$false
}

# Parameter Checking refererences
$parameters = Get-Command Get-OdbcDsn | Select-Object -expa Parameters
$parameters.Keys -match "driver" #outputs parameter name DRIVERNAME
$parameters.ContainsKey("Name") #Outputs Boolean True/False
