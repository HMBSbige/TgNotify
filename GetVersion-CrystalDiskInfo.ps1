$ErrorActionPreference = "Stop"

$headers = @{
	Authorization = "Bearer $env:GITHUB_TOKEN"
}

$content = Invoke-RestMethod -Headers $headers 'https://raw.githubusercontent.com/hiyohiyo/CrystalDiskInfo/master/Library/stdafx.h'

foreach ($line in $content -split '\n') {
	if ($line.Contains('PRODUCT_VERSION')) {
		$version_str = ($line.Split())[-1].TrimStart('L').Trim('"')
		$version = $null
		if (-not[Version]::TryParse($version_str, [ref]$version)) {
			exit 0
		}
		Write-Output $version.ToString()
		break
	}
}
