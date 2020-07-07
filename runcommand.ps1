param(
    [Parameter(Mandatory=$true)]$Target,
    $playbook="FullData"
)

$message = "Running playbook " + $playbook + " against " + $target
Write-Information -InformationAction Continue -MessageData $message