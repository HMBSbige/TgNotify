$ErrorActionPreference = "Stop"

$headers = @{
	Authorization = "Bearer $env:GITHUB_TOKEN"
}

for ($page = 1; $page -le 10; ++$page) {
	$json = Invoke-RestMethod -Headers $headers "https://api.github.com/repos/DaoCloud/crproxy/releases?per_page=100&page=$page"

	if ($json.Count -eq 0) {
		exit 0
	}
	
	foreach ($item in $json) {
		$version = $null
		$name = $item.tag_name.TrimStart('v')
		if ([Version]::TryParse($name, [ref] $version)) {
			Write-Output $version.ToString()
			exit 0
		}
	}
}
