FROM rockylinux:9


RUN dnf -y update && dnf -y install \
	sudo \
	tar \
	gzip \
	openssh-clients \
	java-11-openjdk \
	vi \
  && rm -rf /var/cache/yum*


RUN groupadd tomcat
RUN useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat



WORKDIR /tmp
ADD https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.26/bin/apache-tomcat-10.1.26.tar.gz /tmp/

RUN tar xzvf /tmp/apache-tomcat-*tar.gz -C /opt/tomcat --strip-components=1


ADD tomcat-users.xml /opt/tomcat/conf
ADD context.xml /opt/tomcat/webapps/manager/META-INF/context.xml
ADD context.xml /opt/tomcat/webapps/host-manager/META-INF/context.xml

RUN cd /opt/tomcat; \
	chgrp -R tomcat /opt/tomcat; \
	chmod -R g+r conf; \
	chmod g+x conf; \
	chown -R tomcat /opt/tomcat/webapps/; \
	chown -R tomcat /opt/tomcat/work/; \
	chown -R tomcat /opt/tomcat/temp/; \
	chown -R tomcat /opt/tomcat/logs/

ENV JAVA_HOME /usr/lib/jvm/jre
ENV CATALINA_PID /opt/tomcat/temp/tomcat.pid
ENV CATALINA_HOME /opt/tomcat
ENV CATALINA_BASE /opt/tomcat


EXPOSE 8080/tcp
EXPOSE 8009/tcp
EXPOSE 8443/tcp


VOLUME "/opt/tomcat/webapps"
WORKDIR /opt/tomcat

#Lanzar Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]