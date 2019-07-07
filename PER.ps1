$collection = 0..30
$count = 0
foreach ($item in $collection) {
    $count++
    $percentComplete = ($count / $collection.Count) * 100
    Write-InlineProgress -Activity "Processing item #$($item)" -PercentComplete $percentComplete -ProgressCharacter ([char]9608) -ProgressFillCharacter ([char]9608) -ProgressFill ([char]183) -BarBracketStart '|' -BarBracketEnd '|'

    Start-Sleep -Milliseconds (Get-Random -Minimum 160 -Maximum 400)
}
Write-InlineProgress -Activity 'Finished processing all items' -Complete -ProgressCharacter ([char]9608) -ProgressFillCharacter ([char]9608) -ProgressFill ([char]183) -BarBracketStart '|' -BarBracketEnd '|'
[System.Console]::ForegroundColor="White"