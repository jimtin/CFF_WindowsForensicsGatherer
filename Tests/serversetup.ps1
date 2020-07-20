# Install Pester
Install-Module Pester -Force -SkipPublisherCheck

# Remove old version of pester
Remove-Item "C:\Program Files (x86)\WindowsPowerShell\Modules\Pester\3.4.0" -Recurse -Force

# Set the TrustedHosts Registry key to *. This is not great security practice, but for the purposes of testing is fine
Set-Item WSMan:\localhost\Client\TrustedHosts * -Force