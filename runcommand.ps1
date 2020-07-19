# Get the environment variables to run against the target
$target = $env:TARGET
$playbook = $env:PLAYBOOK

$message = "Running playbook " + $playbook + " against " + $target
Write-Information -InformationAction Continue -MessageData $message

# Construct the credentails
# Set the credentials
$creds = New-Object System.Management.Automation.PSCredential($env:USER, $env:UPASS)

if($playbook -eq "CITests"){
    # Inform user of actions being taken
    Write-Information -InformationAction Continue -MessageData "CI Tests invoked"

    # Write the Target information to the file
    $target | Out-File "C:\\WindowsForensicsGatherer\\CFF_WindowsForensicsGatherer-master\\Tests\\target.txt"

    # Invoke the test script
    Invoke-Pester "C:\\WindowsForensicsGatherer\\CFF_WindowsForensicsGatherer-master\\Tests\\container.Tests.ps1" 
}else{
    Write-Information -InformationAction Continue -MessageData "Invalid playbook selected"
}
