# Test that Pester exists
$pester = Get-Module -ListAvailable -Name "Pester"

if($pester -eq $null){
    Write-Verbose "Downloading and installing Pester"
    Import-Module -Name Pester
}

# Write-Information -InformationAction Continue -MessageData "Pester Installed"

$target = $args[0]

Write-Host $target