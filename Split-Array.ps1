Function Split-Array {

    <#
    .SYNOPSIS
        Splits an array into batches
    .DESCRIPTION
        Splits array to small batches of Specified number objects
    .EXAMPLE
        $ser = Get-Service | Select-Object -expa DisplayName
        Split-Array -InputObject $ser -Number 30 -OutVariable output

        Batch1  : {Agent Activation Runtime_58139, Andrea ST Filters Service, AllJoyn Router Service, Application Layer Gateway
          Service...}
    .INPUTS
        InoutObjects and Number of batches
    .OUTPUTS
        Output is PSCustomObject

    #>

    [CmdletBinding()]
    Param (
        # Param1 help description
        [Parameter(ValueFromPipeline)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Array]$InputObject,

        # Param2 help description
        [Parameter(ParameterSetName='Default Parameter Set Name')]
        [int]$Number
    )

    Begin {
        $InputArray= [System.Collections.ArrayList]@()
        $InputObject | ForEach-Object { $null= $InputArray.Add($_)}
        $batch = [Math]::Floor($InputObject.Count/$Number)
        $remain = $InputObject.Count % $Number
        #$hash =[System.Collections.Hashtable][Ordered]@{}
    }

    Process {
        
        $result = for ($i=0; $i -lt $batch;$i++){
            #Write-Host "`nBatch $($i+1)`n"  -ForegroundColor Yellow -BackgroundColor DarkRed
            $obj = For ($j=1; $j -le $Number;$j++){
                $end = $i*$Number+$j
                #Write-Host "$end`t$($b[$end-1])"
                $b[$end-1]
            }
            [PSCustomObject]@{
                Name = "Batch$($i+1)"
                Value = $obj
            }
            #$hash.Add("Batch$($i+1)",$obj)
        }
        
        #Write-Host "`nBatch $($batch+1)`n"  -ForegroundColor Yellow -BackgroundColor DarkRed
        $remobj = for ($r=1;$r -le $remain;$r++){
            #Write-Host "$($end+$r)`t$($b[$end+$r-1])"
            $b[$end+$r-1]
        }
        $rem= [PSCustomObject]@{
            Name = "Batch$($batch+1)"
            Value = $remobj
        }

        #$hash.Add("Batch$($batch+1)",$remobj)
    }

    End {
        @($result,$rem)
    }
}


