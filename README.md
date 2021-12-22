# Docker VPN Setup for openfortivpn.

Raw instructions (work in progress).

A VM is deployed on the PC, a container is deployed in the VM and then you are able to use SSH and DNS directly from you PC via the VM and container when the VPN connection in the container is established.

# PC
1. Deploy a Linux VM on your PC.
2. Copy the content of the ssh-config file to your .ssh/config and modify it to your needs.
3. Install dnsmasq on your PC and use the PC-dnsmasq.conf. Restart and enable dnsmasq.

# VM
1. Install docker-ce on the VM.
2. Install dnsmasq on the VM and use the VM-dnsmasq.conf, restart and enable dnsmasq.
3. Download and place the following files in the same directory, Dockerfile, openfortivpn.config, sudo-rules and Container-dnsmasq.conf.
4. Build the docker image with "docker build -t openfortivpn .".
5. Launch a container with "docker run -td --privileged -p 2223:22 -p 5353:53/udp -h <hostname> --name <container-name> openfortivpn".

# Container
1. SSH to the docker container, edit /etc/openfortivpn/config.
2. Start a bash shell in screen: "screen -S vpn bash"
3. Execute "openfortivpn" to establish a VPN connection and detach form the screen session.
4. Start dnsmasq with "/usr/sbin/dnsmasq -C /etc/dnsmasq.conf".


Now you should be able to SSH and do DNS queries to some-server-hostname.domain.tld directly from your PC.
