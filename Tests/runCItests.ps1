# Get the IP of this endpoint
#$netipaddress = Get-NetIPAddress | select AddressFamily, InterfaceAlias, IPaddress
#$netipaddress = Get-NetIPAddress | Where-Object {$_.InterfaceAlias -eq "vEthernet (nat)"}
#$netipaddress = $netipaddress | Where-Object {$_.AddressFamily -eq "IPv4"}
# Turn it into a string
# $netipaddress = $netipaddress.ToString()
$netipaddress = ($env:COMPUTERNAME).ToString()

# Pass the computername into the container. It does seem a little recursive in nature but is important
$pass = ($env:COMPUTERNAME).ToString()
docker run -e Target=$netipaddress -e Playbook="CITests" -e USER="TestAdministrator" -e UPASS=$pass -t windowsforensicsgatherer
