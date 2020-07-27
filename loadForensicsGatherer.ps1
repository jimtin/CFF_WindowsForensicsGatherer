# Load powershell modules
$modules = Get-Content -Path .\manifest.txt

foreach ($cmdlet in $modules){
    Import-Module -Name $cmdlet -Force
}
