# Get the environment variables to run against the target
$target = $env:TARGET
$playbook = $env:PLAYBOOK

$message = "Running playbook " + $playbook + " against " + $target
Write-Information -InformationAction Continue -MessageData $message

if($playbook -eq "CITests"){
    Write-Information -InformationAction Continue -MessageData "CI Tests invoked"
    Invoke-Pester "C:\\WindowsForensicsGatherer\\CFF_WindowsForensicsGatherer-master\\Tests\\inittest.Tests.ps1"
}else{
    Write-Information -InformationAction Continue -MessageData "Invalid playbook selected"
}
