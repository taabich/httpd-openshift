FROM registry.access.redhat.com/ubi9/openjdk-17:1.18-1

USER 0
RUN microdnf install -y gzip xmlstarlet

WORKDIR /app

RUN curl -L -O https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.26/bin/apache-tomcat-10.1.26.tar.gz
RUN tar xzvf apache-tomcat-10.1.26.tar.gz

RUN chown -R default:root /app
RUN chmod g+rw -R /app
RUN find /app -type d -exec chmod g+x {} \;
EXPOSE 8080/tcp
EXPOSE 8009/tcp
EXPOSE 8443/tcp

RUN cd /app/apache-tomcat-10.1.26/webapps/ && \
    curl -L -O https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war

USER default
CMD ["/app/apache-tomcat-10.1.26/bin/catalina.sh", "run"]
