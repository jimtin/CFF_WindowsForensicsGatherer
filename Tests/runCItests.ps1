# Get the IP of this endpoint
$netipaddress = Get-NetIPAddress | Where-Object {$_.InterfaceAlias -eq "Ethernet"}
$netipaddress = $netipaddress | Where-Object {$_.AddressFamily -eq "IPv4"}
# Turn it into a string
$netipaddress = $netipaddress.ToString()
Write-Host $netipaddress

# Pass the computername into the container. It does seem a little recursive in nature but is important
docker run -e Target=$netipaddress -e Playbook="CITests" -t windowsforensicsgatherer
