$ErrorActionPreference = "Stop"

$headers = @{
	Authorization = "Bearer $env:GITHUB_TOKEN"
}

$content = Invoke-RestMethod -Headers $headers 'https://raw.githubusercontent.com/haiwen/seafile-admin-docs/master/manual/changelog/client-changelog.md'

foreach ($line in $content -split '\n') {
	if ($line.StartsWith('### ')) {
		$version = ($line -split ' ')[1]
		Write-Output $version
		break
	}
}
