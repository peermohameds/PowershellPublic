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


$disk =gci -force 'C:\Users'-ErrorAction SilentlyContinue | ? { $_ -is [io.directoryinfo] } | % {
    $len = 0
    gci -recurse -force $_.fullname -ErrorAction SilentlyContinue | % { $len += $_.length }
    [pscustomobject]@{ Name = $_.fullname ;  Size = '{0:N2} GB' -f ($len / 1Gb)  }    
}

[void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms.DataVisualization")

# create chart object
$Chart = New-object System.Windows.Forms.DataVisualization.Charting.Chart
$Chart.Width = 500
$Chart.Height = 400
$Chart.Left = 40
$Chart.Top = 30

# create a chartarea to draw on and add to chart
$ChartArea = New-Object System.Windows.Forms.DataVisualization.Charting.ChartArea
$Chart.ChartAreas.Add($ChartArea)
$Cities = @{London=7556900; Berlin=3429900; Madrid=3213271; Rome=2726539;
    Paris=2188500}
[void]$Chart.Series.Add("Data")
$Chart.Series["Data"].Points.DataBindXY($Cities.Keys, $Cities.Values)
<# [void]$Chart.Series.Add("Data")
$Chart.Series["Data"].Points.DataBindXY($disk.Name, $disk.Size) #>

$Chart.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Right -bor
                [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left
$Form = New-Object Windows.Forms.Form
$Form.Text = "PowerShell Chart"
$Form.Width = 600
$Form.Height = 600
$Form.controls.add($Chart)
$Form.Add_Shown({$Form.Activate()})
$Form.ShowDialog()