# Load powershell modules
$modules = Get-Content C:\WindowsForensicsGatherer\CFF_WindowsForensicsGatherer-master\manifest.txt

foreach ($cmdlet in $modules){
    Write-Host $cmdlet
    Import-Module -Name $cmdlet -Force
}
