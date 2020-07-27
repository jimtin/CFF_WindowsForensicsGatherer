$username = $args[0]
$password = $args[1]

Write-Host $username

# Get the IP of this endpoint
$netipaddress = ($env:COMPUTERNAME).ToString()

# Pass the computername into the container. It does seem a little recursive in nature but is important
docker run -e Target=$netipaddress -e Playbook="CITests" -e USER=$username -e UPASS=$password -t cff_windowsforensicsgatherer
