# testing psInlineProgress
$null = Start-Transcript -Path C:\users\grave\Scripts\InlineProgressBar\transcript.txt
Write-Host ''
$PSCommandPath
# Simple progressBar
Write-Host 'Example of default behaviour' -ForegroundColor Magenta
Write-Host ''

$collection = 0..12
$count = 0
foreach ($item in $collection) {
    $count++
    $percentComplete = ($count / $collection.Count) * 100
    Write-InlineProgress -Activity "Processing item #$($item)" -PercentComplete $percentComplete

    Start-Sleep -Milliseconds (Get-Random -Minimum 160 -Maximum 400)
}
Write-InlineProgress -Activity 'Finished processing all items' -Complete -UseWriteOutput
Write-Host ''

# ProgressBar with more information
Write-Host 'Example with SecondsRemaining and SecondsElapsed' -ForegroundColor Magenta
Write-Host ''

$collection = 0..12
$count = 0
$start = Get-Date
$secondsRemaining = 0
$secondsElapsed = 0
foreach ($item in $collection) {
    $count++
    $percentComplete = ($count / $collection.Count) * 100
    Write-InlineProgress -Activity "Processing item #$($item)" -PercentComplete $percentComplete -SecondsRemaining $secondsRemaining -SecondsElapsed $secondsElapsed.TotalSeconds

    Start-Sleep -Milliseconds (Get-Random -Minimum 160 -Maximum 400)

    # calculating seconds elapsed and remaining
    $secondsElapsed = (Get-Date) - $start
    $secondsRemaining = ($secondsElapsed.TotalSeconds / $count) * ($collection.Count - $count)
    if ($secondsRemaining -lt 0) {
        $secondsRemaining = 0
    }
}
Write-InlineProgress -Activity 'Finished processing all items' -Complete -UseWriteOutput -SecondsRemaining 0 -SecondsElapsed $secondsElapsed.TotalSeconds
Write-Host ''

# Simple progressBar without Percent
Write-Host 'Example of progress bar without percent' -ForegroundColor Magenta
Write-Host ''

$collection = 0..12
$count = 0
foreach ($item in $collection) {
    $count++
    $percentComplete = ($count / $collection.Count) * 100
    Write-InlineProgress -Activity "Processing item #$($item)" -PercentComplete $percentComplete -ShowPercent:$false

    Start-Sleep -Milliseconds (Get-Random -Minimum 160 -Maximum 400)
}
Write-InlineProgress -Activity 'Finished processing all items' -Complete -UseWriteOutput -ShowPercent:$false
Write-Host ''

# With error handling
Write-Host 'Example of error handling' -ForegroundColor Magenta
Write-Host ''

$collection = 0..12
$count = 0
$error = $false
foreach ($item in $collection) {
    $count++
    $percentComplete = ($count / $collection.Count) * 100
    Write-InlineProgress -Activity "Processing item #$($item)" -PercentComplete $percentComplete

    try {
        if ($item -eq 9) {
            throw 'ERROR HAPPENED!'
        }
        else {
            Start-Sleep -Milliseconds (Get-Random -Minimum 160 -Maximum 400)
        }
    }
    catch {
        Write-InlineProgress -Stop -OutputLastProgress
        $error = $true
        $errorMessage = $_.Exception.Message
        break
    }
}
if (-not $error) {
    Write-InlineProgress -Activity 'Finished processing all items' -Complete
}
else {
    # workaround: this Write-Host is needed to be sure that the warning is written on the next line
    Write-Host ''
    Write-Warning $errorMessage
}
Write-Host ''
$null = Stop-Transcript

# customized progress bar
Write-Host 'Examples of customized progress bars' -ForegroundColor Magenta
Write-Host ''

$collection = 0..12
$count = 0
foreach ($item in $collection) {
    $count++
    $percentComplete = ($count / $collection.Count) * 100
    Write-InlineProgress -Activity "Processing item #$($item)" -PercentComplete $percentComplete -ProgressCharacter ([char]9632) -ProgressFillCharacter ([char]9632) -ProgressFill ([char]183) -BarBracketStart $null -BarBracketEnd $null

    Start-Sleep -Milliseconds (Get-Random -Minimum 160 -Maximum 400)
}
Write-InlineProgress -Activity 'Finished processing all items' -Complete -ProgressCharacter ([char]9632) -ProgressFillCharacter ([char]9632) -ProgressFill ([char]183) -BarBracketStart $null -BarBracketEnd $null

$collection = 0..30
$count = 0
foreach ($item in $collection) {
    $count++
    $percentComplete = ($count / $collection.Count) * 100
    Write-InlineProgress -Activity "Processing item #$($item)" -PercentComplete $percentComplete -ProgressCharacter ([char]9608) -ProgressFillCharacter ([char]9608) -ProgressFill ([char]183) -BarBracketStart '|' -BarBracketEnd '|'

    Start-Sleep -Milliseconds (Get-Random -Minimum 160 -Maximum 400)
}
Write-InlineProgress -Activity 'Finished processing all items' -Complete -ProgressCharacter ([char]9608) -ProgressFillCharacter ([char]9608) -ProgressFill ([char]183) -BarBracketStart '|' -BarBracketEnd '|'

$collection = 0..12
$count = 0
foreach ($item in $collection) {
    $count++
    $percentComplete = ($count / $collection.Count) * 100
    Write-InlineProgress -Activity "Processing item #$($item)" -PercentComplete $percentComplete -ProgressCharacter ([char]9472) -ProgressFillCharacter ([char]9608) -ProgressFill "-"

    Start-Sleep -Milliseconds (Get-Random -Minimum 160 -Maximum 400)
}
Write-InlineProgress -Activity 'Finished processing all items' -Complete -ProgressCharacter ([char]9472) -ProgressFillCharacter '-' -ProgressFill ([char]9608)

$collection = 0..12
$count = 0
foreach ($item in $collection) {
    $count++
    $percentComplete = ($count / $collection.Count) * 100
    Write-InlineProgress -Activity "Processing item #$($item)" -PercentComplete $percentComplete -ProgressCharacter '-' -ProgressFillCharacter '|' -ProgressFill '\'  -BarBracketStart '|' -BarBracketEnd '|'

    Start-Sleep -Milliseconds (Get-Random -Minimum 160 -Maximum 400)
}
Write-InlineProgress -Activity 'Finished processing all items' -Complete -ProgressCharacter '-' -ProgressFillCharacter '|' -ProgressFill '\'  -BarBracketStart '|' -BarBracketEnd '|'

$collection = 0..12
$count = 0
foreach ($item in $collection) {
    $count++
    $percentComplete = ($count / $collection.Count) * 100
    Write-InlineProgress -Activity "Processing item #$($item)" -PercentComplete $percentComplete -ProgressCharacter 'C' -ProgressFillCharacter '.' -ProgressFill 'o'

    Start-Sleep -Milliseconds (Get-Random -Minimum 160 -Maximum 400)
}
Write-InlineProgress -Activity 'Finished processing all items' -Complete -ProgressCharacter 'C' -ProgressFillCharacter '.' -ProgressFill 'o'


Write-host ''