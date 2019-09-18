[XML]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="MainWindow" Height="450" Width="650">
        <StackPanel Name="stkpanel">
        <WrapPanel>
        <Button Name="Btn" Width ="80" Height="30" Margin="10 0">Load Text</Button>
        <Button Name="NxtBtn" Width ="80" Height="30" Margin="10 0">Next</Button>
        </WrapPanel>
        <RichTextBox Name='Rtxt' FontFamily ="Lucida Console" HorizontalScrollBarVisibility = "Auto" 
            VerticalScrollBarVisibility ="Auto" HorizontalAlignment="Left" Height="330" 
                VerticalAlignment="Top" Width="600" Margin ="10"/>  
        
                <!--<WebBrowser Name="mybrowser" Margin="5 5 5 5" MinWidth="300" MinHeight="500"/> --> 
        </StackPanel>
</Window>
"@


Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Windows.Forms, System.Drawing
$FormReader = New-Object System.Xml.XmlNodeReader $XAML
$WebForm = [Windows.MarkUp.XamlReader]::Load($FormReader)


$Xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name $_.Name -Value $WebForm.FindName($_.Name)}

function Format-RichTextBox {  
#https://msdn.microsoft.com/en-us/library/system.windows.documents.textelement(v=vs.110).aspx#Propertiesshut  
param (  
    [parameter(Position=0, Mandatory=$true, ValueFromPipelineByPropertyName=$true)]  
    [System.Windows.Controls.RichTextBox]$RichTextBoxControl,  
    [String]$Text,  
    [String]$ForeGroundColor = 'Black',  
    [String]$BackGroundColor = 'White',  
    [String]$FontSize = '12',  
    [String]$FontStyle = 'Normal',  
    [String]$FontWeight = 'Normal',  
    [Switch]$NewLine  
)  
    $ParamOptions = $PSBoundParameters  
    $RichTextRange = New-Object System.Windows.Documents.TextRange(<#$RichTextBoxControl.Document.ContentStart#>$RichTextBoxControl.Document.ContentEnd, $RichTextBoxControl.Document.ContentEnd)  
    if ($ParamOptions.ContainsKey('NewLine')) {  
        $RichTextRange.Text = "`n$Text"  
    }  
    else {  
        $RichTextRange.Text = $Text  
    }  

    $Defaults = @{ForeGroundColor='Black';BackGroundColor='White';FontSize='12'; FontStyle='Normal'; FontWeight='Normal'}  
    foreach ($Key in $Defaults.Keys) {  
        if ($ParamOptions.Keys -notcontains $Key) {  
        $ParamOptions.Add($Key, $Defaults[$Key])  
        }  
    }   

    $AllParameters = $ParamOptions.Keys | Where-Object {@('RichTextBoxControl','Text','NewLine') -notcontains $_}  
    foreach ($SelectedParam in $AllParameters) {  
        if ($SelectedParam -eq 'ForeGroundColor') {$TextElement = [System.Windows.Documents.TextElement]::ForegroundProperty}  
        elseif ($SelectedParam -eq 'BackGroundColor') {$TextElement = [System.Windows.Documents.TextElement]::BackgroundProperty}  
        elseif ($SelectedParam -eq 'FontSize') {$TextElement = [System.Windows.Documents.TextElement]::FontSizeProperty}  
        elseif ($SelectedParam -eq 'FontStyle') {$TextElement = [System.Windows.Documents.TextElement]::FontStyleProperty}  
        elseif ($SelectedParam -eq 'FontWeight') {$TextElement = [System.Windows.Documents.TextElement]::FontWeightProperty}  
        $RichTextRange.ApplyPropertyValue($TextElement, $ParamOptions[$SelectedParam])  
    }  
}


$Btn.Add_Click({
    $TextRange = [System.Windows.Documents.TextRange]::new($rtxt.Document.ContentEnd,$rtxt.Document.ContentEnd)
    #$TextRange.ApplyPropertyValue([System.Windows.Documents.TextElement]::FontWeightProperty,"Normal")  
    $TextRange.Text = "Hello Guys `n"
    
    
    $TextRange = [System.Windows.Documents.TextRange]::new($rtxt.Document.ContentEnd,$rtxt.Document.ContentEnd)
    $TextRange.Text = "Welcome"
    $TextRange.ApplyPropertyValue([System.Windows.Documents.TextElement]::ForegroundProperty,"Red")  
    
})

$NxtBtn.Add_Click({
  $flowdoc =[System.Windows.Documents.FlowDocument]::new()
  $para = [System.Windows.Documents.Paragraph]::new()
  $para.Inlines.Add("Hello Bro")
  $bold = [System.Windows.Documents.Bold]::new()
  $bold.Inlines.Add(" Welcome")
  $para.Inlines.Add($bold)
 
  $para.Inlines.Add("`n In the example below, three paragraphs are defined under one Section. The section has a Background property value of Red, therefore the background color of the paragraphs is also red.")
  $flowdoc.Blocks.Add($para)
  $para1 = [System.Windows.Documents.Paragraph]::new()
  $bold1 = [System.Windows.Documents.Bold]::new()
  $bold1.Inlines.Add("`n Subject")
  $para1.Inlines.Add($bold1)
  $para1.Inlines.Add("`n In the example below, three paragraphs are defined under one Section. The section has a Background property value of Red, therefore the background color of the paragraphs is also red.")
  $table = [System.Windows.Documents.Table]::new()
  #$table.BorderThickness = '2'
 
  $flowdoc.Blocks.Add($para1)
  $flowdoc.Blocks.Add($table)
  $Rtxt.Document = $flowdoc

})

$WebForm.ShowDialog()

