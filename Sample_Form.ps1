<# [xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        Title="Wealth Deployment Remote Management" Height="550" Width="725" BorderThickness="2,0" ResizeMode="NoResize" ToolTip="Wealth Deployment Remote Management" WindowStyle="ThreeDBorderWindow"
        Background="#D5DBDB" BorderBrush="FloralWhite">

    <Window.Resources>


        <Style TargetType="Label">
            <Setter Property="FontSize" Value="15"/>
        </Style>


        <Style x:Key="Header" TargetType="TextBlock">
            <Setter Property="Foreground" Value="Crimson"/>
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Foreground" Value="IndianRed"/>
                    <Setter Property="TextDecorations" Value="Underline"/>
                    <Setter Property="FontStretch" Value="Expanded"/>
                </Trigger>
            </Style.Triggers>
        </Style>

        <ControlTemplate x:Key = "ButtonTemplate" TargetType = "Button">

            <Grid>
                <Rectangle x:Name = "ButtonEllipse" Height = "30" Width = "80" >
                    <Rectangle.Fill>
                        <LinearGradientBrush StartPoint = "0,0.2" EndPoint = "0.2,1.4">
                            <GradientStop Offset = "0" Color = "Red" />
                            <GradientStop Offset = "1" Color = "Orange" />
                        </LinearGradientBrush>
                    </Rectangle.Fill>
                </Rectangle>

                <ContentPresenter Content = "{TemplateBinding Content}" 
               HorizontalAlignment = "Center" VerticalAlignment = "Center" />
            </Grid>

            <ControlTemplate.Triggers>

                <Trigger Property = "IsMouseOver" Value = "True">
                    <Setter TargetName = "ButtonEllipse" Property = "Fill" >
                        <Setter.Value>
                            <LinearGradientBrush StartPoint = "0,0.2" EndPoint = "0.2,1.4">
                                <GradientStop Offset = "0" Color = "YellowGreen" />
                                <GradientStop Offset = "1" Color = "Gold" />
                            </LinearGradientBrush>
                        </Setter.Value>
                    </Setter>
                </Trigger>

                <Trigger Property = "IsPressed" Value = "True">
                    <Setter Property = "RenderTransform">
                        <Setter.Value>
                            <ScaleTransform ScaleX = "0.8" ScaleY = "0.8" 
                        CenterX = "0" CenterY = "0"  />
                        </Setter.Value>
                    </Setter>
                    <Setter Property = "RenderTransformOrigin" Value = "0.5,0.5" />
                </Trigger>

            </ControlTemplate.Triggers>

        </ControlTemplate>

        <!-- Standard Button Colors-->
        <SolidColorBrush x:Key="StandardButtonBackground" Color="#1C536F" />
        <SolidColorBrush x:Key="StandardButtonForeground" Color="#FEFEFE" />

        <!-- Standard Button Template-->
        <Style x:Key="StandardButton" TargetType="Button">
            <Setter Property="Background" Value="{StaticResource StandardButtonBackground}" />
            <Setter Property="Foreground" Value="{StaticResource StandardButtonForeground}" />

            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button" x:Name="StdBtn">
                        <Border Name="Std"  CornerRadius="5" Background="{StaticResource StandardButtonBackground}">
                            <ContentPresenter Margin="2" HorizontalAlignment="Center" VerticalAlignment="Center" RecognizesAccessKey="True"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="BorderBrush" TargetName="Std" Value="#F4D03F"/>
                                <Setter Property="BorderThickness" TargetName="Std" Value="2"/>
                                <Setter Property="TextElement.Foreground" TargetName="Std" Value="#F4D03F"/>
                            </Trigger>

                            <Trigger Property = "IsPressed" Value = "True">
                                <Setter Property = "RenderTransform" TargetName="Std">
                                    <Setter.Value>
                                        <ScaleTransform ScaleX = "0.95" ScaleY = "0.95" 
                                            CenterX = "0" CenterY = "0"  />
                                    </Setter.Value>
                                </Setter>
                                <Setter Property = "RenderTransformOrigin" Value = "0.9,0.9" />
                            </Trigger>

                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>


    </Window.Resources>
    <StackPanel>
        <GroupBox >
            <Grid Margin="0 ">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="100"></ColumnDefinition>
                    <ColumnDefinition Width="150"></ColumnDefinition>
                    <ColumnDefinition Width="100"></ColumnDefinition>
                    <ColumnDefinition Width="150"></ColumnDefinition>
                    <ColumnDefinition Width="100"></ColumnDefinition>
                    <ColumnDefinition Width="Auto"></ColumnDefinition>
                </Grid.ColumnDefinitions>
                <Label Content="UserName" Grid.Column="0" FontSize="12"  Margin="0 12" VerticalContentAlignment="Center" HorizontalContentAlignment="Left"></Label>
                <TextBox Name="usrtxtbox" Text="" Width="120" Height="25" Grid.Column="1" Margin="0 12" VerticalContentAlignment="Center" BorderThickness="1" MaxLines="1"></TextBox>
                <Label Content="Password" Grid.Column="2" Margin="0 12" FontSize="12" HorizontalContentAlignment="Left" VerticalContentAlignment="Center"></Label>
                <PasswordBox Name="usrpwdbox" Grid.Column="3" Width="120" Height="25" FontWeight="DemiBold" Margin="0 12" VerticalContentAlignment="Center" BorderThickness="1"></PasswordBox>
                <Button Style="{StaticResource ResourceKey=StandardButton}"  Name="passsubmit" Width="80"  Content="Submit" BorderBrush="MediumBlue" Foreground="FloralWhite" Grid.Column="4" FontWeight="DemiBold" Margin="0 12" Background="DimGray"  BorderThickness="0,0,0,0.5">
                </Button>
                <TextBlock Style="{StaticResource Header}" Grid.Column="5" Name="Msgtxtblk" Text="16:21:19" FontWeight="DemiBold" FontSize="16" Margin="10" HorizontalAlignment="Center" VerticalAlignment="Center"></TextBlock>
            </Grid>
        </GroupBox>

        <TabControl Name="tabControl" VerticalAlignment="Top" Width="700" Margin="5">
            <TabItem Header="Command">
                <Grid>
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="1*"/>
                        <ColumnDefinition Width="3*"/>
                    </Grid.ColumnDefinitions>
                    <StackPanel Grid.Column="0" Background="#212F3C">
                        <Label FontSize="12" Foreground="#F4D03F" HorizontalAlignment="Center" FontWeight="DemiBold">Commands</Label>
                        <ListBox Name="cmds" Background="#212F3C" Height="350" Margin="0 0 ">
                            <ListBox.ItemContainerStyle>
                                <Style TargetType="ListBoxItem">
                                    <Setter Property="Template">
                                        <Setter.Value>
                                            <ControlTemplate TargetType="ListBoxItem">

                                                <Border BorderThickness="{TemplateBinding Border.BorderThickness}"
                  Padding="{TemplateBinding Control.Padding}"
                  BorderBrush="{TemplateBinding Border.BorderBrush}"
                  Background="{TemplateBinding Panel.Background}"
                  Name="Bd"
                  SnapsToDevicePixels="True">

                                                    <ContentPresenter Content="{TemplateBinding ContentControl.Content}"
                               ContentTemplate="{TemplateBinding ContentControl.ContentTemplate}"
                               ContentStringFormat="{TemplateBinding ContentControl.ContentStringFormat}"
                               HorizontalAlignment="{TemplateBinding Control.HorizontalContentAlignment}"
                               VerticalAlignment="{TemplateBinding Control.VerticalContentAlignment}"
                               SnapsToDevicePixels="{TemplateBinding UIElement.SnapsToDevicePixels}"/>

                                                </Border>
                                                <ControlTemplate.Triggers>
                                                    <MultiTrigger>
                                                        <MultiTrigger.Conditions>
                                                            <Condition Property="Selector.IsSelectionActive" Value="False"/>
                                                            <Condition Property="Selector.IsSelected" Value="True"/>
                                                        </MultiTrigger.Conditions>
                                                        <Setter Property="Panel.Background" TargetName="Bd" Value="Transparent"/>
                                                        <Setter Property="Border.BorderBrush" TargetName="Bd">
                                                            <Setter.Value>
                                                                <SolidColorBrush>#FFDADADA</SolidColorBrush>
                                                            </Setter.Value>
                                                        </Setter>
                                                    </MultiTrigger>
                                                    <MultiTrigger>
                                                        <MultiTrigger.Conditions>
                                                            <Condition Property="Selector.IsSelectionActive" Value="True"/>
                                                            <Condition Property="Selector.IsSelected" Value="True"/>
                                                        </MultiTrigger.Conditions>
                                                        <Setter Property="Panel.Background" TargetName="Bd" Value="Transparent"/>
                                                        <Setter Property="TextElement.Background" TargetName="Bd" Value="Transparent"/>
                                                        <Setter Property="TextElement.Foreground" TargetName="Bd" Value="#F4D03F"/>
                                                        <Setter Property="Border.BorderBrush" TargetName="Bd">
                                                            <Setter.Value>
                                                                <SolidColorBrush>#FF26A0DA</SolidColorBrush>
                                                            </Setter.Value>
                                                        </Setter>
                                                    </MultiTrigger>
                                                    <Trigger Property="UIElement.IsMouseOver" Value="True">
                                                        <Setter Property="Panel.Background" TargetName="Bd"  
                                                                Value="Transparent"/>
                                                        <Setter Property="TextElement.Foreground" TargetName="Bd" Value="#F4D03F"/>
                                                        <Setter Property="TextElement.FontWeight" TargetName="Bd" Value="DemiBold"/>
                                                        <Setter Property="Border.BorderBrush" TargetName="Bd">
                                                            <Setter.Value>
                                                                <SolidColorBrush>#A826A0DA</SolidColorBrush>
                                                            </Setter.Value>
                                                        </Setter>
                                                    </Trigger>
                                                    <Trigger Property="UIElement.IsEnabled" Value="False">
                                                        <Setter Property="TextElement.Foreground" TargetName="Bd" Value="#174973"/>
                                                        <Setter Property="TextElement.Background" TargetName="Bd" Value="FloralWhite"/>

                                                    </Trigger>
                                                </ControlTemplate.Triggers>
                                            </ControlTemplate>
                                        </Setter.Value>
                                    </Setter>
                                </Style>

                            </ListBox.ItemContainerStyle>
                            <ListBoxItem Foreground="White" FontSize="13" Padding="1" Margin="5">Load Servers</ListBoxItem>
                            <ListBoxItem Foreground="White" FontSize="13" Padding="1" Margin="5">Get Diskinfo</ListBoxItem>
                            <ListBoxItem Foreground="White" FontSize="13" Padding="1" Margin="5">Check Uptime</ListBoxItem>
                            <ListBoxItem Foreground="White" FontSize="13" Padding="1" Margin="5">Get installedApps</ListBoxItem>
                        </ListBox>

                    </StackPanel>

                    <StackPanel Grid.Column="1" Height="120" VerticalAlignment="Top">
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="2*"/>
                                <ColumnDefinition Width="2*"/>
                                <ColumnDefinition Width="2*"/>
                                <ColumnDefinition Width="1*"/>
                            </Grid.ColumnDefinitions>
                              <StackPanel Grid.Column="0" VerticalAlignment="Top">
                                    <Label Content="Server Names" Margin="0" FontSize="12" HorizontalAlignment="Center"/>
                                <TextBox Name="Serversinput" TextWrapping="Wrap" AcceptsReturn="True" ScrollViewer.VerticalScrollBarVisibility="Auto" Height="90" Margin="5 0 5 5"></TextBox>
                                </StackPanel>
                            <StackPanel Grid.Column="1" VerticalAlignment="Top">
                                <Label Content="Parameters" Margin="0" FontSize="12" HorizontalAlignment="Center"/>
                                <TextBox Name="Paramtext" TextWrapping="Wrap" AcceptsReturn="True" ScrollViewer.VerticalScrollBarVisibility="Auto" Height="90" Margin="5 0 5 5"></TextBox>
                            </StackPanel>
                            <GroupBox Grid.Column="2" Grid.ColumnSpan="2"  Margin="5">
                                
                            </GroupBox>
                            
                        </Grid>
                        
                    </StackPanel> 
                       <DataGrid Grid.Row="1" Height="230" Width="510" Margin="5 5 0 0" Name="Outgrid" AutoGenerateColumns="True" 
                        HorizontalAlignment="Left"/> 
                </Grid>
            </TabItem>
            
            <TabItem Header="Result">
                <Grid Background="#FFE5E5E5">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="9*"/>
                        <RowDefinition Height="1*"/>
                    </Grid.RowDefinitions>
                    <RichTextBox Grid.Row="1" Margin="1 1 1 1"  Name="outputtextbox" HorizontalContentAlignment="Left" HorizontalAlignment="Left" VerticalAlignment="Top" Height="390" Width="690"/><RichTextBox Grid.Row="1" Margin="1 1 1 1"  Name="outtextbox" HorizontalContentAlignment="Left" HorizontalAlignment="Left" VerticalAlignment="Top" Height="390" Width="690"/>
                </Grid>

            </TabItem>

            <TabItem Header="Data">
                <Grid Background="#FFE5E5E5">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="9*"/>
                        <RowDefinition Height="1*"/>
                    </Grid.RowDefinitions>
                <DataGrid Grid.Row="1" Height="230" Width="510" Margin="5 5 0 0" Name="datagrid" AutoGenerateColumns="True" 
                        HorizontalAlignment="Left"/>
                </Grid>

            </TabItem>
        </TabControl>


    </StackPanel>
</Window>


"@ #>
Add-Type -AssemblyName PresentationFramework

[xml]$xaml = Get-Content E:\Powershell\XAML\FormStyles.xaml
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)
#$button = $window.FindName("btnStatus")
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name $_.Name -Value $window.FindName($_.Name)}
#$txtBox = $window.FindName("PathTextBox")

$outtxtboxfilter.Add_click({

Get-Service | Out-GridView -PassThru

})
$passsubmit.Add_Click({
        

            
       $Service=Get-Service | Select Name, Displayname,Status # | ConvertTo-Html -CssUri C:\Users\Peer\Documents\Outstyle.css | Out-File C:\Users\Peer\Documents\Output.Html

       # $Resultgrid.ItemsSource=$Service

     <#  $PrgBar.Value=0
       $PrgBar.Maximum=30

       for($i=0;$i -le $PrgBar.Maximum;$i++){
       
       Start-Sleep 1
       $PrgBar.Value++
       $PrgBar.Dispatcher.Invoke([Action]{},"Render")
       
       }
        
       #> 
     
     
})
$res=[pscustomobject]@{Name="Peer";DisplayName="Peer Mohamed";Status="Good"}
Write-Host $res
#$Resultgrid.AddChild($res)
$window.ShowDialog() | Out-Null