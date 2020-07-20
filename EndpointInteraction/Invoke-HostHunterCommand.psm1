function Invoke-HostHunterCommand {
    <#
    .SYNOPSIS
    Core of the endpoint interaction functions. Uses a combination of sessions, Invoke-Commands, jobs and so on to enable framework to operate at scale

    .DESCRIPTION
    To be updated
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]$Scriptblock, 
        [Parameter(Mandatory=$true)]$Target,
        [Parameter()]$ConnectionType = "Session",
        [Parameter()][switch]$Playbook
    )

    # Set up the output variable
    $output = @{
        "HostHunterObject" = "Invoke-HostHunterCommand"
        "DateTime" = (Get-Date).ToString()
        "CommandRun" = $Scriptblock
        "Target" = $Target
    }

    # If connection type is a session, check if the session exists, if not create it
    if($ConnectionType -eq "Session"){
        # Check if the session already exists
        $session = Get-PSSession -ComputerName $Target

        if ($session -eq $null){
            # Add the Target to the TrustedHosts registry key
            Set-Item WSMan:\localhost\Client\TrustedHosts $Target -Force
            # Create the session
            $session = New-PSSession -ComputerName $Target -Credential $creds
        }

        # Now run the Scriptblock against it
        $runcommand = Invoke-Command -Session $session -ScriptBlock $Scriptblock
        $output.Add("Outcome", $runcommand)
        
    }

    # If the data type is a PSSession, the command can be passed straight into the session. This reduces the number of forensic artefacts from the framework for forming new connections
    Write-Output $output
}