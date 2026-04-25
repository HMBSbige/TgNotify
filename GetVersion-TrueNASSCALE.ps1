$ErrorActionPreference = 'Stop'

$trainsData = Invoke-RestMethod 'https://update.freenas.org/scale/trains_v2.json'

$latestVersion = $trainsData.trains.PSObject.Properties | Where-Object {
    $description = $_.Value.description
    $stableProperty = $_.Value.PSObject.Properties['stable']

    $description -notmatch '\b(BETA|RC|Nightlies)\b|\[developer only\]|end of life' -and
    (-not $stableProperty -or $stableProperty.Value -ne $false)
} | ForEach-Object {
    $manifest = Invoke-RestMethod "https://update.freenas.org/scale/$($_.Name)/manifest.json"

    [PSCustomObject]@{
        Version     = [version]$manifest.version
        VersionText = $manifest.version
    }
} | Sort-Object Version -Descending | Select-Object -First 1 -ExpandProperty VersionText

if (-not $latestVersion) {
    exit 0
}

Write-Output $latestVersion
