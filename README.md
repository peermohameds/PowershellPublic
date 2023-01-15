# PowershellPublic
Public Folder to Share Code

### Material Window Loading Code
```PowerShell
try {
    Add-Type -AssemblyName PresentationFramework
    Add-Type -Path .\MaterialDesignColors.dll
    Add-Type -Path .\MaterialDesignThemes.Wpf.dll
    # Add-Type -Path .\MaterialDesignExtensions.dll
    Add-Type -Path .\Microsoft.Web.WebView2.Wpf.dll
    Add-Type -Path .\Microsoft.Web.WebView2.Core.dll
}
catch {
    throw
    <#Do this if a terminating exception happens#>
}




[xml]$Xaml = (Get-Content .\MainWindow.xaml) -replace "x:Name", "Name"

$XMLReader = (New-Object System.Xml.XmlNodeReader $Xaml)
$XMLForm = [Windows.Markup.XamlReader]::Load($XMLReader)

$Xaml.SelectNodes("//*[@Name]") | ForEach-Object {
    try {
        Write-Host $_.Name
        Set-Variable -Name $_.Name -Value $XMLForm.FindName($_.Name) -Scope Script -ErrorAction Stop
    }
    catch {
        throw
    }
}
# $CtrlPlatformLview.ItemsSource = Get-Service | Select-Object -First 30
$CtrlOutput.CreationProperties = [Microsoft.Web.WebView2.Wpf.CoreWebView2CreationProperties]::New()
$CtrlOutput.CreationProperties.UserDataFolder = "C:\Temp\Wv2Data"
$XMLForm.Add_Loaded({

        # $List = [System.Collections.ArrayList]::new()

    
        # $Item = [MaterialDesignExtensions.Model.FirstLevelNavigationItem]::new()

        # $Item.Icon = [MaterialDesignThemes.Wpf.PackIconKind]::FileCertificateOutline
        # $Item.Label = "Personal Store"
        # [Void]$List.Add($Header)
        # [Void]$List.Add($Item)

        # $SideNav.Items = $List

        # $CtrlOutput.Source = "https://www.google.com"
        Write-Host "Loaded" -ForegroundColor Green
    })
$exportbtn.Add_Click({
        # $SaveArgs = [MaterialDesignExtensions.Controls.SaveFileDialogArguments]::new()
        # $SaveArgs.Height="400"
        # $SaveArgs.Width="600"
        # $SaveArgs.Filters="Excel File  | *.xlsx | CSV File | *.csv"
        # [MaterialDesignExtensions.Controls.SaveFileDialog]::ShowDialogAsync($RootDialog,$SaveArgs)
        # $AlertOption = [Microsoft.Win32.SaveFileDialog]::New()
        # $AlertOption.Filter = "Excel File | *.xlsx | Comma Seperated | *.csv"
        # $File = $AlertOption.ShowDialog()
        # Write-Host $File
        # $Save = [MaterialDesignExtensions.Controls.SaveFileControl]::new()
        # $Save.Height="400"
        # $Save.Width="600"
        # #$Save.Filters="All files|*.*|C# files|*.cs|XAML files|*.xaml"

        # $SavePanel.AddChild($Save)
        #$RootDialog.IsOpen= $true
    })

$Exp = [System.Windows.Controls.Expander]::New()

$Stk = [System.Windows.Controls.StackPanel]::New()
$Stk.Orientation="Horizontal"
$Tblk = [System.Windows.Controls.TextBlock]::New()
$Tblk.Style = $XMLForm.FindResource('MaterialDesignSubtitle2TextBlock')
$Tblk.Text = "Dynamic"
$Tblk.Margin = "10, 5"
$Tblk.HorizontalAlignment="Center" 
$Tblk.VerticalAlignment="Center"
$Icon = [MaterialDesignThemes.Wpf.PackIcon]::new()
$Icon.Kind= "Toolbox"
$Icon.HorizontalAlignment="Center" 
$Icon.VerticalAlignment="Center"
$Stk.AddChild($Icon)
$Stk.AddChild($Tblk)



$Exp.Header = $Stk
$CmdPanel.AddChild($Exp)

# $L = New-Object 'System.Collections.Generic.List[System.Object]'
# $Header = [MaterialDesignExtensions.Model.SubheaderNavigationItem]::new()
# $Header.Subheader = "Certificates"

# $L.Add($Header)

# $Side = [MaterialDesignExtensions.Controls.SideNavigation]::New()
# $Side.Items = $L
# $CmdPanel.AddChild($Side)

function Set-Theme {
    [CmdletBinding()]
    param (
        # Parameter help description
        [MaterialDesignColors.PrimaryColor]
        $PrimaryColor,
        [MaterialDesignColors.SecondaryColor]
        $SecondaryColor
    )
    
    begin {
        
    }
    
    process {
        
    }
    
    end {
        
    }
}



$XMLForm.ShowDialog()

```
