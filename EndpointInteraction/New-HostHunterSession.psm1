function New-HostHunterSession{
    <#
    .SYNOPSIS
    Creates a session on the target endpoint as the container is created. Ensures deployment of forensic gathering toolkit is rapid.

    .DESCRIPTION
    Creates a session on the target endpoint and returns a session object
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]$Target,
        [Parameter(Mandatory=$true)][System.Management.Automation.PSCredential]$Credential
    )

    # Set up the the output variable
    $output = @{
        "HostHunterObject" = "New-HostHunterSession"
        "DateTime" = (Get-Date).ToString()
        "Target" = $Target
    }

    # Update the Trusted Hosts registry key for this target
    Set-Item WSMan:\localhost\Client\TrustedHosts $Target -Force

    # Create the session
    $session = New-PSSession -ComputerName $Target -Credential $Credential
    $output.Add("SessionObject", $session)

    #Confirm the session has been created
    $sessionid = $session.Id
    $testsession = Get-PSSession -Id $sessionid
    if($testsession -ne $null){
        $output.Add("SessionCreationOutcome", $true)
    }else {
        $output.Add("SessionCreationOutcome", $false)
    }

    # Return output to users
    Write-Output $output

}