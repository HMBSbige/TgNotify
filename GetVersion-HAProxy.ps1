$ErrorActionPreference = "Stop"

$json = Invoke-RestMethod 'https://hub.docker.com/v2/repositories/library/haproxy/tags?name=alpine&ordering=last_updated'

$versions = @()

foreach ($item in $json.results) {
	if (-not $item.name.EndsWith('-alpine')) {
		continue
	}

	if (($item.name -split '-').Count -ne 2) {
		continue
	}

	$str = ($item.name -split '-')[0]

	$version = $null
	if ([Version]::TryParse($str, [ref] $version)) {
		$versions += $version
	}
}

$versions = $versions | Sort-Object -Descending
Write-Output $versions[0].ToString()
