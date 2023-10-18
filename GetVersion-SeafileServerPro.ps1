$ErrorActionPreference = "Stop"

$json = Invoke-RestMethod 'https://docker.seafile.top/api/v2.0/projects/seafileltd/repositories/seafile-pro-mc/artifacts/latest/tags?page=1&page_size=1'

$verison = $json[0].name
Write-Output $verison
