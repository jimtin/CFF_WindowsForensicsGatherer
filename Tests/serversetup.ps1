# Install Pester
Install-Module Pester -Force -SkipPublisherCheck
$version = Get-InstalledModule -Name Pester
Write-Host $version