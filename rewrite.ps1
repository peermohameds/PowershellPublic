    $site = "iis:\sites\Default Web Site"
    $name = 'xfhBlock'
    $root = 'system.webServer/rewrite/rules'
    $filter = "{0}/rule[@name='{1}']" -f $root, $name
#Create HTTPS Redirect

    #$FilterHTTPSredirect = "system.webServer/rewrite/rules/rule[@name='xfhblock$_']"
    #Clear-WebConfiguration -pspath $site -filter $FilterHTTPSredirect
    Add-WebConfigurationProperty -PSPath $site -filter "system.webServer/rewrite/rules" -name '.' -value @{name=$name; patterSyntax='Regular Expressions'; stopProcessing='False'}
    Set-WebConfigurationProperty -PSPath $site -filter "$Filter/match" -name 'url' -value "(.*)"
    Set-WebConfigurationProperty -PSPath $site -filter "$Filter/conditions" -name '.' -value @{input='{X-FORWARDED-HOST}'; matchType='0'; pattern='http://win-2k19-gui.man.go'; ignoreCase='True'; negate='True'}
    Set-WebConfigurationProperty -PSPath $site -filter "$Filter/action" -name 'type' -value 'Redirect'
    Set-WebConfigurationProperty -PSPath $site -filter "$Filter/action" -name 'url' -value 'http://win-2k19-gui.man.go'
