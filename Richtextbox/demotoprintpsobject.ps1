[XML]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="MainWindow" Height="450" Width="650">
        <StackPanel Name="stkpanel">
        <Button Name="Btn" Width ="80" Height="30">Click Me</Button>
        <RichTextBox Name='Rtxt' FontFamily ="Lucida Console" HorizontalScrollBarVisibility = "Auto" 
            VerticalScrollBarVisibility ="Auto" HorizontalAlignment="Left" Height="330" 
                VerticalAlignment="Top" Width="600" Margin ="10"/>  
        <!--<WebBrowser Name="mybrowser" Margin="5 5 5 5" MinWidth="300" MinHeight="500"/> --> 
        </StackPanel>
</Window>
"@


Add-Type -AssemblyName PresentationFramework
$FormReader = New-Object System.Xml.XmlNodeReader $XAML
$WebForm = [Windows.MarkUp.XamlReader]::Load($FormReader)


$Xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name $_.Name -Value $WebForm.FindName($_.Name)}




$Btn.Add_Click({
      $content = Get-Service | Out-String
      $Rtxt.AppendText($content)
})


$WebForm.ShowDialog()

