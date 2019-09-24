[xml]$xaml = @"
<Window
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Live Servers Found" Height="300" Width="500" ResizeMode="NoResize">

    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="1*"/>
            <RowDefinition Height="4*"/>
            <RowDefinition Height="1*"/>
            <RowDefinition Height="1*"/>
            <RowDefinition Height="1*"/>
        </Grid.RowDefinitions>

        <Label Grid.Row="0" Content="Live Servers : " FontWeight="Bold" Foreground="IndianRed"/>
        <TextBox Grid.Row="1" Name="liveout" AcceptsReturn="True" HorizontalContentAlignment="Left" IsReadOnly="True" Margin="5,2" FontFamily="Lucida Console">
            Sample Text message with
            two Lines.
        </TextBox>
        <Grid Grid.Row="2">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="2*"/>
                <ColumnDefinition Width="6*"/>
            </Grid.ColumnDefinitions>
            <Label Grid.Column="0" Content="Description-CRQ" VerticalAlignment="Center" HorizontalAlignment="Center" HorizontalContentAlignment="Left" FontWeight="Bold" Margin="5,2"/>
            <TextBox Grid.Column="1" HorizontalContentAlignment="Left" VerticalContentAlignment="Center" Margin="5,5"/>
        </Grid>
        <Label Grid.Row="3" Content="Which Action you prefer to perform ?" FontWeight="Bold"/>
        <Grid Grid.Row="4">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="2*"/>
                <ColumnDefinition Width="1*"/>
                <ColumnDefinition Width="1*"/>
                <ColumnDefinition Width="1*"/>
            </Grid.ColumnDefinitions>
            
            <Button Grid.Column="1" Name="RemoveBtn" Margin="10 3" Content="Remove Live" ToolTip="Removes Live servers from List and Execure the command"/>
            <Button Grid.Column="2" Name="KeepBtn" Margin="10 3" Content="Keep Live" ToolTip="Keep Live servers from List and Execure the command"/>
            <Button Grid.Column="3" Name="CancelBtn" Margin="10 3" Content="Cancel" ToolTip="Cancels Current execution"/>
        </Grid>
    </Grid>
</Window>
"@
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

$FormReader = New-Object System.Xml.XmlNodeReader $XAML
$MessageForm = [Windows.MarkUp.XamlReader]::Load($FormReader)
$Xaml.SelectNodes("//*[@Name]") | % { Set-Variable -Name $_.Name -Value $MessageForm.FindName($_.Name) }

$KeepBtn.Add_Click( {
        $MessageForm.DialogResult = [System.Windows.Forms.DialogResult]::No
        $MessageForm.Close()
    })

$RemoveBtn.Add_Click( {
        $MessageForm.DialogResult = [System.Windows.Forms.DialogResult]::Yes
        $MessageForm.Close()
    })
$CancelBtn.Add_Click( {
        $MessageForm.Close()
        $MessageForm.DialogResult = [System.Windows.Forms.DialogResult]::None
    })

$MessageForm.ShowDialog() | Out-Null
Return $($MessageForm.DialogResult)
