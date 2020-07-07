# Get the environment variables to run against the target
$target = $env:Target
$playbook = $env:Playbook

$message = "Running playbook " + $playbook + " against " + $target
Write-Information -InformationAction Continue -MessageData $message