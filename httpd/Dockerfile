FROM rockylinux:9


# Systemd install
RUN dnf -y update && dnf clean all; \
rm -f /lib/systemd/system/multi-user.target.wants/*; \
rm -f /etc/systemd/system/*.wants/*; \
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*; \
rm -f /lib/systemd/system/anaconda.target.wants/*;


RUN dnf -y install sudo \
	tar \
	gzip \
	openssh-clients \
	vi \
    && dnf clean all

RUN groupadd apacheg
RUN useradd  -g apacheg -d /opt/apacheg apacheu
RUN echo "%apacheg ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN dnf -y update && dnf -y upgrade && dnf -y install httpd

ADD httpd-foreground /usr/local/bin/httpd-foreground
RUN systemctl enable httpd.service

RUN chmod a+x /usr/local/bin/httpd-foreground


CMD ["/usr/local/bin/httpd-foreground"]

