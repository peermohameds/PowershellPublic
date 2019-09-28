$pre = "<FlowDocument xml:space=`"preserve`" xmlns=`"http://schemas.microsoft.com/winfx/2006/xaml/presentation`"
FontFamily=`"Cambria`" FontSize=`"14`">"
$table = "<Table><Table.Columns>"

$object = Get-Service | Select-Object Name,Status -First 10
$props = $object[0].PSObject.Properties.Name

$table += $props | % { "<TableColumn/>"}
$table += "</Table.Columns><TableRowGroup Background=`"LightGray`" FontWeight=`"Bold`"><TableRow>"
$table += Foreach ($p in $props){
            "<TableCell><Paragraph>$p</Paragraph></TableCell>"
        }
$table +="</TableRow></TableRowGroup><TableRowGroup FontFamily=`"Verdana`" FontSize=`"12`">"

$table += foreach ($obj in $object){
    $cell = "<TableRow>"
    $cell += Foreach ($p in $props){
        "<TableCell><Paragraph>$($obj.$p)</Paragraph></TableCell>"
    }
    $cell += "</TableRow>"
    $cell
}

$table +="</TableRowGroup></Table></FlowDocument>"
[xml]$result = $pre+$table


