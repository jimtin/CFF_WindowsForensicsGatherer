# Install Pester
Install-Module Pester -Force -SkipPublisherCheck

# Remove old version of pester
Remove-Item "C:\Program Files (x86)\WindowsPowerShell\Modules\Pester\3.4.0" -Recurse -Force