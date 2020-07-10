# Get the environment variables to run against the target
$target = $env:TARGET
$playbook = $env:PLAYBOOK

$message = "Running playbook " + $playbook + " against " + $target
Write-Information -InformationAction Continue -MessageData $message

# Get the current IP address
$ipaddress = Get-NetIPAddress
Write-Host $ipaddress

Invoke-Pester "C:\\WindowsForensicsGatherer\\CFF_WindowsForensicsGatherer-master\\Tests\\inittest.Tests.ps1"