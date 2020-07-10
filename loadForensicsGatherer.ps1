# Test that Pester exists
$pester = Get-Module -ListAvailable -Name "Pester"

if($pester -eq $null){
    Write-Verbose "Downloading and installing Pester"
    Import-Module -Name Pester
}

# Make sure that Windows Remote Management is up and running

