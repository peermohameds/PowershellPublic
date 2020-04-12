#Psake properties with locations of the files.
Properties{
        # Find the build folder based on build system
        $ProjectRoot = $env:BHProjectPath
        $ModuleName = $env:BHProjectName
        $manifest = $env:BHPSModuleManifest
        $SourcePath =   $env:BHProjectPath
        $ModuleVersion = (Get-Module -ListAvailable $manifest).Version
        $PSVersion       = $PSVersionTable.PSVersion.ToString()
        $BuildFolder = "$ProjectRoot\_Package\$ModuleName"
        $VersionFolder = "$BuildFolder\$ModuleVersion"
        $ZipFolder = "$ProjectRoot\_Zip"
        $Zipfile = "$ZipFolder\$($ModuleName)_$($ModuleVersion).zip"
        $TestsFolder = "$ProjectRoot\tests"
        $Testsoutput = "$ProjectRoot\tests\BuildTimeTest.xml"
        $DocsRootDir = "$ProjectRoot\docs"

}

Task Default -depends Zip

Task init{
    "`nSTATUS: Testing with PowerShell $PSVersion"
    "Build System Details:"
    Get-Item ENV:BH*
    $modules = 'Pester', 'PSScriptAnalyzer'
    Import-Module $modules -Verbose:$false -Force
} -description 'Initialize build environment'

task Analyze -Depends Init {
    "`nSTATUS: Analyzing files with PSScriptAnalyzer"
    $saResults = Invoke-ScriptAnalyzer -Path "$env:BHModulePath\Public\" -Severity ParseError,Error -Recurse -Verbose:$false
    if ($saResults) {
        $saResults | Format-Table
        Write-Error -Message 'One or more Script Analyzer errors/warnings where found. Build cannot continue!'
    }
} -description 'Analyze the script files'

task clean -depends init{
    "`nSTATUS: Cleaning Buildout destination"
    if (test-path $BuildFolder) {
        Remove-Item "$BuildFolder\*" -Recurse -Force
    }
}

task test {
    Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue
    Write-Host "Testing Module"  -ForegroundColor Blue
    $HelpResults = Invoke-Pester $TestsFolder -OutputFormat NUnitXml -OutputFile $TestsOutput -PassThru
    If ($HelpResults.FailedCount -gt 0) {
        Exit $HelpResults.FailedCount
    }
}

Task BuildHelp {
    if (!(Get-Module platyPS -ListAvailable)) {
        "platyPS module is not installed. Skipping $($psake.context.currentTaskName) task."
        return
    }

    if (!(Get-ChildItem -LiteralPath $DocsRootDir -Filter *.md -Recurse -ErrorAction SilentlyContinue)) {
        "No markdown help files to process. Skipping $($psake.context.currentTaskName) task."
        return
    }
    "Buiding Help Files"
    #$helpLocales = (Get-ChildItem -Path $DocsRootDir -Directory).Name

    # Generate the module's primary MAML help file.
    #foreach ($locale in $helpLocales) {
    $markSplatting=@{
        Path        =   $DocsRootDir
        OutputPath  =   $SourcePath
        ErrorAction =   "SilentlyContinue"
        Verbose     =   $VerbosePreference
    }
    New-ExternalHelp @markSplatting > $null
    #}
}

task build -depends init,Analyze,clean,test,BuildHelp{
    "`nSTATUS: Starting Build"
    If (-not (Test-Path $BuildFolder)) {
        Write-Host "Creating Build Folder"  -ForegroundColor Green
        $Null = New-Item -Path $BuildFolder -Type Directory -Force
    }
    Write-Host "Creating Version Folder"  -ForegroundColor Green
    $Null = New-Item -Path $VersionFolder -Type Directory -Force

    Write-Host "Copying $ModuleName Module Manifest"  -ForegroundColor Green
    $Null = Copy-Item -Path "$ProjectRoot\Source\$ModuleName.psd1" -Destination "$VersionFolder\$ModuleName.psd1" -Force

    Write-Host "Copying $ModuleName Module "  -ForegroundColor Green
    $Null = Copy-Item   -Path "$ProjectRoot\Source\$ModuleName.psm1" -Destination "$VersionFolder\$ModuleName.psm1" -Force

    Write-Host "Copying Private Functions"  -ForegroundColor Green
    Copy-Item $ProjectRoot\Source\Private $VersionFolder\Private -Force -Recurse

    Write-Host "Copying Public Functions"  -ForegroundColor Green
    Copy-Item $ProjectRoot\Source\Public $VersionFolder\Public -Force -Recurse

    $files = Get-ChildItem -Path "$VersionFolder\Public\*" | Select -ExpandProperty BaseName
    $functions = @()
    $files | % {
        $functions += $_
    }
    Update-ModuleManifest -Path $VersionFolder\$ModuleName.psd1 -FunctionsToExport $functions

    Write-Host "Module built, verifying module output" -ForegroundColor Blue
    Get-Module -ListAvailable "$VersionFolder\$ModuleName.psd1" `
        | ForEach-Object -Process {
        $ExportedFunctions = $_ `
        | Select-Object -Property @{ Name = "ExportedFunctions" ; Expression = { [string[]]$_.ExportedFunctions.Keys } } `
        | Select-Object -ExpandProperty ExportedFunctions
        $ExportedAliases = $_ `
        | Select-Object -Property @{ Name = "ExportedAliases"   ; Expression = { [string[]]$_.ExportedAliases.Keys   } } `
        | Select-Object -ExpandProperty ExportedAliases
        $ExportedVariables = $_ `
        | Select-Object -Property @{ Name = "ExportedVariables" ; Expression = { [string[]]$_.ExportedVariables.Keys } } `
        | Select-Object -ExpandProperty ExportedVariables
        Write-Output "Name              : $($_.Name)"
        Write-Output "Description       : $($_.Description)"
        Write-Output "Guid              : $($_.Guid)"
        Write-Output "Version           : $($_.Version)"
        Write-Output "ModuleType        : $($_.ModuleType)"
        Write-Output "ExportedFunctions : $ExportedFunctions"
        Write-Output "ExportedAliases   : $ExportedAliases"
        Write-Output "ExportedVariables : $ExportedVariables"
    }

}

task zip -depends build {
    if (-not (Test-path $ZipFolder)) {
        $null = New-Item $ZipFolder -Type Directory -Force
    }
    else {
        Remove-Item $ZipFolder\* -Force
    }
    $files = Get-ChildItem "$BuildFolder\..\"
    Compress-Archive -Path $files -DestinationPath $Zipfile -Force
}