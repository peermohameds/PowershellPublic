#Build the GUI
[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    x:Name="Window" Title="Initial Window" WindowStartupLocation = "CenterScreen" 
    Width = "800" Height = "600" ShowInTaskbar = "True">
 
   

        <Grid x:Name="Grid">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="Auto"/>
            <ColumnDefinition Width="Auto"/>
            <ColumnDefinition Width="Auto"/>
            <ColumnDefinition Width="Auto"/>
        </Grid.ColumnDefinitions>
    
            <Button Grid.Row="1" Grid.Column="0">
                <TextBlock FontSize="16">
                    <Run Text="&#xE909;"
                         FontFamily="Segoe MDL2 Assets" Foreground="Green"/>
                    <Run Text=" Feedback" />
             </TextBlock>
            </Button>

            <Button Name="samplebutton" Grid.Row="0" Grid.Column="0" >
                <Grid>
            <Grid.ColumnDefinitions>
            <ColumnDefinition Width="Auto"/>
            <ColumnDefinition Width="Auto"/>

            </Grid.ColumnDefinitions>
                <Image Grid.Column="0" Source="C:\Users\Peer\Downloads\Settings.png"/>
                <TextBlock Grid.Column="1">Execute</TextBlock>
                </Grid> 
            </Button>
            <GroupBox Grid.Row="0" Grid.Column="1" Grid.ColumnSpan="3" Grid.RowSpan="3">
            <GroupBox.HeaderTemplate>
                    <DataTemplate>
                <Grid Width="{Binding ElementName=groupBox1, Path=ActualWidth}" Margin="-10, 0, -10, 0" >
                <Grid.ColumnDefinitions>
                <ColumnDefinition />
                </Grid.ColumnDefinitions>
            <Label Content="Sample " HorizontalAlignment="Left" Background="#25A0DA" Grid.Column="0" Height="20" Padding="5, 0, 0, 0" Margin="10" Foreground="White"/>
                </Grid>
                </DataTemplate>
            </GroupBox.HeaderTemplate>
            <StackPanel>
            <TextBox Width="100" Height="100"/>
            </StackPanel>
            </GroupBox>
            <GroupBox BorderThickness="0" Grid.Row="2" Grid.Column="0" Header="BELT WEIGHER BC#1 JETTY" HorizontalAlignment="Left" Margin="10,10,0,0" VerticalAlignment="Top" Height="193" Width="374" OpacityMask="Black" BorderBrush="#FF1864D3" FontSize="16" FontWeight="Bold">
           <GroupBox.HeaderTemplate >
            <DataTemplate>
                <TextBlock Text="{Binding}"  
                 Width="357" Grid.Column="0" Padding="5,3,0,0" Margin="0,0,0,0"  Foreground="White" Height="33">
                    <TextBlock.Background>
                        <LinearGradientBrush EndPoint="0.5,1" MappingMode="RelativeToBoundingBox" StartPoint="0.5,0">
                            <GradientStop Color="White" Offset="0.968"/>
                            <GradientStop Color="Blue" Offset="0.828"/>
                        </LinearGradientBrush>
                    </TextBlock.Background>
                </TextBlock>
            </DataTemplate>
        </GroupBox.HeaderTemplate>
        <Border x:Name="CanvasBorder" BorderBrush="Blue"  BorderThickness="2" Margin="3,0,3,0">
            <StackPanel>
                <Expander Header="Certificates">
                <StackPanel>
                <TextBox Text="Sample Text is good" Width="100" Height="100"/>
                </StackPanel>
                </Expander>
            </StackPanel>
        </Border>
    </GroupBox>
    </Grid>

</Window>
"@ 
Add-Type -AssemblyName PresentationFramework

$reader=(New-Object System.Xml.XmlNodeReader $xaml)
$Window=[Windows.Markup.XamlReader]::Load( $reader )


[Void]$Window.ShowDialog()
$Window.Focus()
