oc delete all -l app=tomcat-server
oc delete template tomcat-server
oc create -f tomcat9.yaml
oc new-app tomcat-server --env-file=env-tomcat.properties
