#Requires -Modules psake
[cmdletbinding()]
param(
    [ValidateSet('Init','Analyze','Clean','Build','Test','Zip')] #,'BuildHelp','BuildTests','Install','Publish','Sign','ExportFunctionsToSrc'
    [string[]]$Task
)

Import-Module psake;Import-Module Pester;Import-Module PSScriptAnalyzer; Import-Module BuildHelpers
Set-BuildEnvironment -Force
Invoke-psake -buildFile "$PSScriptRoot\psake.ps1" -taskList $Task -nologo -Verbose:$VerbosePreference
exit ( [int]( -not $psake.build_success ) )