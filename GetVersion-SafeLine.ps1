$ErrorActionPreference = "Stop"

$json = Invoke-RestMethod 'https://waf-ce.chaitin.cn/release/latest/version.json'

$verison = $json.latest_version.Trim('v')
Write-Output $verison
