$ErrorActionPreference = "Stop"

$headers = @{
	Authorization = "Bearer $env:GITHUB_TOKEN"
}

$json = Invoke-RestMethod -Headers $headers 'https://api.github.com/repos/Dreamacro/clash/releases/tags/premium'
$verison = ( -Split ($json.name))[1]
Write-Output $verison
