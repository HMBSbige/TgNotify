$ErrorActionPreference = "Stop"

$json = Invoke-RestMethod -Headers $headers 'https://update.freenas.org/scale/TrueNAS-SCALE-Bluefin/manifest.json'
$verison = $json.version
Write-Output $verison
