$ErrorActionPreference = "Stop"

$json = Invoke-RestMethod -Headers $headers 'https://archlinux.org/packages/core/x86_64/linux-lts/json/'
$verison = $json.pkgver
Write-Output $verison
