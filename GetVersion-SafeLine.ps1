$ErrorActionPreference = "Stop"

$json = Invoke-RestMethod 'https://waf-ce.chaitin.cn/release/latest/version.json'

$version = $json.latest_version.Trim('v')
Write-Output $version
