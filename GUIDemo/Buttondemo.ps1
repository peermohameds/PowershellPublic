[XML]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="MainWindow" Height="250" Width="350">
    <ListView Name="listView">
        <ListView.View>
            <GridView>
                <GridViewColumn Header="ID" DisplayMemberBinding="{Binding Path=Id}" Width="60"/>
                <GridViewColumn Header="Name" DisplayMemberBinding="{Binding Path=Name}" Width="60"/>
                <GridViewColumn Header="Address"  Width="200">
                    <GridViewColumn.CellTemplate>
                        <DataTemplate>
                            <TextBox Text="{Binding Path=Memo}" TextWrapping="Wrap" Width="150"/>
                        </DataTemplate>
                    </GridViewColumn.CellTemplate>
                </GridViewColumn>
            </GridView>
        </ListView.View>
    </ListView>
</Window>
"@

Add-Type -AssemblyName PresentationFramework
$FormReader = New-Object System.Xml.XmlNodeReader $XAML
$WebForm = [Windows.MarkUp.XamlReader]::Load($FormReader)


$Xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name $_.Name -Value $WebForm.FindName($_.Name)}
#$browser.Navigate("www.google.com")

$person = [PSCustomObject]@{
    ID = 1 
    Name = "Peer Mohamed"
    Memo = "sample address"
}

$listView.Items.Add($person)


$WebForm.ShowDialog()

