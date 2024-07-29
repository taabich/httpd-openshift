FROM rockylinux:9


RUN dnf -y update && dnf -y install \
	sudo \
	tar \
	gzip \
	openssh-clients \
	java-17-openjdk \
	vi \
  && rm -rf /var/cache/yum*


RUN groupadd tomcat
RUN useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat


RUN mkdir -p /opt/app
RUN chmod -R 777 /opt/app
RUN chmod -R 777 /opt/tomcat

WORKDIR /tmp
ADD https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.0-M22/bin/apache-tomcat-11.0.0-M22.tar.gz /tmp/

RUN tar xzvf /tmp/apache-tomcat-*tar.gz -C /opt/tomcat --strip-components=1

RUN rm /tmp/apache*


ADD tomcat-users.xml /opt/tomcat/conf
ADD tomcat.service  /etc/systemd/system/tomcat.service
ADD context.xml /opt/tomcat/webapps/manager/META-INF/context.xml
ADD context.xml /opt/tomcat/webapps/host-manager/META-INF/context.xml



RUN chown -R tomcat: /opt/tomcat
RUN chmod -R g+r /opt/tomcat
RUN chmod g+x /opt/tomcat/conf
RUN chmod -R a+xr /opt/tomcat/bin

RUN mkdir -p /opt/tomcat/logs
RUN chmod -R g+rwx /opt/tomcat/logs
RUN chmod -R g+rwx /opt/tomcat/webapps




EXPOSE 8080/tcp
EXPOSE 8009/tcp
EXPOSE 8443/tcp

RUN systemctl enable tomcat



VOLUME "/opt/tomcat/webapps"

ENV JAVA_HOME /usr/lib/jvm/jre
ENV CATALINA_PID /opt/tomcat/temp/tomcat.pid
ENV CATALINA_HOME /opt/tomcat
ENV CATALINA_BASE /opt/tomcat
ENV JAVA_OPTS -Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom
#WORKDIR /opt/tomcat
#Lanzar Tomcat


RUN [ ! -f /usr/sbin/init ] && dnf -y install systemd;
RUN ([ -d /lib/systemd/system/sysinit.target.wants ] && cd /lib/systemd/system/sysinit.target.wants/ && for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]