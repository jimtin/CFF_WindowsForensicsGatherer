# Get the environment variables to run against the target
$target = $env:TARGET
$playbook = $env:PLAYBOOK
$username = $env:USER
$securestring = ConvertTo-SecureString -String $env:UPASS -AsPlainText -Force

# Write information to the commandline for reference
Write-Host $username
Write-Host $securestring

# Construct the Credential object
[pscredential]$creds = New-Object System.Management.Automation.PSCredential($username, $securestring) 

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
