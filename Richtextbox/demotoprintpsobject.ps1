[XML]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="MainWindow" Height="450" Width="650">
        <StackPanel Name="stkpanel">
        <WrapPanel>
        <Button Name="Btn" Width ="80" Height="30" Margin="10 0">Load Text</Button>
        <Button Name="NxtBtn" Width ="80" Height="30" Margin="10 0">Next</Button>
        </WrapPanel>
        <RichTextBox Name='Rtxt' FontFamily ="Consolas" HorizontalScrollBarVisibility = "Auto" 
            VerticalScrollBarVisibility ="Auto" HorizontalAlignment="Left" Height="330" 
                VerticalAlignment="Top" Width="600" Margin ="10"/>  
        
                <!--<WebBrowser Name="mybrowser" Margin="5 5 5 5" MinWidth="300" MinHeight="500"/> --> 
        </StackPanel>
</Window>
"@

<# [XML]$doc=@"
<FlowDocument xml:space="preserve" xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation">

    <Table CellSpacing="5">

      <Table.Columns>
        <TableColumn/>
        <TableColumn/>
        <TableColumn/>
        <TableColumn/>
      </Table.Columns>

      <TableRowGroup>

        <!-- Title row for the table. -->
        <TableRow Background="SkyBlue" Foreground="White">
          <TableCell ColumnSpan="4" TextAlignment="Center">
            <Paragraph FontSize="24pt" FontWeight="Bold" ToolTip="New Item Peer">Planetary Information</Paragraph>
          </TableCell>
        </TableRow>

        <!-- Header row for the table. -->
        <TableRow Background="LightGoldenrodYellow">
          <TableCell BorderThickness="1" BorderBrush="Red" TextAlignment="Center"><Paragraph FontSize="14pt" FontWeight="Bold">Planet</Paragraph></TableCell>
          <TableCell><Paragraph FontSize="14pt" FontWeight="Bold">Mean Distance from Sun</Paragraph></TableCell>
          <TableCell><Paragraph FontSize="14pt" FontWeight="Bold">Mean Diameter</Paragraph></TableCell>
          <TableCell><Paragraph FontSize="14pt" FontWeight="Bold">Approximate Mass</Paragraph></TableCell>
        </TableRow>

        <!-- Sub-title row for the inner planets. -->
        <TableRow>
          <TableCell ColumnSpan="4"><Paragraph FontSize="14pt" FontWeight="Bold">The Inner Planets</Paragraph></TableCell>
        </TableRow>

        <!-- Four data rows for the inner planets. -->
        <TableRow>
          <TableCell><Paragraph>Mercury</Paragraph></TableCell>
          <TableCell><Paragraph>57,910,000 km</Paragraph></TableCell>
          <TableCell><Paragraph>4,880 km</Paragraph></TableCell>
          <TableCell><Paragraph>3.30e23 kg</Paragraph></TableCell>
        </TableRow>
        <TableRow Background="lightgray">
          <TableCell><Paragraph>Venus</Paragraph></TableCell>
          <TableCell><Paragraph>108,200,000 km</Paragraph></TableCell>
          <TableCell><Paragraph>12,103.6 km</Paragraph></TableCell>
          <TableCell><Paragraph>4.869e24 kg</Paragraph></TableCell>
        </TableRow>
        <TableRow>
          <TableCell><Paragraph>Earth</Paragraph></TableCell>
          <TableCell><Paragraph>149,600,000 km</Paragraph></TableCell>
          <TableCell><Paragraph>12,756.3 km</Paragraph></TableCell>
          <TableCell><Paragraph>5.972e24 kg</Paragraph></TableCell>
        </TableRow>
        <TableRow Background="lightgray">
          <TableCell><Paragraph>Mars</Paragraph></TableCell>
          <TableCell><Paragraph>227,940,000 km</Paragraph></TableCell>
          <TableCell><Paragraph>6,794 km</Paragraph></TableCell>
          <TableCell><Paragraph>6.4219e23 kg</Paragraph></TableCell>
        </TableRow>

        <!-- Sub-title row for the outter planets. -->
        <TableRow>
          <TableCell ColumnSpan="4"><Paragraph FontSize="14pt" FontWeight="Bold">The Major Outer Planets</Paragraph></TableCell>
        </TableRow>

        <!-- Four data rows for the major outter planets. -->
        <TableRow>
          <TableCell><Paragraph>Jupiter</Paragraph></TableCell>
          <TableCell><Paragraph>778,330,000 km</Paragraph></TableCell>
          <TableCell><Paragraph>142,984 km</Paragraph></TableCell>
          <TableCell><Paragraph>1.900e27 kg</Paragraph></TableCell>
        </TableRow>
        <TableRow Background="lightgray">
          <TableCell><Paragraph>Saturn</Paragraph></TableCell>
          <TableCell><Paragraph>1,429,400,000 km</Paragraph></TableCell>
          <TableCell><Paragraph>120,536 km</Paragraph></TableCell>
          <TableCell><Paragraph>5.68e26 kg</Paragraph></TableCell>
        </TableRow>
        <TableRow>
          <TableCell><Paragraph>Uranus</Paragraph></TableCell>
          <TableCell><Paragraph>2,870,990,000 km</Paragraph></TableCell>
          <TableCell><Paragraph>51,118 km</Paragraph></TableCell>
          <TableCell><Paragraph>8.683e25 kg</Paragraph></TableCell>
        </TableRow>
        <TableRow Background="lightgray">
          <TableCell><Paragraph>Neptune</Paragraph></TableCell>
          <TableCell><Paragraph>4,504,000,000 km</Paragraph></TableCell>
          <TableCell><Paragraph>49,532 km</Paragraph></TableCell>
          <TableCell><Paragraph>1.0247e26 kg</Paragraph></TableCell>
        </TableRow>

        <!-- Footer row for the table. -->
        <TableRow>
          <TableCell ColumnSpan="4"><Paragraph FontSize="10pt" FontStyle="Italic">
            Information from the 
            <Hyperlink NavigateUri="http://encarta.msn.com/encnet/refpages/artcenter.aspx">Encarta</Hyperlink> 
            web site.
            </Paragraph></TableCell>
        </TableRow>
      
      </TableRowGroup>
    </Table>
  </FlowDocument>
"@ #>
<# [xml]$doc=@"
<FlowDocument xml:space="preserve" xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    FontFamily="Cambria" FontSize="14">
    <Paragraph>Some Pixar films:</Paragraph>
    <Table>
        <Table.Columns>
            <TableColumn Width="50*"/>
            <TableColumn Width="15*"/>
            <TableColumn />
        </Table.Columns>
 
        <TableRowGroup Background="LightGray" FontWeight="Bold">
            <TableRow>
                <TableCell ToolTip="Hello"><Paragraph>Title</Paragraph></TableCell>
                <TableCell><Paragraph>Year</Paragraph></TableCell>
                <TableCell><Paragraph>Director</Paragraph></TableCell>
            </TableRow>
        </TableRowGroup>
 
        <TableRowGroup FontFamily="Verdana" FontSize="12">
            <TableRow>
                <TableCell><Paragraph>Toy Story</Paragraph></TableCell>
                <TableCell><Paragraph>1995</Paragraph></TableCell>
                <TableCell><Paragraph>John Lasseter</Paragraph></TableCell>
            </TableRow>
            <TableRow>
                <TableCell><Paragraph>Monster's, Inc.</Paragraph></TableCell>
                <TableCell><Paragraph>2001</Paragraph></TableCell>
                <TableCell><Paragraph>Pete Docter</Paragraph></TableCell>
            </TableRow>
            <TableRow>
                <TableCell><Paragraph>The Incredibles</Paragraph></TableCell>
                <TableCell><Paragraph>2004</Paragraph></TableCell>
                <TableCell><Paragraph>Brad Bird</Paragraph></TableCell>
            </TableRow>
        </TableRowGroup>
    </Table>
</FlowDocument>
"@
 #>

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

Function ConvertTo-FlowDocument{
    $pre = "<FlowDocument xml:space=`"preserve`" xmlns=`"http://schemas.microsoft.com/winfx/2006/xaml/presentation`"
    FontFamily=`"Tahoma`" FontSize=`"10`">"
    $table = "<Paragraph FontFamily=`"Segoe UI`" FontSize=`"18`">Sample Output</Paragraph><Table><Table.Columns>"
    
    #$object = Get-Service | Select-Object Name,Status,StartType,DisplayName
    $object = Get-ChildItem | Select LastWriteTime, Length,Name,FullName
    $props = $object[0].PSObject.Properties.Name
    
    $table += $props | % { "<TableColumn/>"}
    $table += "</Table.Columns><TableRowGroup><TableRow FontFamily=`"Consolas`" Background=`"LightGray`" FontWeight=`"Bold`">"
    $table += Foreach ($p in $props){
                "<TableCell><Paragraph>$p</Paragraph></TableCell>"
            }
    $table +="</TableRow>"
    
    $table += foreach ($obj in $object){
        $cell = "<TableRow>"
        $cell += Foreach ($p in $props){
            if ($p -eq 'Status'){
                if ($($obj.$p) -ne "Running"){
                    "<TableCell Foreground=`"Red`"><Paragraph>$($obj.$p)</Paragraph></TableCell>"
                }else{
                    "<TableCell><Paragraph>$($obj.$p)</Paragraph></TableCell>"
                }
            }else{
                "<TableCell><Paragraph>$($obj.$p)</Paragraph></TableCell>"
            }
        }
        $cell += "</TableRow>"
        $cell
    }
    
    $table +="</TableRowGroup></Table></FlowDocument>"
    [xml]$result = $pre+$table
    Write-Output $result
}

$Btn.Add_Click({
  $ser = Get-Service | select Name,Status | Out-String -Stream
  $datatable = [System.Data.DataTable]::new()
  $props = $services[0].PSObject.Properties.Name
  $props | ForEach-Object { $null = $datatable.Columns.Add($PSItem)}
  $datatable.Rows.Clear()
  
  Foreach ($s in $services){
      $newrow = $datatable.NewRow()
         $props| % { $newrow.Item($psitem)=if ($s.$PSItem -ne $null){$s.$PSItem} }
      $datatable.Rows.Add($newrow)
  }
  $TextRange = [System.Windows.Documents.TextRange]::new($rtxt.Document.ContentEnd,$rtxt.Document.ContentEnd)
  $TextRange.Text = $Ser[1]
  $TextRange.ApplyPropertyValue([System.Windows.Documents.TextElement]::FontWeightProperty,"Bold")
  $TextRange.ApplyPropertyValue([System.Windows.Documents.TextElement]::ForegroundProperty,"Red")   
  
       
  3..$ser.Length | %{ 
    $TextRange = [System.Windows.Documents.TextRange]::new($rtxt.Document.ContentEnd,$rtxt.Document.ContentEnd)
    $TextRange.Text = "`n$($Ser[$_])" 
    $TextRange.ApplyPropertyValue([System.Windows.Documents.TextElement]::ForegroundProperty,"Black")
    $TextRange.ApplyPropertyValue([System.Windows.Documents.TextElement]::FontWeightProperty,[System.Windows.FontWeights]::Regular)  
    }
    <# $TextRange = [System.Windows.Documents.TextRange]::new($rtxt.Document.ContentEnd,$rtxt.Document.ContentEnd)
    $TextRange.Text = "Welcome"
    $TextRange.ApplyPropertyValue([System.Windows.Documents.TextElement]::FontWeightProperty,"Bold")  
    $TextRange.ApplyPropertyValue([System.Windows.Documents.TextElement]::ForegroundProperty,"Red")  #> 
    
})

$NxtBtn.Add_Click({
  <# $flowdoc =[System.Windows.Documents.FlowDocument]::new()
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
  $Rtxt.Document = $flowdoc #>
    $doc = ConvertTo-FlowDocument
    $DocReader = New-Object System.Xml.XmlNodeReader $doc
    $flowdoc = [Windows.MarkUp.XamlReader]::Load($DocReader)
    $Rtxt.Document = $flowdoc 
    #$fldocument =[System.Windows.Documents.FlowDocument]::new()
})
$WebForm.
$WebForm.ShowDialog()

