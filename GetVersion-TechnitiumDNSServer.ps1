$ErrorActionPreference = "Stop"

$json = Invoke-RestMethod 'https://hub.docker.com/v2/repositories/technitium/dns-server/tags?page_size=2&page=1&ordering=last_updated'

foreach ($item in $json.results) {
	$version = $null
	if ([Version]::TryParse($item.name, [ref] $version)) {
		Write-Output $version.ToString()
		exit 0
	}
}
