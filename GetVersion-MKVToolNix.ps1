$ErrorActionPreference = "Stop"

$content = Invoke-RestMethod 'https://mkvtoolnix.download/doc/NEWS.md'

foreach ($line in $content -split '\n') {
	if ($line.StartsWith('# Version ')) {
		$version = ($line -split ' ')[2]
		Write-Output $version
		break
	}
}
