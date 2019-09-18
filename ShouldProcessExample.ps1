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