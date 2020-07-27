$username = $args[0]
$password = $args[1]
$target = $args[2]

# Pass the computername into the container. It does seem a little recursive in nature but is important
docker run -e Target=$target -e Playbook="CITests" -e USER=$username -e UPASS=$password -t cff_windowsforensicsgatherer
