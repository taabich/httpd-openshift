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
	vi \
    && dnf clean all
RUN yum install -y initscripts
RUN yum -y install openssh-server openssh-clients && dnf clean all

RUN dnf -y makecache
RUN dnf -y install procps
RUN dnf -y install net-tools



RUN echo "%apache ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN dnf -y update && dnf -y upgrade && dnf -y install httpd

ADD httpd-foreground /usr/local/bin/httpd-foreground
RUN systemctl enable httpd.service

RUN chmod a+x /usr/local/bin/httpd-foreground


RUN sed -i "s/Listen 80/Listen 8080/" /etc/httpd/conf/httpd.conf && \
  chown apache:0 /etc/httpd/conf/httpd.conf && \
  chmod g+r /etc/httpd/conf/httpd.conf && \
  chown apache:0 /var/log/httpd && \
  chmod g+rwX /var/log/httpd && \
  chown apache:0 /var/run/httpd && \
  chmod g+rwX /var/run/httpd
RUN mkdir -p /var/www/html && echo "hello world!" >> /var/www/html/index.html && \
  chown -R apache:0 /var/www/html && \
  chmod -R g+rwX /var/www/html

  RUN sed -i 's/#ServerName.*/ServerName localhost/' /etc/httpd/conf/httpd.conf
  RUN sed -i 's/^#\(Include.*httpd-ssl.conf.*\)/\1/' /etc/httpd/conf/httpd.conf

  EXPOSE 8080
USER apache


CMD ["/usr/local/bin/httpd-foreground"]

