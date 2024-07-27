oc delete all -l app=tomcat-server
oc delete template tomcat-server
oc delete resourcequotas compute-resources
oc delete limitranges core-resource-limits
oc delete  persistentvolumeclaims tomcat-data
oc create -f tomcat9.yaml
oc new-app tomcat-server --env-file=env-tomcat.properties
