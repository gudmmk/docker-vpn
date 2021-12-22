FROM debian:latest

RUN apt update
RUN apt install -y openssh-server sudo screen vim-nox openfortivpn dnsmasq net-tools \
                   inetutils-ping lsof wget curl telnet dnsutils screen vim-nox \
                   openfortivpn dnsmasq
RUN useradd -rm -d /home/<username> -s /bin/bash -g root -G sudo -u 1000 <username>
RUN usermod -aG sudo <username>
RUN service ssh start
RUN echo '<somepass>:<somepass>' | chpasswd

COPY dnsmasq.conf /etc/
COPY openfortivpn.config /etc/openfortivpn/config
COPY sudo-<username> /etc/sudoers.d/

EXPOSE 2222

CMD ["/usr/sbin/sshd","-D"]
