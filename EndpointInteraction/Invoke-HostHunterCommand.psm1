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
        [Parameter][switch]$DomainCommand
    )

    # Set up the output variable
    $output = @{
        "HostHunterObject" = "Invoke-HostHunterCommand"
        "DateTime" = (Get-Date).ToString()
        "CommandRun" = $Scriptblock
        "Target" = $Target
    }

    # If connection type is a session, create the session
    if($ConnectionType -eq "Session"){
        $session = New-PSSession -ComputerName $Target -Credential $creds
    }

    # If the data type is a PSSession, the command can be passed straight into the session. This reduces the number of forensic artefacts from the framework for forming new connections
    $runcommand = Invoke-Command -Session $Target -ScriptBlock $Scriptblock
    $output.Add("Outcome", $runcommand)
    
    Write-Output $output
}