$ErrorActionPreference = "Stop"

$headers = @{
	Authorization = "Bearer $env:GITHUB_TOKEN"
}

$json = Invoke-RestMethod -Headers $headers 'https://api.github.com/repos/JustArchiNET/ArchiSteamFarm/releases/latest'
$verison = $json.tag_name.Trim('v')
Write-Output $verison
