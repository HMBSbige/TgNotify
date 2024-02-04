$ErrorActionPreference = "Stop"

$json = Invoke-RestMethod 'https://docker.seafile.top/api/v2.0/projects/seafileltd/repositories/seafile-pro-mc/artifacts/latest/tags'

foreach ($item in $json) {
	$version = $null
	if ([Version]::TryParse($item.name, [ref] $version)) {
		Write-Output $version.ToString()
		exit 0
	}
}
