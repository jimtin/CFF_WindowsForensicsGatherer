# Get the hostname and IP of this endpoint
$netipaddress = Get-NetIPAddress | select IPAddress, InterfaceAlias

Write-Host $netipaddress

# Pass the computername into the container. It does seem a little recursive in nature but is important
docker run -e Target=$env:COMPUTERNAME -e Playbook="CITests" -t windowsforensicsgatherer
