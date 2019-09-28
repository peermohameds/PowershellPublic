Function Invoke-InputBox {
 
    [cmdletbinding(DefaultParameterSetName="plain")]
    [OutputType([system.string],ParameterSetName='plain')]
    [OutputType([system.security.securestring],ParameterSetName='secure')]
 
    Param(
        [Parameter(ParameterSetName="secure")]
        [Parameter(HelpMessage = "Enter the title for the input box. No more than 25 characters.",
        ParameterSetName="plain")]        
 
        [ValidateNotNullorEmpty()]
        [ValidateScript({$_.length -le 25})]
        [string]$Title = "User Input",
 
        [Parameter(ParameterSetName="secure")]        
        [Parameter(HelpMessage = "Enter a prompt. No more than 50 characters.",ParameterSetName="plain")]
        [ValidateNotNullorEmpty()]
        [ValidateScript({$_.length -le 50})]
        [string]$Prompt = "Please enter a value:",
        
        [Parameter(HelpMessage = "Use to mask the entry and return a secure string.",
        ParameterSetName="secure")]
        [switch]$AsSecureString
    )
 
    if ($PSEdition -eq 'Core') {
        Write-Warning "Sorry. This command will not run on PowerShell Core."
        #bail out
        Return
    }
 
    Add-Type -AssemblyName PresentationFramework
    Add-Type –assemblyName PresentationCore
    Add-Type –assemblyName WindowsBase
 
    #remove the variable because it might get cached in the ISE or VS Code
    Remove-Variable -Name myInput -Scope script -ErrorAction SilentlyContinue
 
    $form = New-Object System.Windows.Window
    $stack = New-object System.Windows.Controls.StackPanel
 
    #define what it looks like
    $form.Title = $title
    $form.Height = 150
    $form.Width = 350
 
    $label = New-Object System.Windows.Controls.Label
    $label.Content = "    $Prompt"
    $label.HorizontalAlignment = "left"
    $stack.AddChild($label)
 
    if ($AsSecureString) {
        $inputbox = New-Object System.Windows.Controls.PasswordBox
    }
    else {
        $inputbox = New-Object System.Windows.Controls.TextBox
    }
 
    $inputbox.Width = 300
    $inputbox.HorizontalAlignment = "center"
 
    $stack.AddChild($inputbox)
 
    $space = new-object System.Windows.Controls.Label
    $space.Height = 10
    $stack.AddChild($space)
 
    $btn = New-Object System.Windows.Controls.Button
    $btn.Content = "_OK"
 
    $btn.Width = 65
    $btn.HorizontalAlignment = "center"
    $btn.VerticalAlignment = "bottom"
 
    #add an event handler
    $btn.Add_click( {
            if ($AsSecureString) {
                $script:myInput = $inputbox.SecurePassword
            }
            else {
                $script:myInput = $inputbox.text
            }
            $form.Close()
        })
 
    $stack.AddChild($btn)
    $space2 = new-object System.Windows.Controls.Label
    $space2.Height = 10
    $stack.AddChild($space2)
 
    $btn2 = New-Object System.Windows.Controls.Button
    $btn2.Content = "_Cancel"
 
    $btn2.Width = 65
    $btn2.HorizontalAlignment = "center"
    $btn2.VerticalAlignment = "bottom"
 
    #add an event handler
    $btn2.Add_click( {
            $form.Close()
        })
 
    $stack.AddChild($btn2)
 
    #add the stack to the form
    $form.AddChild($stack)
 
    #show the form
    $inputbox.Focus() | Out-Null
    $form.WindowStartupLocation = [System.Windows.WindowStartupLocation]::CenterScreen
 
    $form.ShowDialog() | out-null
 
    #write the result from the input box back to the pipeline
    $script:myInput
 
}

$p = Invoke-InputBox