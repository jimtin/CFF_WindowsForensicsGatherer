# Load powershell modules
$modules = Get-Content C:\WindowsForensicsGatherer\CFF_WindowsForensicsGatherer-master\manifest.txt

foreach ($cmdlet in $modules){
    Import-Module -Name $cmdlet -Force
}
