Write-Host "start ELK containter and map ports to expose on the network..."

$HOST_IP = "192.168.1.67"               # change to the Docker host computer's IP Address

Write-Host "Show portproxy mappings..."
netsh interface portproxy show all
Read-Host "Press Enter to continue..."
#
# Remove existing port mappings
#
Write-Host "Remove existing port mappings..."
netsh interface portproxy delete v4tov4 listenport=5044 listenaddress=$HOST_IP
netsh interface portproxy delete v4tov4 listenport=5601 listenaddress=$HOST_IP
netsh interface portproxy delete v4tov4 listenport=9200 listenaddress=$HOST_IP
#
# Start Docker container
#     Forward ports from the container to the host computer on localhost interface
#     Ports 5044, 5601 & 9200
#
Write-Host "Check if elk container exists..."
if (docker ps -a | grep elk) {
    Write-Host "Docker elk container exists"
    Write-Host "Starting Docker / ELK..."
    docker start elk
} else {
    Write-Host "Docker elk container does not exist"
    Write-Host "Running Docker / ELK..."
    docker run --name elk -p 127.0.0.1:5044:5044 -p 127.0.0.1:5601:5601 -p 127.0.0.1:9200:9200 sebp/elk 
}
Read-Host -Prompt "Press Enter to continue"
#
# portproxy Docker forward ports
# host computer IP address
#
Write-Host "Set portproxy rules"
netsh interface portproxy add v4tov4 listenport=5044 listenaddress=$HOST_IP connectaddress=localhost connectport=5044
netsh interface portproxy add v4tov4 listenport=5601 listenaddress=$HOST_IP connectaddress=localhost connectport=5601
netsh interface portproxy add v4tov4 listenport=9200 listenaddress=$HOST_IP connectaddress=localhost connectport=9200
#
# Add firewall exceptions for ports 5044, 5601 & 9200
#
Write-Host "Set firewall rules"
New-NetFirewallRule -DisplayName "ELK / Docker Logstash" -Direction Inbound -LocalPort 5044 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "ELK / Docker Kibana" -Direction Inbound -LocalPort 5601 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "ELK / Docker ElasticSearch" -Direction Inbound -LocalPort 9200 -Protocol TCP -Action Allow

docker ps -a
