$ErrorActionPreference = 'Stop'

$trainsData = Invoke-RestMethod 'https://update.freenas.org/scale/trains.json'

$activeTrains = $trainsData.trains.PSObject.Properties | Where-Object {
    $_.Value.description.Contains('[release]') -and !$_.Value.description.Contains('end of life')
}

if (-not $activeTrains) {
    exit 0
}

$activeTrainsWithVersions = $activeTrains | ForEach-Object {
    $versionMatch = [regex]::Match($_.Value.description, '(\d+\.\d+)')
    if (-not $versionMatch.Success) {
        throw "Failed to parse version from: $($_.Value.description)"
    }
    
    [PSCustomObject]@{
        Name    = $_.Name
        Version = [version]$versionMatch.Groups[1].Value
    }
}

$train = ($activeTrainsWithVersions | Sort-Object Version -Descending | Select-Object -First 1).Name

$json = Invoke-RestMethod "https://update.freenas.org/scale/$train/manifest.json"
$verison = $json.version
Write-Output $verison
