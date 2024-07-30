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
ADD context.xml /opt/tomcat/webapps/manager/META-INF/context.xml
ADD context.xml /opt/tomcat/webapps/host-manager/META-INF/context.xml



RUN chown -R tomcat: /opt/tomcat
RUN chmod -R g+r /opt/tomcat
RUN chmod g+x /opt/tomcat/conf
RUN chmod -R a+xr /opt/tomcat/bin



EXPOSE 8080/tcp
EXPOSE 8009/tcp
EXPOSE 8443/tcp




USER tomcat
ENV JAVA_HOME /usr/lib/jvm/jre
ENV CATALINA_PID /opt/tomcat/temp/tomcat.pid
ENV CATALINA_HOME /opt/tomcat
ENV CATALINA_BASE /opt/tomcat
ENV JAVA_OPTS -Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom
WORKDIR /opt/tomcat

RUN chmod -R 777 temp logs work 

CMD ["/opt/tomcat/bin/catalina.sh", "start"]


