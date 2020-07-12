# Get the hostname and IP of this endpoint
$netipaddress = Get-NetIPAddress | Where-Object {$_.InterfaceAlias -eq "Ethernet"}
$netipaddress = $netipaddress | Where-Object {$_.AddressFamily -eq "IPv4"}

# Pass the computername into the container. It does seem a little recursive in nature but is important
docker run -e Target=$env:COMPUTERNAME -e Playbook="CITests" -t windowsforensicsgatherer