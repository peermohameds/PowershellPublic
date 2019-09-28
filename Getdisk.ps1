$InformationPreference="Continue"
Function Get-DiskInfo{

    [cmdletbinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    Param(
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [String[]]$ComputerName
    )
Begin{
    $Param = @{
            Class = 'Win32_LogicalDisk'
            Filter = "drivetype='3'"
    }
    #$var = $MyInvocation.MyCommand
}
Process{
    Foreach ($Comp in $ComputerName){
        if ($Force -or $PSCmdlet.ShouldProcess("$Comp")) {
            $Disk += Get-CimInstance -ComputerName $Comp @Param -ErrorAction SilentlyContinue -ErrorVariable cmderror -InformationAction Continue -InformationVariable cmdinfo| Select-Object -Property DeviceID,Size,FreeSpace
        }
        if ($cmderror){
            #$cmderror
            Write-Error "$($cmderror)"
        }else{
            "NO error"
            Write-Host "$($cmdinfo)"
        }
    }
}

End{
    IF ($disk){      
        $obj=$disk |%{
            [PSCustomObject]@{
        #"HardDisk"= $dev
        "DeviceID" = $PSItem.DeviceID
        "DiskSize" = $PSItem.Size
        "FreeSpace" =$PSItem.FreeSpace
        "FreeSpace%" = [Math]::Round(($PSItem.FreeSpace /$PSItem.Size)*100,2)
        }
        }
    }

    $obj | Format-Table -AutoSize
}
}

Get-DiskInfo -ComputerName LocalHosT

#Get-CimInstance -ComputerName Localho -ErrorAction SilentlyContinue -ErrorVariable cmderror @Param

Show-Parameter -Text "hee" -Number "10" -Verbose
