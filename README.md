# Start ELK Docker Container on Windows

[Elastic.co](https://www.elastic.co/) provides a handy Docker image for the _ELK_ stack ([**E**lasticsearch](https://www.elastic.co/products/elasticsearch) [**L**ogstash](https://www.elastic.co/products/logstash) [**Kibana**](https://www.elastic.co/products/kibana)). The Docker image gets you up and running an ELK system fast.  This script is a quick hack to use the ELK image with other development VMs running with Vagrant and Hyper-V.

## Usage

* Copy the Powershell script to your project folder.
* Change the IP Address variable in the script.

```powershell

$HOST_IP = "192.168.1.67"               # change to the Docker host computer's IP Address

```

* **docker run -p** maps container ports to the host's _localhost_ interface.
* **netsh interface portproxy add v4tov4** maps _localhost_ ports to the external network interface that the Hyper-V VMs can access.
* **New-NetFirewallRule** creates Windows Inbound Firewall rules.

## Resources

* [Elastic stack (ELK) on Docker - Github](https://github.com/deviantony/docker-elk)
* [sebp/elk - Docker Hub](https://hub.docker.com/r/sebp/elk/)
* [Elasticsearch, Logstash, Kibana (ELK) Docker image documentation](https://elk-docker.readthedocs.io/)
* [A Full Stack in One Command](https://www.elastic.co/blog/a-full-stack-in-one-command)
* [Installing the ELK Stack on Docker](https://logz.io/blog/elk-stack-on-docker/)
* [Setup ELK for NGINX logs with Elasticsearch, Logstash, and Kibana](https://pawelurbanek.com/elk-nginx-logs-setup)
