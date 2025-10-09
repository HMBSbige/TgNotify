$ErrorActionPreference = "Stop"

$url = 'https://api-router.kaspersky-labs.com/downloads/search/v3/b2c?productcodes=5003617&businesspurposes=Update&licensetiers=Free&sites=https%3A%2F%2Fwww.kaspersky.com.cn'
$json = Invoke-RestMethod $url

$response = $json[0].response.Windows.Kaspersky4Win.Downloader.'https://www.kaspersky.com.cn'

$latestVersion = $null

foreach ($versionKey in $response.PSObject.Properties.Name) {
	$versionData = $response.$versionKey
	
	foreach ($localeKey in $versionData.PSObject.Properties.Name) {
		$locale = $versionData.$localeKey
		
		$major = $locale.VersionNumberMajor
		$minor = $locale.VersionNumberMinor
		$build = $locale.VersionNumberBuild
		$revision = $locale.VersionNumberRevision
		
		$version = [Version]"$major.$minor.$build.$revision"
		
		if ($null -eq $latestVersion -or $version -gt $latestVersion) {
			$latestVersion = $version
		}
	}
}

Write-Output $latestVersion.ToString()
