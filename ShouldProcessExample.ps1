Function Show-Parameter {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([PSCustomObject])]
    Param (
        [string]$Text,
        [int]$Number,
        [switch]$Include
    )
 
    if ($PSCmdlet.ShouldProcess("$Comp")){
        $PSCmdlet.WriteVerbose("Hello")
    }
    
   
    #$MyInvocation | gm -Force
   
    #$MyInvocation.PSCommandPath
}
Show-Parameter -Text "hee" -Number "10" -Verbose

#Get-Item Function:\Show-Parameter | Remove-Item    


$disk =gci -force 'D:\'-ErrorAction SilentlyContinue | ? { $_ -is [io.directoryinfo] } | % {
    $len = 0
    gci -recurse -force $_.fullname -ErrorAction SilentlyContinue | % { $len += $_.length }
    [pscustomobject]@{ Name = $_.name ;Path =$_.FullName ; Size = '{0:N2} GB' -f ($len / 1Gb)  }    
}
