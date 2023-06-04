$ErrorActionPreference = "Stop"

$json = Invoke-RestMethod 'https://api.github.com/repos/JustArchiNET/ArchiSteamFarm/releases/latest'
$verison = $json.tag_name.Trim('v')
Write-Output $verison
