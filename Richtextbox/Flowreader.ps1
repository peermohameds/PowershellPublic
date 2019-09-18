[XML]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="MainWindow" Height="450" Width="650">
        <StackPanel Name="stkpanel">
        <WrapPanel>
        <Button Name="Btn" Width ="80" Height="30" Margin="10 0">Load Text</Button>
        <Button Name="NxtBtn" Width ="80" Height="30" Margin="10 0">Next</Button>
        </WrapPanel>
        <FlowDocumentReader Name="flowreader" Height="330" Width="600"/>


        <!-- <RichTextBox Name='Rtxt' FontFamily ="Lucida Console" HorizontalScrollBarVisibility = "Auto" 
            VerticalScrollBarVisibility ="Auto" HorizontalAlignment="Left" Height="330" 
                VerticalAlignment="Top" Width="600" Margin ="10"/> -->  
        
                <!--<WebBrowser Name="mybrowser" Margin="5 5 5 5" MinWidth="300" MinHeight="500"/> --> 
        </StackPanel>
</Window>
"@

[xml]$doc=@" 
<FlowDocument FontFamily="Cambria" FontSize="14">
<Paragraph>Some Pixar films:</Paragraph>
<Table>
    <Table.Columns>
        <TableColumn Width="50*"/>
        <TableColumn Width="15*"/>
        <TableColumn />
    </Table.Columns>

    <TableRowGroup Background="LightGray" FontWeight="Bold">
        <TableRow>
            <TableCell><Paragraph>Title</Paragraph></TableCell>
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

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Windows.Forms, System.Drawing
$FormReader = New-Object System.Xml.XmlNodeReader $XAML
$WebForm = [Windows.MarkUp.XamlReader]::Load($FormReader)

$Xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name $_.Name -Value $WebForm.FindName($_.Name)}

$Btn.Add_Click({
    #$doc = New-Object System.Xml.XmlNodeReader $flowdoc
    #[Windows.MarkUp.XamlReader]::Load($doc)
    $flowdoc = [System.Windows.Documents.FlowDocument]::new()
    $docReader = New-Object System.Xml.XmlNodeReader $doc
    $a = [Windows.MarkUp.XamlReader]::Load($docReader)
    $flowdoc.Load($a)
    $flowreader.Document =  $flowdoc
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
  $flowreader.Document = $flowdoc
})

$WebForm.ShowDialog()