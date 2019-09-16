<#[XML]$XAML = @"
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
"@ #>

[XML]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="MainWindow" Height="450" Width="650">
       
        <StackPanel Name="stkpanel">
        <Button Name="Btn" Width ="80" Height="30">Click Me</Button>
        <!--<WebBrowser Name="mybrowser" Margin="5 5 5 5" MinWidth="300" MinHeight="500"/> --> 
        </StackPanel>
</Window>
"@

$HTML=@"
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=10" /> 
<style> 
div {
  width: 100px;
  height: 100px;
  background-color: red;
  -webkit-animation-name: example; /* Safari 4.0 - 8.0 */
  -webkit-animation-duration: 4s; /* Safari 4.0 - 8.0 */
  animation-name: example;
  animation-duration: 4s;
}

/* Safari 4.0 - 8.0 */
@-webkit-keyframes example {
  from {background-color: red;}
  to {background-color: yellow;}
}

/* Standard syntax */
@keyframes example {
  from {background-color: red;}
  to {background-color: yellow;}
}
</style>
</head>
<body>

<p><b>Note:</b> This example does not work in Internet Explorer 9 and earlier versions.</p>

<div></div>

<p><b>Note:</b> When an animation is finished, it changes back to its original style.</p>

</body>
</html>
"@
$jspath='D:\jquery\jquery-3.4.1.min.js'

$htmllayout=@"
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script>
`$(document).ready(function(){
       `$("myinput").tooltip();
      var numOfVisibleRows = `$("#mytable tr:visible").length;
      `$("#resbox").val(numOfVisibleRows);
      `$("#searchbtn").click(function(){
          var value = `$("#myInput").val().toLowerCase();
          //alert(value)
          `$("#mytable tr").filter(function() {
              `$(this).toggle(`$(this).text().toLowerCase().indexOf(value) > -1)
            });
        var numOfVisibleRows = `$("#mytable tr:visible").length;
        `$("#resbox").val(numOfVisibleRows);
      });
});
</script>

<script>
`$(document).ready(function(){
  `$("#exportcsv").click(function(){
    var data = `$("#dtBasicExample").first(); //Only one table
    var csvData = [];
    var tmpArr = [];
    var tmpStr = '';
    data.find("tr:visible").each(function() {
        if(`$(this).find("th").length) {
            `$(this).find("th").each(function() {
              tmpStr = `$(this).text().replace(/"/g, '""');
              tmpArr.push('"' + tmpStr + '"');
            });
            csvData.push(tmpArr);
        } else {
            tmpArr = [];
               `$(this).find("td").each(function() {
                  if(`$(this).text().match(/^-{0,1}\d*\.{0,1}\d+`$/)) {
                      tmpArr.push(parseFloat(`$(this).text()));
                  } else {
                      tmpStr = `$(this).text().replace(/"/g, '""');
                      tmpArr.push('"' + tmpStr + '"');
                  }
              });
            csvData.push(tmpArr.join(','));
        }
    });
    var output = csvData.join('\n');
    
    //alert(output);
    var uri = 'data:application/csv;charset=UTF-8,' + encodeURIComponent(output);
    if (window.navigator.msSaveBlob) { // IE 10+
      //alert('IE' + output);
      window.navigator.msSaveOrOpenBlob(new Blob([output], {type: "text/plain;charset=utf-8;"}), "csvname.csv")
      } 
    else {
      `$(this).attr({ 'download': 'export.csv', 'href': uri, 'target': '_blank' }); 
      }
  })
  
});
</script>
<script>
var tableToExcel = (function () {
  var uri = 'data:application/vnd.ms-excel;base64,'
      , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
      , base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) }
      , format = function (s, c) { return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }) }
  return function (table, name) {
      if (!table.nodeType) table = document.getElementById(table)
      var ctx = { worksheet: name || 'Worksheet', table: table.innerHTML }
      var blob = new Blob([format(template, ctx)]);
      var blobURL = window.URL.createObjectURL(blob);

      if (ifIE()) {
          csvData = table.innerHTML;
          if (window.navigator.msSaveBlob) {
              var blob = new Blob([format(template, ctx)], {
                  type: "text/html"
              });
              navigator.msSaveOrOpenBlob(blob, '' + name + '.xls');
          }
      }
      else
      window.location.href = uri + base64(format(template, ctx))
  }
})()

function ifIE() {
  var isIE11 = navigator.userAgent.indexOf(".NET CLR") > -1;
  var isIE11orLess = isIE11 || navigator.appVersion.indexOf("MSIE") != -1;
  return isIE11orLess;
}

`$(document).ready(function(){
  `$("#exportxls").click(function(){
    tableToExcel('dtBasicExample', 'desdata')
  });
});
</script>
<script>
`$(document).ready(function(){
  `$("#exportpdf").click(function(){
    tableToExcel('dtBasicExample', 'desdata')
  });
});
</script>
<style>
body {
  font-family: Arial, Helvetica, sans-serif;
}
.destable {
  font-family: Tahoma, Geneva, sans-serif;
  
  width: 60%;
  text-align: left;
  
}
.destable td, th {
  padding: 5px 4px;
}
.destable td {
  font-size: 11px;
}
.destable tr:hover {background-color: #f5f5f5;}

.destable th {
  background: #772953;
  border-bottom: 1px solid #772953;
  font-size: 10px;
  font-weight: bold;
  color: #FFFFFF;
  text-align: left;
  
}
</style>
</head>
<body>

<h2>Filterable Table</h2>
  
<div class="row">
      <div class="col">
            <div class="input-group input-group-sm mb-3">
                  <input type="text" class="form-control" id="myInput" placeholder="Search.No wildcards" data-toggle="myinputtooltip" title="Search the text!">
                  <div class="input-group-append">
                    <button class="btn btn-success btn-sm" id="searchbtn" type="submit">Search</button> 
                  </div>
            </div>
      </div>
      <div class="col">
            <div class="input-group input-group-sm mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text"># of Rows</span>
                  </div>
                  <input type="text" class="form-control" id="resbox" placeholder="#" readonly style="background-color:transparent"> 
            </div>
      </div>
      
      <div class="col"></div>
      <div class="col">
            <div class="btn-group btn-group-sm">
                  <Button id="exportcsv" class="btn btn-primary">CSV</button>
                  <Button id="exportxls" class="btn btn-success">XLS</button>
                  <Button id="exportpdf" class="btn btn-info">PDF</button>
            </div>
      </div>
      <div class="col"></div>
</div>

</body>
</html>
"@

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms
Add-Type -Path 'C:\Program Files\Reference Assemblies\Microsoft\Framework\v3.0\WindowsFormsIntegration.dll'
$FormReader = New-Object System.Xml.XmlNodeReader $XAML
$WebForm = [Windows.MarkUp.XamlReader]::Load($FormReader)


$Xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name $_.Name -Value $WebForm.FindName($_.Name)}

      $txthost = New-Object System.Windows.Forms.Integration.WindowsFormsHost
      $rtxt = New-Object System.Windows.Forms.RichTextBox
      $txthost.Height = '300'
      $txthost.Width ='600'
      #$rtxt.Height = '300'
      #$rtxt.Width ='400'
      $rtxt.Font = 'Lucida Console'
      $txthost.Child =  $rtxt
      $stkpanel.AddChild($txthost)

<# $Btn.Add_Click({
  $result = Get-Service | Select-Object Name,DisplayName,Status,StartType      
  #$result = Get-Process | Select ProcessName,ID -First 20      
 #$result = gci | select Name, Length,LastwriteTime
  [xml]$Services = $result  | ConvertTo-Html -As Table -Fragment
  $col=for($i=2; $i -le $Services.table.ChildNodes.Count-1;$i++){ "<tr>"+$Services.table.ChildNodes[$i].InnerXml+"</tr>" }
  $thead="<thead><tr>"+$Services.table.ChildNodes[1].InnerXml+"</tr></thead>"
  $col ="<tbody id=`"mytable`">"+$col+"</tbody>"
  $temp =$thead+$col
  $Services.table.InnerXml=$temp
  $class = $Services.CreateAttribute("class")
  #$class.value = 'table table-sm'
  $class.value = 'destable'
  $ID = $Services.CreateAttribute("id")
  $ID.value = 'dtBasicExample'
  $Services.table.Attributes.Append($class)
  $Services.table.Attributes.Append($ID)
  ConvertTo-Html -Body $Services.InnerXml -Head $htmllayout | Out-File D:\sample.html -Force 
        $uri = [uri]::new("D:\sample.html")
        #$mybrowser.Navigate($uri)
        #$uri
        $mybrowser.Navigate($uri)
        #$mybrowser.NavigateToString($uri)
}) #>
#$mybrowser.Navigate("www.google.com")
$Btn.Add_Click({
      $rtxt.Text = Get-ChildItem C:\Temp | Out-String
})


#$listView.Items.Add($person)

#$uri = [uri]::new("https://www.google.com")
#$mybrowser.Navigate($uri)

$WebForm.ShowDialog()

