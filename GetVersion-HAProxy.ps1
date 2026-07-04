$ErrorActionPreference = "Stop"

$json = Invoke-RestMethod 'https://hub.docker.com/v2/repositories/library/haproxy/tags?name=alpine&ordering=last_updated&page=1&page_size=100'

$latestVersion = $null

foreach ($item in $json.results) {
	if (-not $item.name.EndsWith('-alpine')) {
		continue
	}

	$tagParts = $item.name -split '-'
	if ($tagParts.Count -ne 2) {
		continue
	}

	$version = $null
	if ([Version]::TryParse($tagParts[0], [ref] $version) -and ($null -eq $latestVersion -or $version -gt $latestVersion)) {
		$latestVersion = $version
	}
}

Write-Output $latestVersion.ToString()
