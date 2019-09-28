Function Show-Parameter {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([PSCustomObject])]
    Param (
        [string]$Text,
        [int]$Number,
        [switch]$Force
    )
 
    if ($force -or $PSCmdlet.ShouldProcess("$Comp")){
        $PSCmdlet.WriteVerbose("Hello")
    }
    
   
    #$MyInvocation | gm -Force
   
    #$MyInvocation.PSCommandPath
}
Show-Parameter -Text "hee" -Number "10" -Whatif -Verbose

#Get-Item Function:\Show-Parameter | Remove-Item    


$disk =Get-ChildItem -force 'D:\'-ErrorAction SilentlyContinue | Where-Object { $_ -is [io.directoryinfo] } | ForEach-Object {
    $len = 0
    Get-ChildItem -recurse -force $_.fullname -ErrorAction SilentlyContinue | ForEach-Object { $len += $_.length }
    [pscustomobject]@{ Name = $_.name ;Path =$_.FullName ; Size = '{0:N2} GB' -f ($len / 1Gb)  }    
}

function foo {
    [cmdletbinding()]
        Param (
            [parameter(ValueFromPipeline=$True)]
            [string[]]$Name)
     
        Begin {}
        Process{
            if ($Name){ $input = $name}
            $input 
        }
        End{}
}
"Hello","Friend" | Foo -Verbose

Foo -Name "Hello" -Verbose

$cred = Get-Credential

$array = 1,2,-4,5
$array.GetType()
$str='Hello','World'
$str.GetType() | FL *
$s ="Hello"

$s.GetType()

$newarr = [System.Collections.ArrayList]::new()

