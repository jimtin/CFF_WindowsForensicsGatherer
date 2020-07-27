# Load powershell modules
$modules = Get-Content C:\WindowsForensicGatherer\CFF_WindowsForensicsGatherer-master\manifest.txt

foreach ($cmdlet in $modules){
    Import-Module -Name $cmdlet -Force
}
