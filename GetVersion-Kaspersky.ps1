$ErrorActionPreference = "Stop"

$url = 'https://api-router.kaspersky-labs.com/downloads/search/v3/b2c?productcodes=5003617&businesspurposes=Update&licensetiers=Free&sites=https%3A%2F%2Fwww.kaspersky.com'
try {
	$json = Invoke-RestMethod $url
} catch {
	$errorText = if ($_.ErrorDetails.Message) { $_.ErrorDetails.Message } else { $_.Exception.Message }
	$errorBody = if ($errorText.TrimStart().StartsWith('{')) { $errorText | ConvertFrom-Json }
	if ($errorBody.errCode -eq 'IP_SALES_FORBIDDEN') {
		Write-Warning 'Kaspersky API blocked this runner IP; skipping this check.'
		return
	}

	throw
}

$response = $json[0].response.Windows.Kaspersky4Win.Downloader.'https://www.kaspersky.com'

$latestVersion = $null

foreach ($versionData in $response.PSObject.Properties.Value) {
	foreach ($locale in $versionData.PSObject.Properties.Value) {
		$version = [Version]"$($locale.VersionNumberMajor).$($locale.VersionNumberMinor).$($locale.VersionNumberBuild).$($locale.VersionNumberRevision)"

		if ($null -eq $latestVersion -or $version -gt $latestVersion) {
			$latestVersion = $version
		}
	}
}

Write-Output $latestVersion.ToString()
